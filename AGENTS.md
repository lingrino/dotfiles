# AGENTS.md

Guidance for AI coding agents working in this repository.

## Overview

This is a chezmoi-managed dotfiles repository for macOS. The source directory is `home/` (specified in `.chezmoiroot`), which maps to the user's home directory.

## Important

**AI should never run `chezmoi apply` or other chezmoi commands.** Only edit files directly in the `home/` source directory.

## Architecture

### Chezmoi Naming Conventions

Files in `home/` use chezmoi's special prefixes:
- `exact_` - Directory contents are managed exactly (extra files are removed)
- `private_` - Target gets owner-only permissions
- `dot_` - Maps to a leading `.` (e.g., `private_dot_config` → `.config`)
- `create_` - Only written when the target is missing (e.g., less history)
- `empty_` - Keep the file even when empty (an empty file without it means "absent")
- `.tmpl` suffix - File is a Go template processed during apply; a template that renders empty removes the target

### Machine Types

Configuration is templated on the machine name (prompted on first `chezmoi init`):
- **personal** - Personal laptop with the full set of personal apps
- **work** - Work laptop; the only machine with kube tools (kubectl, kubectx, helm, kustomize, kube-ps1), proto/moon, gcloud, and work AWS/git config
- **mini** - Headless mac mini; see below

Templates gate on the machine name directly (e.g. `{{ if eq .machine "mini" }}`).

Template variables defined in `.chezmoi.yaml.tmpl`:
- `.machine` - Machine name ("personal", "work" or "mini")
- `.brewprefix` - Homebrew path (`/opt/homebrew` on ARM, `/usr/local` on Intel)

### Directory Structure

```
home/
├── .chezmoi.yaml.tmpl          # Chezmoi config and machine prompt
├── .chezmoiexternal.toml       # Third-party files (hydro, kube-ps1) pinned to commits
├── .chezmoiignore              # Files to ignore (templated per machine)
├── .chezmoiscripts/            # Pre/post-apply hooks
├── exact_private_dot_config/   # → ~/.config/
│   ├── private_fish/           # Fish shell (conf.d/, functions/, interactive.d/)
│   ├── private_git/            # Git config
│   ├── private_homebrew/       # Brewfile.tmpl includes Brewfile_<machine>
│   └── ...
├── exact_private_dot_ssh/      # SSH config and keys from 1Password
└── fonts/                      # Fonts; deployed to ~/fonts and installed by a script
```

`fonts/usgraphics/` (Berkeley Mono) is gitignored because it is licensed; it is
downloaded and placed there by hand.

### Unmanaged Files Check

`run_before_checks.sh` fails the apply if `chezmoi unmanaged` lists anything, so
every file in `~` must be either managed or in `.chezmoiignore`. When a tool
starts creating a new file or folder in `~`, add it to `.chezmoiignore` (or
redirect it with an env var in `conf.d/`). When a source file is removed from a
directory that is not `exact_`, the old target stays behind and must be deleted
by hand on each machine.

### Homebrew

`run_after_brew.sh` runs `brew bundle` and then `brew bundle cleanup --force
--zap`, so each `Brewfile_<machine>` is the full list of what is installed.
Formulae only needed as dependencies of others should not be listed.

### Apply Scripts (`.chezmoiscripts/`)

`run_after_*` scripts run on every apply, so they must be idempotent and only
call `sudo` when something actually needs changing (read the current state
without sudo first). `run_onchange_*` scripts only rerun when their rendered
content changes.

- `run_before_checks.sh` - Fails if there are unmanaged files
- `run_before_sudo.sh.tmpl` - Enables Touch ID for sudo (and passwordless sudo on mini)
- `run_after_brew.sh` - Updates Homebrew and syncs installs to the Brewfile
- `run_after_bun.sh` - Installs global bun packages
- `run_after_mac.sh.tmpl` - macOS defaults (keyboard, DNS, hostname)
- `run_after_remove.sh` - Removes preinstalled Apple apps
- `run_after_rust.sh.tmpl` - Initializes and updates the Rust toolchain
- `run_after_shells.sh.tmpl` - Adds Fish to /etc/shells and makes it the login shell
- `run_after_tailscale.sh.tmpl` - Tailscale daemon + `tailscale up` (mini only)
- `run_onchange_after_fonts.sh.tmpl` - Installs `fonts/**/*.{ttf,otf}` into ~/Library/Fonts
- `run_onchange_after_restic.sh.tmpl` - Restic backup launchd agent (mini only)
- `run_onchange_after_agent-archiver.sh.tmpl` - Daily agent-archiver launchd agent (mini only)

### Externals and Renovate

`.chezmoiexternal.toml` pins each external to a commit SHA in its URL. A
`# renovate: branch=<name>` comment above each URL lets the custom manager in
`renovate.json` open a PR when that upstream branch moves. Changing the URL is
what makes chezmoi download the new version.

Only hydro's `conf.d/hydro.fish` is downloaded. Its `fish_prompt` is inlined (and
extended) in `conf.d/hydro-config.fish`, so a hydro bump means checking
upstream's `functions/fish_prompt.fish` for changes to port by hand.

### 1Password Integration

Secrets are pulled from 1Password using chezmoi's `onepasswordRead` function in templates:
```
{{ (onepasswordRead "op://dotfiles/item/field") }}
```

Used for: SSH keys and commit signing, the Homebrew GitHub token, work AWS
config, and the mini's restic and agent-archiver credentials.

All machines run `op` in service-account mode (`onepassword.mode: service` in
the chezmoi config, token read from `~/.config/op/service-account-token` into
`OP_SERVICE_ACCOUNT_TOKEN` by the `chezmoi` fish function). The service account
can only read the `dotfiles` vault, so every `op://...` reference must target
the `dotfiles` vault — reads from other vaults (e.g. `op://personal/...`) will
fail.

### Mac Mini (Headless)

The mini has no interactive auth, so it diverges from the laptops:
- Passwordless sudo (`/etc/sudoers.d/lingrino`, installed by `run_before_sudo`)
- SSH auth and commit signing use the on-disk `~/.ssh/mini` key instead of the
  1Password agent; signature verification uses `~/.ssh/allowed_signers`
- Its own, slimmer `Brewfile_mini`
- Hourly restic backups of `~/Documents` and the Photos library to S3 via a
  launchd agent; credentials render from `op://dotfiles/restic` into
  `~/.config/restic/env`; the `restic` fish function wraps the env file
- Daily agent-archiver job (uses Homebrew `bash`, `ffmpeg` and `yt-dlp`)

### Fish Shell Organization

Fish config in `private_fish/`:
- `conf.d/` - Non-interactive environment setup (PATH, env vars)
- `interactive.d/` - Aliases and interactive-only config (sourced from config.fish)
- `functions/` - Fish functions (autoloaded)
- `completions/` - Command completions (ignored; generated at runtime)

### Git Configuration

Commits are SSH-signed (`gpg.format = ssh`): via the 1Password agent on the
laptops and the on-disk key on the mini. `git-delta` is the pager.
