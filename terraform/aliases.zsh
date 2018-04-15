# Shorten terraform
alias tf='terraform'

# Shorten terraform fmt, include tfvars files
alias tff='find * -type f -name "terraform.tfvars" -exec terraform fmt {} \; && terraform fmt'

# Shorten terraform init
alias tfi='terraform init -upgrade'

# Shorten terraform get
alias tfg='terraform get -update'

# Shorten terraform plan
alias tfp='terraform plan'

# Shorten terraform apply
alias tfa='terraform apply'

# Shorten terraform state
alias tfs='terraform state'

# Shorten terraform refresh
alias tfr='terraform refresh'

# Shorten terraform destroy
alias tfd='terraform destroy'
