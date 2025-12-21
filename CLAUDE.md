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

Configuration is templated based on machine type (set on first `chezmoi init`):
- **personal** - Personal machines with full personal apps
- **work** - Work machine with additional work-specific tools
- **headless/transient** - Codespaces, remote containers, etc.

Template variables defined in `.chezmoi.yaml.tmpl`:
- `.machine` - Machine name (e.g., "work", "personal", "mini")
- `.personal`, `.work` - Boolean flags
- `.headless`, `.transient` - Boolean flags for CI/container environments
- `.brewprefix` - Homebrew path (`/opt/homebrew` on ARM, `/usr/local` on Intel)

### Directory Structure

```
home/
├── .chezmoi.yaml.tmpl          # Chezmoi config with machine detection
├── .chezmoiignore              # Files to ignore (supports templating)
├── .chezmoiscripts/            # Pre/post-apply hooks
├── exact_private_dot_config/   # → ~/.config/
│   ├── private_fish/           # Fish shell (conf.d/, functions/, interactive.d/)
│   ├── private_git/            # Git config with work-specific includes
│   ├── private_ghostty/        # Terminal emulator
│   ├── private_homebrew/       # Brewfile.tmpl
│   └── ...
├── exact_private_dot_ssh/      # SSH config with 1Password agent
└── fonts/                      # Custom fonts installed via script
```

### Apply Scripts (`.chezmoiscripts/`)

Ordered by `run_before_` or `run_after_` prefix:
- `run_before_checks.sh` - Validates no unmanaged files exist
- `run_before_sudo.sh.tmpl` - Enables Touch ID for sudo
- `run_after_brew.sh` - Updates Homebrew and installs from Brewfile
- `run_after_fonts.sh.tmpl` - Registers custom fonts
- `run_after_mac.sh.tmpl` - macOS defaults (keyboard, DNS, hostname)
- `run_after_rust.sh` - Updates Rust toolchain
- `run_after_shells.sh.tmpl` - Adds Fish to /etc/shells

### 1Password Integration

Secrets are pulled from 1Password using chezmoi's `onepasswordRead` function in templates:
```
{{ (onepasswordRead "op://vault/item/field") }}
```

Used for: Git signing key, Terraform credentials, API tokens.

### Fish Shell Organization

Fish config in `private_fish/`:
- `conf.d/` - Non-interactive environment setup (PATH, env vars)
- `interactive.d/` - Aliases and interactive-only config (sourced from config.fish)
- `functions/` - Fish functions (autoloaded)
- `completions/` - Command completions (managed via .chezmoiignore - generated at runtime)

### Git Configuration

Uses conditional includes for work-specific config:
```
[includeIf "gitdir:~/projects/work/"]
  path = ~/.config/git/config-work
```

Commits are signed via 1Password SSH keys (gpg.format = ssh).
