#!/bin/sh

# Shorten terraform
alias tf='terraform'
alias tb='terraform-rc'
alias tg='terragrunt'

# Shorten terraform fmt, include tfvars files
alias tff='find * -type f -name "terraform.tfvars" -exec terraform fmt {} \; && terraform fmt'
alias tbf='find * -type f -name "terraform-rc.tfvars" -exec terraform-rc fmt {} \; && terraform-rc fmt'

# Shorten terraform init
alias tfi='terraform init -upgrade'
alias tbi='terraform-rc init -upgrade'
alias tgi='terragrunt init -upgrade'

# Shorten terraform get
alias tfg='terraform get -update'
alias tbg='terraform-rc get -update'
alias tgg='terragrunt get -update'

# Shorten terraform plan
alias tfp='terraform plan -parallelism=30 -refresh=true'
alias tbp='terraform-rc plan -parallelism=30 -refresh=true'
alias tgp='terragrunt plan -parallelism=30 -refresh=true'

# Shorten terraform apply
alias tfa='terraform apply -parallelism=30 -refresh=true'
alias tba='terraform-rc apply -parallelism=30 -refresh=true'
alias tga='terragrunt apply -parallelism=30 -refresh=true'

# Shorten terraform console
alias tfc='terraform console'
alias tbc='terraform-rc console'
alias tgc='terragrunt console'

# Shorten terraform state
alias tfs='terraform state'
alias tbs='terraform-rc state'
alias tgs='terragrunt state'

# Shorten terraform refresh
alias tfr='terraform refresh'
alias tbr='terraform-rc refresh'
alias tgr='terragrunt refresh'

# Shorten terraform destroy
alias tfd='terraform destroy'
alias tbd='terraform-rc destroy'
alias tgd='terragrunt destroy'

# Shorten terraform init & apply
alias tfia='tfi && tfa'
alias tbia='tbi && tba'
alias tgia='tgi && tga'
