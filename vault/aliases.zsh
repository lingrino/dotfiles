# Shorten Vault
alias v='vault'

# LDAP auth to vault
alias va='vault login -method=ldap username=$(whoami)'

# Delete values in vault
alias vd='vault delete'

# List values in vault
alias vl='vault list'

# Read a value from vault
alias vr='vault read'

# Write a value to vault
alias vw='vault write'
