#!/usr/bin/env sh
set -euo pipefail

# https://pkg.go.dev/golang.org/x/vuln/cmd/govulncheck
go install golang.org/x/vuln/cmd/govulncheck@latest
