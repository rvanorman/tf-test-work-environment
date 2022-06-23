variable "vault_license_secret_name" {
  description = "The name desired for the secret to be created"
}

variable "vault_license_file_path" {
  description = "The path on your machine to the license file for vault enterprise"
}

variable "kms_alias" {
  description = "The alias desired to be used for the KMS key (auto unseal)"
}

variable "engineer" {
  description = "The name/initials of the engineer deploying"
}

variable "vpc_cidr" {
  description = "The CIDR range desired for the VPC to be created"
}

variable "resource_prefix" {
  description = "The prefix desired for all respirces to be created"
}

variable "availability_zone_one" {
  description = "The first desired availability zone to deploy to"
}

variable "availability_zone_two" {
  description = "The second desired availability zone to deploy to"
}

variable "availability_zone_three" {
  description = "The third desired availability zone to deploy to"
}

variable "ssh_key_name" {
  description = "Key name of the SSH key desired to use for the jump box"
}

variable "public_subnet_a_cidr" {
  description = "Desired cidr range of the respective subnet"
}

variable "public_subnet_b_cidr" {
  description = "Desired cidr range of the respective subnet"
}

variable "public_subnet_c_cidr" {
  description = "Desired cidr range of the respective subnet"
}

variable "private_subnet_a_cidr" {
  description = "Desired cidr range of the respective subnet"
}

variable "private_subnet_b_cidr" {
  description = "Desired cidr range of the respective subnet"
}

variable "private_subnet_c_cidr" {
  description = "Desired cidr range of the respective subnet"
}

variable "jumpbox_instance_size" {
  description = "Instance size of the jumpbox instance to spin up"
}

variable "jumpbox_instance_storage" {
  description = "The size on disk of the jumpbox instance"
}

variable "jumpbox_ssh_ingress_cidr" {
  description = "The desired CIDR range for allowing to access your jumpbox from the internet"
}