#!/bin/bash

if exa &>/dev/null
then
  alias l="exa -abghl"
  alias la="exa -abghl"
  alias ll="exa -bghl"
  alias ls="exa"
  lt() {
    if [ -z "$1" ]; then
      exa -bghlT
    else
      exa -bghlT -L "$1"
    fi
  }
fi
