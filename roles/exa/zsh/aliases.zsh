#!/bin/bash

# exa is a replacement for ls

if exa &>/dev/null; then
  # List all
  alias l="exa -abghl"
  alias la="exa -abghl"

  # List visible in table
  alias ll="exa -bghl"

  # Normal ls
  alias ls="exa"

  # List tree with optional depth
  lt() {
    if [ -z "$1" ]; then
      exa -bghlT
    else
      exa -bghlT -L "$1"
    fi
  }
fi
