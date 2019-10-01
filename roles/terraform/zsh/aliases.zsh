#!/usr/local/bin/zsh

# Shorten terraform
alias tf='terraform'

# Shorten terraform fmt, include tfvars files
alias tff='find * -type f -name "terraform.tfvars" -exec terraform fmt {} \; && terraform fmt'

# Shorten terraform init
alias tfi='terraform init -upgrade'

# Shorten terraform get
alias tfg='terraform get -update'

# Shorten terraform plan
alias tfp='terraform plan -refresh=true'

# Shorten terraform apply
alias tfa='terraform apply -refresh=true'

# Shorten terraform console
alias tfc='terraform console'

# Shorten terraform state
alias tfs='terraform state'

# Shorten terraform refresh
alias tfr='terraform refresh'

# Shorten terraform destroy
alias tfd='terraform destroy'

# Shorten terraform init & apply
alias tfia='tfi && tfa'
