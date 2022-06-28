#------------------------------------------------
# Modify the region to use different AWS region
#------------------------------------------------
# AWS profile to use from AWS config for CLI (can be commented out if you wish to use environment variables from doormat)
aws_profile               = "default"
# AWS Region to deploy into
aws_region                = "us-east-2"
# Name of the secret you wish to use for your vault license key
vault_license_secret_name = "vault-license-name"
# Path on your local machine where the vault license exists
vault_license_file_path   = "../../relative/path/to/secret/file.txt"
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