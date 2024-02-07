# Create a secret in AWS associated to your vault enterprise license file. Used https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret
# The Below Commented out for non Enterprise Testing
#data "local_sensitive_file" "file" {
#  filename = var.vault_license_file_path
#}

# The Below Commented out for non Enterprise Testing
#resource "aws_secretsmanager_secret" "secret" {
#  name = var.vault_license_secret_name
#  tags = {
#    Owner       = var.engineer
#    Environment = "test"
#    Terraform   = "true"
#  }
#}

# The Below Commented out for non Enterprise Testing
#resource "aws_secretsmanager_secret_version" "secret" {
#  secret_id     = aws_secretsmanager_secret.secret.id
#  secret_string = data.local_sensitive_file.file.content
#}

# Create a KMS key for auto unseal of vault. Used https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key
resource "aws_kms_key" "vault" {
  description = "Vault unseal key"
  #deletion_window_in_days = 10

  tags = {
    Name        = "${var.engineer}-vault-kms-unseal"
    Owner       = var.engineer
    Environment = "test"
    Terraform   = "true"
  }
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${var.kms_alias}"
  target_key_id = aws_kms_key.vault.key_id
}

# Create an s3 bucket for storage and public read access. Used https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Owner       = var.engineer
    Environment = "test"
    Terraform   = "true"
  }
}

resource "aws_s3_bucket_ownership_controls" "bucket-acl-ownership" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  depends_on = [aws_s3_bucket_ownership_controls.bucket-acl-ownership]
  bucket     = aws_s3_bucket.bucket.id
  acl        = "private"
}

# Create the VPC. Used https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "terraform_vpc" {
  cidr_block         = var.vpc_cidr
  instance_tenancy   = "default"

  tags = {
    Name        = "${var.resource_prefix}-terraform-vpc"
    Owner       = var.engineer
    Terraform   = "true"
    Environment = "test"
    
  }
}

# Create Public Subnet A. Used https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet 
resource "aws_subnet" "tf_public_subnet_a" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = var.public_subnet_a_cidr
  availability_zone = var.availability_zone_one
  tags = {
    Name          = "${var.resource_prefix}-tf-public-subnet-a"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
    Accessibility = "Public"
  }
}

# Create Public Subnet B.
resource "aws_subnet" "tf_public_subnet_b" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = var.public_subnet_b_cidr
  availability_zone = var.availability_zone_two
  tags = {
    Name          = "${var.resource_prefix}-tf-public-subnet-b"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
    Accessibility = "Public"
  }
}

# Create Public Subnet C.
resource "aws_subnet" "tf_public_subnet_c" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = var.public_subnet_c_cidr
  availability_zone = var.availability_zone_three
  tags = {
    Name          = "${var.resource_prefix}-tf-public-subnet-c"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
    Accessibility = "Public"
  }
}

# Create Private Subnet A.
resource "aws_subnet" "tf_private_subnet_a" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = var.private_subnet_a_cidr
  availability_zone = var.availability_zone_one
  tags = {
    Name          = "${var.resource_prefix}-tf-private-subnet-a"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
    Accessibility = "Private"
    Vault         = "deploy"
  }
}

# Create Private Subnet B.
resource "aws_subnet" "tf_private_subnet_b" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = var.private_subnet_b_cidr
  availability_zone = var.availability_zone_two
  tags = {
    Name          = "${var.resource_prefix}-tf-private-subnet-b"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
    Accessibility = "Private"
    Vault         = "deploy"
  }
}

# Create Private Subnet C.
resource "aws_subnet" "tf_private_subnet_c" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = var.private_subnet_c_cidr
  availability_zone = var.availability_zone_three
  tags = {
    Name          = "${var.resource_prefix}-tf-private-subnet-c"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
    Accessibility = "Private"
    Vault         = "deploy"
  }
}

# Create the Elastic IP for Nat Gateway. Used https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
resource "aws_eip" "nat_gateway_ip" {
  vpc      = true

  tags = {
    Name          = "${var.resource_prefix}-tf-nat-gw-ip"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
  }
}

# Create Internet Gateway. Used https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "tf_internet_gw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name          = "${var.resource_prefix}-tf-internet-gw"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
  }
}

# Create NAT Gateway. Used https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway 
resource "aws_nat_gateway" "tf_nat_gateway" {
  allocation_id = aws_eip.nat_gateway_ip.id
  subnet_id     = aws_subnet.tf_public_subnet_a.id

  tags = {
    Name          = "${var.resource_prefix}-tf-nat-gateway"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.tf_internet_gw]
}

# Create the Route Table for Private Subnets. Used https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table 
resource "aws_route_table" "tf_private_route_table" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tf_nat_gateway.id
  }

  tags = {
    Name          = "${var.resource_prefix}-tf-private-route-table"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency on the Internet Gateway for the VPC.
  depends_on = [aws_nat_gateway.tf_nat_gateway]
}

