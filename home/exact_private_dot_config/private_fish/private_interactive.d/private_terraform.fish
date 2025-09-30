#!/usr/bin/env fish

abbr -a tf terraform
abbr -a tff 'terraform fmt -recursive'
abbr -a tfi 'terraform init -upgrade'
abbr -a tfim 'terraform import'
abbr -a tgim 'terragrunt import'
abbr -a tfp 'terraform plan'
abbr -a tfa 'terraform apply'
abbr -a tfc 'terraform console'
abbr -a tfs 'terraform state'
abbr -a tfd 'terraform destroy'
abbr -a tfip 'tfi && tfp'
abbr -a tfia 'tfi && tfa'
