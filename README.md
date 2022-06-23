# tf-test-work-environment
This code is designed to build a test environment for the Implementation Service Engineers supporting Vault. 

It creates the following:
 * 1 VPC
 * 3 Public Subnets
 * 3 Private Subnets
 * A NAT Gateway in Private Subnet A
 * An Internet Gateway
 * Necessary Routes for all of the Infrastructure
 * A Jump Box
 * Required Security Groups Rules for Interaction with the Jump Box
 * A KMS key for auto unseal of Vault
 * A Secret associated to your Vault Enterprise License Key
