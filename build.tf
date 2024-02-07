provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

module "root" {
  source = "./module/root"

  # The Below Commented out for non Enterprise Testing
  #vault_license_secret_name = var.vault_license_secret_name
  #vault_license_file_path   = var.vault_license_file_path
  kms_alias                 = var.kms_alias
  bucket_name               = var.bucket_name
  engineer                  = var.engineer
  vpc_cidr                  = var.vpc_cidr
  resource_prefix           = var.resource_prefix
  availability_zone_one     = var.availability_zone_one
  availability_zone_two     = var.availability_zone_two
  availability_zone_three   = var.availability_zone_three
  ssh_key_name              = var.ssh_key_name
  public_subnet_a_cidr      = var.public_subnet_a_cidr
  public_subnet_b_cidr      = var.public_subnet_b_cidr
  public_subnet_c_cidr      = var.public_subnet_c_cidr
  private_subnet_a_cidr     = var.private_subnet_a_cidr
  private_subnet_b_cidr     = var.private_subnet_b_cidr
  private_subnet_c_cidr     = var.private_subnet_c_cidr
  jumpbox_instance_size     = var.jumpbox_instance_size
  jumpbox_instance_storage  = var.jumpbox_instance_storage
  jumpbox_ssh_ingress_cidr  = var.jumpbox_ssh_ingress_cidr
}

module "secrets" {
  source = "./module/secrets"

  resource_prefix           = var.resource_prefix
  tls_kms_key_id            = var.tls_kms_key_id
  recovery_window           = var.recovery_window
  shared_san                = var.shared_san
}

variable "aws_profile" {
}

variable "aws_region" {
}

# The Below Commented out for non Enterprise Testing
#variable "vault_license_secret_name" {
#}

# The Below Commented out for non Enterprise Testing
#variable "vault_license_file_path" {
#}

variable "kms_alias" {
}

variable "bucket_name" {
}

variable "engineer" {
}

variable "vpc_cidr" {
}

variable "resource_prefix" {
}

variable "availability_zone_one" {
}

variable "availability_zone_two" {
}

variable "availability_zone_three" {
}

variable "ssh_key_name" {
}

variable "public_subnet_a_cidr" {
}

variable "public_subnet_b_cidr" {
}

variable "public_subnet_c_cidr" {
}

variable "private_subnet_a_cidr" {
}

variable "private_subnet_b_cidr" {
}

variable "private_subnet_c_cidr" {
}

variable "jumpbox_instance_size" {
}

variable "jumpbox_instance_storage" {
}

variable "jumpbox_ssh_ingress_cidr" {
}

variable "tls_kms_key_id" {
}

variable "recovery_window" {
}

variable "shared_san" {
}