# Create the Route Table for Public Subnets
resource "aws_route_table" "tf_public_route_table" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_internet_gw.id
  }

  tags = {
    Name          = "${var.resource_prefix}-tf-public-route-table"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.tf_internet_gw]
}

# Remove any default route associations. Used https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table 
resource "aws_default_route_table" "tf_default_route_table" {
  default_route_table_id = aws_vpc.terraform_vpc.default_route_table_id

  route = []

  tags = {
    Name          = "${var.resource_prefix}-tf-default-route-table"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
  }
}

# Associate Private Subnets to Private Route Table. Used https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "tf_private_route_table_association_a" {
  subnet_id      = aws_subnet.tf_private_subnet_a.id
  route_table_id = aws_route_table.tf_private_route_table.id
}

resource "aws_route_table_association" "tf_private_route_table_association_b" {
  subnet_id      = aws_subnet.tf_private_subnet_b.id
  route_table_id = aws_route_table.tf_private_route_table.id
}

resource "aws_route_table_association" "tf_private_route_table_association_c" {
  subnet_id      = aws_subnet.tf_private_subnet_c.id
  route_table_id = aws_route_table.tf_private_route_table.id
}

# Associate Public Subnets to Public Route Table.
resource "aws_route_table_association" "tf_public_route_table_association_a" {
  subnet_id      = aws_subnet.tf_public_subnet_a.id
  route_table_id = aws_route_table.tf_public_route_table.id
}

resource "aws_route_table_association" "tf_public_route_table_association_b" {
  subnet_id      = aws_subnet.tf_public_subnet_b.id
  route_table_id = aws_route_table.tf_public_route_table.id
}

resource "aws_route_table_association" "tf_public_route_table_association_c" {
  subnet_id      = aws_subnet.tf_public_subnet_c.id
  route_table_id = aws_route_table.tf_public_route_table.id
}

# Create the AMI data point to be used for later. https://medium.com/@knoldus/fetch-the-latest-ami-in-aws-using-terraform-4ea9b95025d7
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Create the Security Group for the Jump Box
resource "aws_security_group" "tf_jump_box_sg" {
  name        = "${var.resource_prefix}-tf-jump-box-sg"
  description = "Jump Box Security Group"
  vpc_id      = aws_vpc.terraform_vpc.id

  ingress {
    description = "Inbound SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.jumpbox_ssh_ingress_cidr]
  }

  egress {
    description = "Communication to the VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description      = "Communication to the World"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name          = "${var.resource_prefix}-tf-jump-box-sg"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
  }
}

# Create the Primary Interface for the Jump Box
resource "aws_network_interface" "tf_jump_box_interface" {
  subnet_id       = aws_subnet.tf_public_subnet_a.id
  security_groups = [aws_security_group.tf_jump_box_sg.id]

  tags = {
    Name          = "${var.resource_prefix}-tf-jump-box-primary-network-interface"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
  }
}

# Create the Jump Box Instance. 
resource "aws_instance" "tf_jump_box" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.jumpbox_instance_size
  key_name                    = var.ssh_key_name
  network_interface {
    network_interface_id = aws_network_interface.tf_jump_box_interface.id
    device_index         = 0
  }
  root_block_device {
    volume_size               = var.jumpbox_instance_storage
  }

  tags = {
    Name          = "${var.resource_prefix}-tf-jump-box"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
  }
}

# Create the Elastic IP for the Jump Box
resource "aws_eip" "jump_box_public_ip" {
  instance = aws_instance.tf_jump_box.id
  vpc      = true

  tags = {
    Name          = "${var.resource_prefix}-tf-jump-box-public-ip"
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
  }
}

# Create the IAM Role and Policy necessary for the EC2 instance to access you s3 bucket created earlier
resource "aws_iam_role" "tf_jumpbox_iam_role" {
  name = "${var.resource_prefix}-tf-jumpbox-iam-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Owner         = var.engineer
    Terraform     = "true"
    Environment   = "test"
  }
}

resource "aws_iam_instance_profile" "tf_jumpbox_profile" {
  name = "${var.resource_prefix}-tf-jumpbox-profile"
  role = aws_iam_role.tf_jumpbox_iam_role.name
}

resource "aws_iam_role_policy" "tf_jumpbox_iam_policy" {
  name = "${var.resource_prefix}-tf-jumpbox-iam-policy"
  role = aws_iam_role.tf_jumpbox_iam_role.id
  depends_on = [aws_s3_bucket.bucket]

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "s3:*"
        ]
        Effect   = "Allow"
        Resource = [
          "${aws_s3_bucket.bucket.arn}",
          "${aws_s3_bucket.bucket.arn}/*"
        ]
      },
      {
        Action = [
          "s3:ListAllMyBuckets"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::*"
      }
    ]
  })
}