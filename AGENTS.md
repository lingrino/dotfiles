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

Configuration depends on the machine name (chosen once, on the first `chezmoi init`):
- **personal** - Personal laptop with the full set of personal apps
- **work** - Work laptop; the only machine with kube tools (kubectl, kubectx, helm, kustomize) and the prompt's kube context, proto/moon, gcloud, and work AWS/git config
- **mini** - Headless mac mini; see below

How to gate on the machine depends on what differs:
- **A whole file or script** that only exists on some machines stays a plain
  file and is listed in the machine-specific block of `.chezmoiignore` for the
  machines that should not get it. Scripts are matched by target name, without
  the `run_*` prefixes or `.tmpl` (e.g. `.chezmoiscripts/tailscale.sh`). Do not
  wrap a whole file in `{{ if }}`.
- **Content inside a file** every machine has uses a template conditional
  (e.g. `{{ if eq .machine "mini" }}`).

Template variables defined in `.chezmoi.yaml.tmpl`:
- `.machine` - Machine name ("personal", "work" or "mini")
- `.brewprefix` - Homebrew path (`/opt/homebrew` on ARM, `/usr/local` on Intel)

### Directory Structure

```
home/
├── .chezmoi.yaml.tmpl          # Chezmoi config and machine prompt
├── .chezmoiignore              # Files to ignore (templated per machine)
├── .chezmoiscripts/            # Pre/post-apply hooks
├── dot_homebrew/               # → ~/.homebrew/ (brew.env)
├── exact_private_dot_config/   # → ~/.config/
│   ├── private_fish/           # Fish shell (conf.d/, functions/, interactive.d/)
│   ├── private_git/            # Git config
│   ├── private_homebrew/       # Brewfile.tmpl includes Brewfile_<machine>
│   └── ...
├── exact_private_dot_ssh/      # SSH config and keys from 1Password
└── private_Library/            # → ~/Library/ (fonts, key bindings, launchd agents)
```

`~/Library` is ignored apart from the few paths un-ignored in `.chezmoiignore`;
to manage another file there, add it under `private_Library/` and un-ignore it.

`private_Library/private_Fonts/` holds Berkeley Mono, which is gitignored
because it is licensed: download it from <https://usgraphics.com> and put the
font files there by hand on each machine.

### Unmanaged Files Check

`run_before_checks.sh` fails the apply if `chezmoi unmanaged` lists anything, so
every file in `~` must be either managed or in `.chezmoiignore`. When a tool
starts creating a new file or folder in `~`, add it to `.chezmoiignore` (or
redirect it with an env var in `conf.d/`). When a source file is removed from a
directory that is not `exact_`, the old target stays behind and must be deleted
by hand on each machine; the check fails the apply until it is. A leftover
under an ignored path (e.g. `~/Library/Fonts`, or a file that became
machine-gated) is not caught by the check, so remember to delete those.

### Homebrew

`run_after_brew.sh` runs `brew bundle` and then `brew bundle cleanup --force
--zap`, so each `Brewfile_<machine>` is the full list of what is installed.
Formulae only needed as dependencies of others should not be listed.

`HOMEBREW_*` settings, including the GitHub token and the Brewfile location,
live in `~/.homebrew/brew.env`. brew reads that file itself, so they apply
however brew is started and are not exported into the shell environment.

### Apply Scripts (`.chezmoiscripts/`)

Scripts are bash. `run_after_*` scripts run on every apply, so they must be
idempotent and only call `sudo` when something actually needs changing (read
the current state without sudo first). `run_onchange_*` scripts only rerun when
their rendered content changes. Static files belong in the source tree as
files, not in a heredoc inside a script.

