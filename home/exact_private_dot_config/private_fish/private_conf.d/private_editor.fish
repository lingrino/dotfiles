#!/usr/bin/env fish

# --wait so that anything that blocks on the editor (git, chezmoi edit, fish's
# edit-command-buffer) gets the saved file back
set -gx EDITOR "zed --wait"
