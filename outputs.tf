output "key-id" {
  description = "KMS KEY ID: "
  value       = module.root.key-id
}

output "key-arn" {
  description = "KMS Key ARN: "
  value       = module.root.key-arn
}

output "alias-arn" {
  description = "KMS Alias ARN: "
  value       = module.root.alias-arn
}

# The Below Commented out for none Enterprise Testing
#output "license-key-secret-arn" {
#  description = "Secret ARN: "
#  value       = module.root.license-key-secret-arn
#}

output "s3-bucket" {
  value = module.root.created-s3-bucket
}

output created_VPC {
  description = "VPC: "
  value = module.root.created_VPC
}

output created_public_subnet_a {
  description = "Public Subnet A: "
  value = module.root.created_public_subnet_a
}

output created_public_subnet_b {
  description = "Public Subnet B: "
  value = module.root.created_public_subnet_b
}

output created_public_subnet_c {
  description = "Public Subnet C: "
  value = module.root.created_public_subnet_c
}

output created_private_subnet_a {
  description = "Private Subnet A: "
  value = module.root.created_private_subnet_a
}

output created_private_subnet_b {
  description = "Private Subnet B: "
  value = module.root.created_private_subnet_b
}

output created_private_subnet_c {
  description = "Private Subnet C: "
  value = module.root.created_private_subnet_c
}

output used_aws_ami_id {
  value = module.root.used_aws_ami_id
}

output jumpbox_public_ip {
  value = module.root.jumpbox_elastic_ip.public_ip
}

output "lb_certificate_arn" {
  description = "ARN of ACM cert to use with Vault LB listener"
  value       = module.secrets.lb_certificate_arn
}

output "leader_tls_servername" {
  description = "Shared SAN that will be given to the Vault nodes configuration for use as leader_tls_servername"
  value       = module.secrets.leader_tls_servername
}

output "secrets_manager_arn" {
  description = "ARN of secrets_manager secret"
  value       = module.secrets.secrets_manager_arn
}