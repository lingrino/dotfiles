#!/usr/bin/env zsh

# Shorten terraform
alias tf='terraform'
alias tg='terrafgrunt'

# Shorten terraform fmt, include tfvars files
alias tff='terraform fmt'
alias tgf='terragrunt fmt'

# Shorten terraform init
alias tfi='terraform init -upgrade'
alias tgi='terragrunt init -upgrade'

# Shorten terraform import
alias tfim='terraform import'
alias tgim='terrgruntm import'

# Shorten terraform plan
alias tfp='terraform plan'
alias tgp='terragrunt plan'

# Shorten terraform apply
alias tfa='terraform apply'
alias tga='terragrunt apply'

# Shorten terraform console
alias tfc='terraform console'
alias tgc='terragrunt console'

# Shorten terraform state
alias tfs='terraform state'
alias tgs='terragrunt state'

# Shorten terraform destroy
alias tfd='terraform destroy'
alias tgd='terragrunt destroy'

# Shorten terraform init & apply
alias tfia='tfi && tfa'
alias tgia='tgi && tga'
