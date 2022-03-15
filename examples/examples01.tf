module "vpc_prod" {
  source = "../modules/vpc"
  #vpc Configuration
  name = "prod"
  cidr = "10.200.0.0/18"

################################################################################
# Subnets
################################################################################

  public_subnets     = {
    public-a ={
    cidr_block = "10.200.0.0/24"
    az_id = "us-east-2a"
    } ,
    public-b = {
    cidr_block = "10.200.1.0/24"
    az_id = "us-east-2b"
    } ,
    public-c = {
    cidr_block = "10.200.2.0/24"
    az_id = "us-east-2c"
    }
  }
  

private_subnets     = {
    private-a ={
    cidr_block = "10.200.4.0/22"
    az_id = "us-east-2a"
    } ,
    private-b = {
    cidr_block = "10.200.8.0/22"
    az_id = "us-east-2b"
    } ,
    private-c = {
    cidr_block = "10.200.12.0/22"
    az_id = "us-east-2c"
    }
  }

database_subnets     = {
    backend-a ={
    cidr_block = "10.200.16.0/22"
    az_id = "uus-east-2a"
    } ,
    backend-b = {
    cidr_block = "10.200.20.0/22"
    az_id = "us-east-2b"
    } ,
    backend-c = {
    cidr_block = "10.200.24.0/22"
    az_id = "us-east-2c"
    }
  }

infra_subnets     = {
    clusters-a ={
    cidr_block = "10.200.28.0/22"
    az_id = "us-east-2a"
    } ,
    clusters-b = {
    cidr_block = "10.200.32.0/22"
    az_id = "us-east-2b"
    } ,
    clusters-c = {
    cidr_block = "10.200.36.0/22"
    az_id = "us-east-2c"
    }
  }

  #Dns  
  enable_dns_hostnames = true
  enable_dns_support   = true
}