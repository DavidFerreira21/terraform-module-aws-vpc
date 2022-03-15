################################################################################
# VPC
################################################################################
# Obrigatorio
# variable "azs" {
#   description = "A list of azs for subnets"
#   type        = list(string)
# }
# Obrigatorio
variable "name" {
  type        = string
  description = "name of vpc"
}
# Obrigatorio
variable "cidr" {
  type        = string
  description = "cidr of VPC e.g 10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  default     = false
}

variable "enable_dns_support" {
  type        = bool
  description = "A boolean flag to enable/disable DNS support in the VPC. Defaults true"
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}

}

variable "vpc_tags" {
  description = "A map of tags to add to vpc resource"
  type        = map(string)
  default     = {}
}


################################################################################
# Internet Gateway
################################################################################

variable "igw_tags" {
  description = "A map of tags to add to IGW resource"
  type        = map(string)
  default     = {}
}

################################################################################
# Public
################################################################################
variable "public_subnets" {
  description = "A map of public subnets inside the VPC Attributes:key, cidr_block and az_id"
  type        = any
  default     = {}
}

variable "public_subnet_tags" {
  description = "A map of tags to add to public subnets resources"
  type        = map(string)
  default     = {}
}

variable "public_route_table_tags" {
  description = "A map of tags to add to public route table resource"
  type        = map(string)
  default     = {}
}
variable "map_public_ip_on_launch" {
  type        = bool
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false"
  default     = true
}

################################################################################
# Private
################################################################################

variable "private_subnets" {
  description = "A map of private subnets inside the VPC Attributes:key, cidr_block and az_id"
  type        = any
  default     = {}

}
variable "private_subnet_tags" {
  description = "A map of tags to add to private subnets resources"
  type        = map(string)
  default     = {}
}

variable "private_route_table_tags" {
  description = "A map of tags to add to private route table resource"
  type        = map(string)
  default     = {}
}


################################################################################
# Database
################################################################################
variable "database_subnets" {
  description = "A map of database subnets inside the VPC Attributes:key, cidr_block and az_id"
  type        = any
  default     = {}

}
variable "database_subnet_tags" {
  description = "A map of tags to add to database subnets resources"
  type        = map(string)
  default     = {}
}

variable "database_route_table_tags" {
  description = "A map of tags to add to database route table resource"
  type        = map(string)
  default     = {}
}

variable "database_subnet_group_tags" {
  description = "A map of tags to add to database subnets resources"
  type        = map(string)
  default     = {}
}

variable "create_database_subnet_group" {
  type        = bool
  description = "(Optional) Specify true to indicate that you need to a datatabase group"
  default     = true
}


################################################################################
# Infra
################################################################################

variable "infra_subnets" {
  description = "A map of infra subnets inside the VPC Attributes:key, cidr_block and az_id"
  type        = any
  default     = {}

}
variable "infra_subnet_tags" {
  description = "A map of tags to add to infra subnets resources"
  type        = map(string)
  default     = {}
}

variable "infra_route_table_tags" {
  description = "A map of tags to add to infra route table resource"
  type        = map(string)
  default     = {}
}

variable "create_nat_route_infra_subnet" {
  type        = bool
  description = "(Optional) Specify true to indicate that infra subnet will be out to internet"
  default     = false
}

variable "multples_rt_enable" {
  type        = bool
  description = "(Optional) Specify true to indicate that infra subnet will be out to internet"
  default     = false
}


