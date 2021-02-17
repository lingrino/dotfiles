#!/usr/bin/env zsh

# Shorten terraform
alias tf='terraform'

# Shorten terraform fmt, include tfvars files
alias tff='terraform fmt'

# Shorten terraform init
alias tfi='terraform init -upgrade'

# Shorten terraform import
alias tfim='terraform import'

# Shorten terraform plan
alias tfp='terraform plan'

# Shorten terraform apply
alias tfa='terraform apply'

# Shorten terraform console
alias tfc='terraform console'

# Shorten terraform state
alias tfs='terraform state'

# Shorten terraform destroy
alias tfd='terraform destroy'

# Shorten terraform init & apply
alias tfia='tfi && tfa'
