# Shorten Vault
alias v='vault'

# LDAP auth to vault
alias va='vault login -method=ldap username=$(whoami)'

# Delete values in vault
alias vd='vault delete'

# List values in vault
alias vl='vault list'

# Read a value from vault
alias vr='vault read -field=value'

# Write a value to vault
vw () {
  vault write "$1" value="$2"
}

# Use after update to v2
# https://www.vaultproject.io/docs/secrets/kv/kv-v2.html
vp () {
  vault kv put "$1" value="$2"
}
