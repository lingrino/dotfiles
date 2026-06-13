# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a chezmoi-managed dotfiles repository for macOS. The source directory is `home/` (specified in `.chezmoiroot`), which maps to the user's home directory.

## Important

**AI should never run `chezmoi apply` or other chezmoi commands.** Only edit files directly in the `home/` source directory.

## Architecture

### Chezmoi Naming Conventions

Files in `home/` use chezmoi's special prefixes:
- `exact_` - Directory contents are managed exactly (extra files are removed)
- `private_` - Maps to files/dirs starting with `.` (e.g., `private_dot_config` → `.config`)
- `dot_` - Alternative prefix for dotfiles
- `.tmpl` suffix - File is a Go template processed during apply

### Machine Types

Configuration is templated on the machine name (set on first `chezmoi init`):
- **personal** - Personal machines with full personal apps
- **mini** - Headless mac mini; see below

Templates gate on the machine name directly (e.g. `{{ if eq .machine "mini" }}`).

Template variables defined in `.chezmoi.yaml.tmpl`:
- `.machine` - Machine name (e.g., "personal", "mini")
- `.brewprefix` - Homebrew path (`/opt/homebrew` on ARM, `/usr/local` on Intel)

### Directory Structure

```
home/
├── .chezmoi.yaml.tmpl          # Chezmoi config with machine detection
├── .chezmoiignore              # Files to ignore (supports templating)
├── .chezmoiscripts/            # Pre/post-apply hooks
├── exact_private_dot_config/   # → ~/.config/
│   ├── private_fish/           # Fish shell (conf.d/, functions/, interactive.d/)
│   ├── private_git/            # Git config
│   ├── private_ghostty/        # Terminal emulator
│   ├── private_homebrew/       # Brewfile.tmpl
│   └── ...
├── exact_private_dot_ssh/      # SSH config with 1Password agent
└── fonts/                      # Custom fonts installed via script
```

### Apply Scripts (`.chezmoiscripts/`)

Ordered by `run_before_` or `run_after_` prefix:
- `run_before_checks.sh` - Validates no unmanaged files exist
- `run_before_sudo.sh.tmpl` - Enables Touch ID for sudo (and passwordless sudo on mini)
- `run_after_brew.sh` - Updates Homebrew and installs from Brewfile
- `run_after_fonts.sh.tmpl` - Registers custom fonts
- `run_after_mac.sh.tmpl` - macOS defaults (keyboard, DNS, hostname)
- `run_after_rust.sh` - Updates Rust toolchain
- `run_after_shells.sh.tmpl` - Adds Fish to /etc/shells
- `run_after_tailscale.sh.tmpl` - Tailscale daemon + `tailscale up` (mini only)
- `run_onchange_after_restic.sh.tmpl` - Restic backup launchd agent (mini only)

### 1Password Integration

Secrets are pulled from 1Password using chezmoi's `onepasswordRead` function in templates:
```
{{ (onepasswordRead "op://vault/item/field") }}
```

Used for: Git signing key, Terraform credentials, API tokens.

On the mini, `op` runs in service-account mode (`onepassword.mode: service` in
the chezmoi config, token read from `~/.config/op/service-account-token` into
`OP_SERVICE_ACCOUNT_TOKEN` by fish). The service account can only read the
`dotfiles` vault, so mini templates must not reference other vaults — reads
from `op://personal/...` are gated off the mini.

### Mac Mini (Headless)

The mini has no interactive auth, so it diverges from the laptops:
- Passwordless sudo (`/etc/sudoers.d/lingrino`, installed by `run_before_sudo`)
- SSH auth and commit signing use the on-disk `~/.ssh/mini` key instead of the
  1Password agent; signature verification uses `~/.ssh/allowed_signers`
- No API-key env vars (ANTHROPIC/OPENAI/HOMEBREW tokens) and no Terraform creds
- Slimmer cask/mas set in the Brewfile (`eq .machine "mini"` gating)
- Hourly restic backups of `~/Documents` and the Photos library to S3 via a
  launchd agent; credentials render from `op://dotfiles/restic` into
  `~/.config/restic/env`; the `restic` fish function wraps the env file

### Fish Shell Organization

Fish config in `private_fish/`:
- `conf.d/` - Non-interactive environment setup (PATH, env vars)
- `interactive.d/` - Aliases and interactive-only config (sourced from config.fish)
- `functions/` - Fish functions (autoloaded)
- `completions/` - Command completions (managed via .chezmoiignore - generated at runtime)

### Git Configuration

Commits are signed via 1Password SSH keys (gpg.format = ssh).
