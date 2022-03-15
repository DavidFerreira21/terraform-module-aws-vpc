
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.70.0 |
# Examples

``` hcl
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
    az_id = "us-west-1b"
    } ,
    public-b = {
    cidr_block = "10.200.1.0/24"
    az_id = "us-west-1b"
    } ,
    public-c = {
    cidr_block = "10.200.2.0/24"
    az_id = "us-west-1c"
    }
  }
  

private_subnets     = {
    private-a ={
    cidr_block = "10.200.4.0/22"
    az_id = "us-west-1b"
    } ,
    private-b = {
    cidr_block = "10.200.8.0/22"
    az_id = "us-west-1b"
    } ,
    private-c = {
    cidr_block = "10.200.12.0/22"
    az_id = "us-west-1c"
    }
  }

database_subnets     = {
    backend-a ={
    cidr_block = "10.200.16.0/22"
    az_id = "us-west-1b"
    } ,
    backend-b = {
    cidr_block = "10.200.20.0/22"
    az_id = "us-west-1b"
    } ,
    backend-c = {
    cidr_block = "10.200.24.0/22"
    az_id = "us-west-1c"
    }
  }

infra_subnets     = {
    clusters-a ={
    cidr_block = "10.200.28.0/22"
    az_id = "us-west-1b"
    } ,
    clusters-b = {
    cidr_block = "10.200.32.0/22"
    az_id = "us-west-1b"
    } ,
    clusters-c = {
    cidr_block = "10.200.36.0/22"
    az_id = "us-west-1c"
    }
  }

  #Dns  
  enable_dns_hostnames = true
  enable_dns_support   = true
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | cidr of VPC e.g 10.0.0.0/16 | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | name of vpc | `string` | n/a | yes |
| <a name="input_create_database_subnet_group"></a> [create\_database\_subnet\_group](#input\_create\_database\_subnet\_group) | (Optional) Specify true to indicate that you need to a datatabase group | `bool` | `true` | no |
| <a name="input_create_nat_route_infra_subnet"></a> [create\_nat\_route\_infra\_subnet](#input\_create\_nat\_route\_infra\_subnet) | (Optional) Specify true to indicate that infra subnet will be out to internet | `bool` | `false` | no |
| <a name="input_database_route_table_tags"></a> [database\_route\_table\_tags](#input\_database\_route\_table\_tags) | A map of tags to add to database route table resource | `map(string)` | `{}` | no |
| <a name="input_database_subnet_group_tags"></a> [database\_subnet\_group\_tags](#input\_database\_subnet\_group\_tags) | A map of tags to add to database subnets resources | `map(string)` | `{}` | no |
| <a name="input_database_subnet_tags"></a> [database\_subnet\_tags](#input\_database\_subnet\_tags) | A map of tags to add to database subnets resources | `map(string)` | `{}` | no |
| <a name="input_database_subnets"></a> [database\_subnets](#input\_database\_subnets) | A map of database subnets inside the VPC Attributes:key, cidr\_block and az\_id | `any` | `{}` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false. | `bool` | `false` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | A boolean flag to enable/disable DNS support in the VPC. Defaults true | `bool` | `true` | no |
| <a name="input_igw_tags"></a> [igw\_tags](#input\_igw\_tags) | A map of tags to add to IGW resource | `map(string)` | `{}` | no |
| <a name="input_infra_route_table_tags"></a> [infra\_route\_table\_tags](#input\_infra\_route\_table\_tags) | A map of tags to add to infra route table resource | `map(string)` | `{}` | no |
| <a name="input_infra_subnet_tags"></a> [infra\_subnet\_tags](#input\_infra\_subnet\_tags) | A map of tags to add to infra subnets resources | `map(string)` | `{}` | no |
| <a name="input_infra_subnets"></a> [infra\_subnets](#input\_infra\_subnets) | A map of infra subnets inside the VPC Attributes:key, cidr\_block and az\_id | `any` | `{}` | no |
| <a name="input_map_public_ip_on_launch"></a> [map\_public\_ip\_on\_launch](#input\_map\_public\_ip\_on\_launch) | (Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false | `bool` | `true` | no |
| <a name="input_multples_rt_enable"></a> [multples\_rt\_enable](#input\_multples\_rt\_enable) | (Optional) Specify true to indicate that infra subnet will be out to internet | `bool` | `false` | no |
| <a name="input_private_route_table_tags"></a> [private\_route\_table\_tags](#input\_private\_route\_table\_tags) | A map of tags to add to private route table resource | `map(string)` | `{}` | no |
| <a name="input_private_subnet_tags"></a> [private\_subnet\_tags](#input\_private\_subnet\_tags) | A map of tags to add to private subnets resources | `map(string)` | `{}` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A map of private subnets inside the VPC Attributes:key, cidr\_block and az\_id | `any` | `{}` | no |
| <a name="input_public_route_table_tags"></a> [public\_route\_table\_tags](#input\_public\_route\_table\_tags) | A map of tags to add to public route table resource | `map(string)` | `{}` | no |
| <a name="input_public_subnet_tags"></a> [public\_subnet\_tags](#input\_public\_subnet\_tags) | A map of tags to add to public subnets resources | `map(string)` | `{}` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A map of public subnets inside the VPC Attributes:key, cidr\_block and az\_id | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_tags"></a> [vpc\_tags](#input\_vpc\_tags) | A map of tags to add to vpc resource | `map(string)` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Private_subnets_ids"></a> [Private\_subnets\_ids](#output\_Private\_subnets\_ids) | map of private\_subnets ids |
| <a name="output_database_route_table_ids"></a> [database\_route\_table\_ids](#output\_database\_route\_table\_ids) | list of database\_route\_table ids |
| <a name="output_database_subnets_ids"></a> [database\_subnets\_ids](#output\_database\_subnets\_ids) | map of database\_subnets ids |
| <a name="output_infra_route_table_ids"></a> [infra\_route\_table\_ids](#output\_infra\_route\_table\_ids) | list of infra\_route\_table ids |
| <a name="output_infra_subnets_ids"></a> [infra\_subnets\_ids](#output\_infra\_subnets\_ids) | map of infra\_subnets ids |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | list of private\_route\_table ids |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | list of public\_route\_table ids |
| <a name="output_public_subnets_ids"></a> [public\_subnets\_ids](#output\_public\_subnets\_ids) | map of public\_subnets ids |
| <a name="output_vcp_id"></a> [vcp\_id](#output\_vcp\_id) | string of vpc id |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | string of cidr block |
## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route_table.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.infra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.infra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.infra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