- `run_before_checks.sh` - Fails if there are unmanaged files; keeps the 1Password token file at mode 600
- `run_before_sudo.sh.tmpl` - Enables Touch ID for sudo (and passwordless sudo on mini)
- `run_after_brew.sh` - Updates Homebrew and syncs installs to the Brewfile
- `run_after_bun.sh` - Installs global bun packages
- `run_after_mac.sh.tmpl` - macOS defaults (keyboard, DNS, hostname)
- `run_after_remove.sh` - Removes preinstalled Apple apps
- `run_after_rust.sh.tmpl` - Initializes and updates the Rust toolchain
- `run_after_shells.sh.tmpl` - Adds Fish to /etc/shells and makes it the login shell
- `run_after_tailscale.sh` - Tailscale daemon + `tailscale up` (mini only)
- `run_onchange_after_restic.sh.tmpl` - Reloads the restic backup launchd agent when its plist changes (mini only)
- `run_onchange_after_agent-archiver.sh.tmpl` - Reloads the daily agent-archiver launchd agent when its plist changes (mini only)

### Prompt

The prompt in `interactive.d/prompt.fish` is a trimmed fork of hydro, with the
kube context from kube-ps1 folded in on work machines. There are no chezmoi
externals; third-party shell code is copied in and maintained here.

### 1Password Integration

Secrets are pulled from 1Password using chezmoi's `onepasswordRead` function in templates:
```
{{ (onepasswordRead "op://dotfiles/item/field") }}
```

Used for: SSH keys and commit signing, the Homebrew GitHub token, work AWS
config, and the mini's restic and agent-archiver credentials. A secret rendered
into a file that a shell sources is piped through `shellQuote`.

All machines run `op` in service-account mode (`onepassword.mode: service` in
the chezmoi config, token read from `~/.config/op/service-account-token` into
`OP_SERVICE_ACCOUNT_TOKEN` by the `chezmoi` fish function). The service account
can only read the `dotfiles` vault, so every `op://...` reference must target
the `dotfiles` vault — reads from other vaults (e.g. `op://personal/...`) will
fail.

### Mac Mini (Headless)

The mini has no interactive auth, so it diverges from the laptops:
- Passwordless sudo (`/etc/sudoers.d/lingrino`, installed by `run_before_sudo`)
- Its own SSH key, `~/.ssh/mini`, for auth and commit signing
- Its own, slimmer `Brewfile_mini`
- Hourly restic backups of `~/Documents` and the Photos library to S3 via a
  launchd agent (pruned weekly); credentials render from `op://dotfiles/restic`
  into `~/.config/restic/env`; the `restic` fish function wraps the env file
- Daily agent-archiver job (uses Homebrew `bash`, `ffmpeg` and `yt-dlp`)

### Fish Shell Organization

Fish config in `private_fish/`:
- `conf.d/` - Non-interactive environment setup (PATH, env vars)
- `interactive.d/` - Aliases and interactive-only config (sourced from config.fish)
- `functions/` - Fish functions (autoloaded)
- `completions/` - Command completions (ignored; generated at runtime)

Shell startup and per-command latency are kept low on purpose:
- Define aliases as plain functions (what `alias` would generate); `alias` is
  a slow script function.
- Load tool init scripts with `__cached_init <tool> init fish ...` (defined in
  config.fish) instead of `<tool> init fish | source`; it caches the output
  in `~/.cache/fish/init` until the binary changes.
- Don't spawn processes at startup, on `cd`, or on every prompt/command in the
  foreground; run them in the background (see `atuin.fish`, `zoxide.fish`,
  `prompt.fish`).

### SSH Keys and Git Configuration

SSH keys are on-disk files that chezmoi renders from 1Password into `~/.ssh/`;
the 1Password SSH agent is not used. The laptops get `personal` (the work
laptop also gets `work`) and the mini gets `mini`.

Commits are SSH-signed (`gpg.format = ssh`) with the machine's key and verified
against `~/.ssh/allowed_signers`. On the work laptop, repos under
`~/projects/work/` include `config-work`, which switches to the work email and
key and turns on `core.fsmonitor` (it only pays off in large repos, so it is
not set globally). `git-delta` is the pager.
