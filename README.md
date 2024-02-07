# tf-test-work-environment
This code is designed to build a test environment for the Implementation Service Engineers supporting Vault. 

- It creates the following:
  - 1 VPC
  - 3 Public Subnets
  - 3 Private Subnets
  - A NAT Gateway in Private Subnet A
  - An Internet Gateway
  - Necessary Routes for all of the Infrastructure
  - A Jump Box
  - Required Security Groups Rules for Interaction with the Jump Box
  - A KMS key for auto unseal of Vault
  - (Optional) A Secret associated to your Vault Enterprise License Key (This piece is commented out throughout the code by default)
  - An S3 bucket for storage and access via jumpbox
  - A TLS Certificate to be used for the vault cluster and an ALB sitting in front of the vault cluster

- (Optional) Note that I have commented out the pieces around creating an Enterprise key so this can be used for test purposes by default. If you wish to use and enterprise key as part of this Then make sure to uncomment out the variables and resource blocks associated in the following sections:
  - module/root/main.tf
  - module/root/outputs.tf
  - module/root/variables.tf
  - build.tf
  - outputs.tf
  - terraform.tfvars