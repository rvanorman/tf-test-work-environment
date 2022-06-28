output "key-id" {
  value = aws_kms_key.vault.id
}

output "key-arn" {
  value = aws_kms_key.vault.arn
}

output "alias-arn" {
  value = aws_kms_alias.alias.arn
}

output "license-key-secret-arn" {
  value = aws_secretsmanager_secret.secret.arn
}

output "created-s3-bucket" {
  value = aws_s3_bucket.bucket.id
}

output "created_VPC" {
  value = aws_vpc.terraform_vpc.id
}

output "created_public_subnet_a" {
  value = aws_subnet.tf_public_subnet_a.id
}

output "created_public_subnet_b" {
  value = aws_subnet.tf_public_subnet_b.id
}

output "created_public_subnet_c" {
  value = aws_subnet.tf_public_subnet_c.id
}

output "created_private_subnet_a" {
  value = aws_subnet.tf_private_subnet_a.id
}

output "created_private_subnet_b" {
  value = aws_subnet.tf_private_subnet_b.id
}

output "created_private_subnet_c" {
  value = aws_subnet.tf_private_subnet_c.id
}

output "used_aws_ami_id" {
  value = data.aws_ami.amazon_linux.id
}

output "jumpbox_elastic_ip" {
  value = aws_eip.jump_box_public_ip
}