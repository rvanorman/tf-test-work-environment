#------------------------------------------------
# Modify the region to use different AWS region
#------------------------------------------------
# AWS profile to use from AWS config for CLI (can be commented out if you wish to use environment variables from doormat)
aws_profile               = "default"
# AWS Region to deploy into
aws_region                = "us-east-2"
# Name of the secret you wish to use for your vault license key -- The Below Commented out for non Enterprise Testing (Fix here, build.tf, outputs.tf, variables.tf and main.tf if you wish to use an enterprise license)
#vault_license_secret_name = "vault-license-name"
# Path on your local machine where the vault license exists -- The Below Commented out for non Enterprise Testing (Fix here, build.tf, outputs.tf, variables.tf and main.tf if you wish to use an enterprise license)
#vault_license_file_path   = "../../relative/path/to/secret/file.txt"
# The Alias (ie "Friendly Name") name of the KMS Key
kms_alias                 = "test-kms-key"
# Name of the s3 bucket
bucket_name               = "your-name-here-bucket"
# Name of the enginer deploying using this template
engineer                  = "test"
# Desired CIDR range for you VPC
vpc_cidr                  = "10.0.0.0/16"
# Prefix name you wish to use to append to resrouces being created
resource_prefix           = "test-prefix"
# First Availability Zone
availability_zone_one     = "us-east-2a"
# Second Availability Zone
availability_zone_two     = "us-east-2b"
# Third Availability Zone
availability_zone_three   = "us-east-2c"
# Name of the EC2 ssh key used to connect to your instances
ssh_key_name              = "ec2-ssh-key"
# Desired CIDR range for the respective Subnet
public_subnet_a_cidr      = "10.0.0.0/24"
# Desired CIDR range for the respective Subnet
public_subnet_b_cidr      = "10.0.1.0/24"
# Desired CIDR range for the respective Subnet
public_subnet_c_cidr      = "10.0.2.0/24"
# Desired CIDR range for the respective Subnet
private_subnet_a_cidr     = "10.0.3.0/24"
# Desired CIDR range for the respective Subnet
private_subnet_b_cidr     = "10.0.4.0/24"
# Desired CIDR range for the respective Subnet
private_subnet_c_cidr     = "10.0.5.0/24"
# Desired Instance Size
jumpbox_instance_size     = "t3.micro"
# Capacity of the storage for you jumpbox instance (in GB)
jumpbox_instance_storage  = "30"
# The desired CIDR range for allowing to access your jumpbox from the internet
jumpbox_ssh_ingress_cidr  = "0.0.0.0/0"
# The ARN or ID of the AWS KMS customer master key (CMK) to be used to encrypt the secret values in the versions stored in this secret. If you don't specify this value, then Secrets Manager defaults to using the AWS account's default CMK (the one named aws/secretsmanager)
tls_kms_key_id            =  null
# The number of days that AWS Secrets Manager waits before it can delete the secret
recovery_window           = 0
# A shared server name that the certs for all Vault nodes contain. This is the same value you will supply as input to the Vault installation module for the leader_tls_servername variable
shared_san                = "vault.server.com"