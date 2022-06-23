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

output "license-key-secret-arn" {
  description = "Secret ARN: "
  value       = module.root.license-key-secret-arn
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