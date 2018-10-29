#!/bin/sh

# Shorten terraform
alias tf='terraform'
alias tg='terragrunt'

# Shorten terraform fmt, include tfvars files
alias tff='find * -type f -name "terraform.tfvars" -exec terraform fmt {} \; && terraform fmt'

# Shorten terraform init
alias tfi='terraform init -upgrade'
alias tgi='terragrunt init -upgrade'

# Shorten terraform get
alias tfg='terraform get -update'
alias tgg='terragrunt get -update'

# Shorten terraform plan
alias tfp='terraform plan -parallelism=30 -refresh=true'
alias tgp='terragrunt plan -parallelism=30 -refresh=true'

# Shorten terraform apply
alias tfa='terraform apply -parallelism=30 -refresh=true'
alias tga='terragrunt apply -parallelism=30 -refresh=true'

# Shorten terraform console
alias tfc='terraform console'
alias tgc='terragrunt console'

# Shorten terraform state
alias tfs='terraform state'
alias tgs='terragrunt state'

# Shorten terraform refresh
alias tfr='terraform refresh'
alias tgr='terragrunt refresh'

# Shorten terraform destroy
alias tfd='terraform destroy'
alias tgd='terragrunt destroy'

# Shorten terraform init & apply
alias tfia='tfi && tfa'
alias tgia='tgi && tga'
