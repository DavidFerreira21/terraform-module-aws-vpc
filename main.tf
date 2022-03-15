################################################################################
# VPC
################################################################################

resource "aws_vpc" "this" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support


  tags = merge(
    {
      "Name" = format("${"vpc"}-%s", var.name)
    },
    var.tags,
    var.vpc_tags,
  )
}



################################################################################
# Internet Gateway
################################################################################

resource "aws_internet_gateway" "this" {
  count  = var.public_subnets == null ? 0 : 1
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      "Name" = format(
        "${"igw"}-%s",
        var.name
      )
    },
    var.tags,
    var.igw_tags,
  )
}



 locals {
  public = var.multples_rt_enable ?  length(var.public_subnets)  : 1
  private = var.multples_rt_enable ?  length(var.private_subnets)  : 1
  database = var.multples_rt_enable ?  length(var.database_subnets)  : 1
  infra = var.multples_rt_enable ?  length(var.infra_subnets)  : 1
 }

################################################################################
# Publiс Route Table
################################################################################

resource "aws_route_table" "public" {
  count = var.public_subnets == null ? null : local.public
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      "Name" = format(
         "%s-${"rt"}-%s",
         element(keys(var.public_subnets),count.index),
        var.name
       )
    },
    var.tags,
    var.public_route_table_tags,
  )
}


################################################################################
# Public subnet
################################################################################

resource "aws_subnet" "public" {
  for_each = var.public_subnets == null ? null : var.public_subnets
    
    vpc_id                  = aws_vpc.this.id
    cidr_block              = each.value.cidr_block
    availability_zone       = each.value.az_id
    map_public_ip_on_launch = var.map_public_ip_on_launch

    tags = merge(
     {
       "Name" = format(
         "%s-${"subnet"}-%s",
         each.key,
         var.name
       )
     },
     var.tags,
     var.public_route_table_tags,
   )
 
}


################################################################################
# private Route Table
################################################################################

resource "aws_route_table" "private" {
  count = var.private_subnets == null ? null : local.private
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      "Name" = format(
         "%s-${"rt"}-%s",
         element(keys(var.private_subnets),count.index),
        var.name
       )
    },
    var.tags,
    var.private_route_table_tags,
  )
}


################################################################################
# private subnet
################################################################################

resource "aws_subnet" "private" {
  for_each = var.private_subnets == null ? null : var.private_subnets
    
    vpc_id                  = aws_vpc.this.id
    cidr_block              = each.value.cidr_block
    availability_zone       = each.value.az_id

    tags = merge(
     {
       "Name" = format(
         "%s-${"subnet"}-%s",
         each.key,
         var.name
       )
     },
     var.tags,
     var.private_route_table_tags,
   )
 
}


################################################################################
# database Route Table
################################################################################

resource "aws_route_table" "database" {
  count = var.database_subnets == null ? null : local.database
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      "Name" = format(
         "%s-${"rt"}-%s",
         element(keys(var.database_subnets),count.index),
        var.name
       )
    },
    var.tags,
    var.database_route_table_tags,
  )
}


################################################################################
# database subnet
################################################################################

resource "aws_subnet" "database" {
  for_each = var.database_subnets == null ? null : var.database_subnets
    
    vpc_id                  = aws_vpc.this.id
    cidr_block              = each.value.cidr_block
    availability_zone       = each.value.az_id

    tags = merge(
     {
       "Name" = format(
         "%s-${"subnet"}-%s",
         each.key,
         var.name
       )
     },
     var.tags,
     var.database_route_table_tags,
   )
 
}



################################################################################
# infra Route Table
################################################################################

resource "aws_route_table" "infra" {
  count = var.infra_subnets == null ? null :  local.infra
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      "Name" = format(
         "%s-${"rt"}-%s",
         element(keys(var.infra_subnets),count.index),
        var.name
       )
    },
    var.tags,
    var.infra_route_table_tags,
  )
}


################################################################################
# infra subnet
################################################################################

resource "aws_subnet" "infra" {
  for_each = var.infra_subnets == null ? null : var.infra_subnets
    
    vpc_id                  = aws_vpc.this.id
    cidr_block              = each.value.cidr_block
    availability_zone       = each.value.az_id

    tags = merge(
     {
       "Name" = format(
         "%s-${"subnet"}-%s",
         each.key,
         var.name
       )
     },
     var.tags,
     var.infra_route_table_tags,
   )
 
}



################################################################################
# Route table associations
################################################################################

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  subnet_id      = element([for v in aws_subnet.public : v.id], count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  subnet_id      = element([for v in aws_subnet.private : v.id], count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnets) > 0 ? length(var.database_subnets) : 0

  subnet_id      = element([for v in aws_subnet.database : v.id], count.index)
  route_table_id = element(aws_route_table.database.*.id, count.index)
}

resource "aws_route_table_association" "infra" {
  count = length(var.infra_subnets) > 0 ? length(var.infra_subnets) : 0

  subnet_id      = element([for v in aws_subnet.infra : v.id], count.index)
  route_table_id = element(aws_route_table.infra.*.id, count.index)
}

  

# ################################################################################
# # Private Route Table
# ################################################################################

# resource "aws_route_table" "private" {
#   count  = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
#   vpc_id = aws_vpc.this.id

#   tags = merge(
#     {
#       "Name" = format(
#         "${"rt"}-%s-%s",
#         var.subnet_private_name,
#         element(var.azs, count.index),
#       )
#     },
#     var.tags,
#     var.private_route_table_tags,
#   )
# }


# ################################################################################
# # Private subnet
# ################################################################################

# resource "aws_subnet" "private" {
#   count = length(var.private_subnets) >= length(var.azs) ? length(var.azs) : 0

#   vpc_id               = aws_vpc.this.id
#   cidr_block           = element(var.private_subnets, count.index)
#   availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
#   availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null

#   tags = merge(
#     {
#       "Name" = format(
#         "${"subnet"}-%s-${var.name}-%s",
#         var.subnet_private_name,
#         element(var.azs, count.index),
#       )
#     },
#     var.tags,
#     var.private_subnet_tags,
#   )
# }

# ################################################################################
# # database Route Table
# ################################################################################

# resource "aws_route_table" "database" {
#   count  = length(var.database_subnets) > 0 ? local.nat_gateway_count : 0
#   vpc_id = aws_vpc.this.id

#   tags = merge(
#     {
#       "Name" = format(
#         "${"rt"}-%s-%s",
#         var.subnet_database_name,
#         element(var.azs, count.index),
#       )
#     },
#     var.tags,
#     var.database_route_table_tags,
#   )
# }

# ################################################################################
# # Database subnet
# ################################################################################

# resource "aws_subnet" "database" {
#   count = length(var.database_subnets) >= length(var.azs) ? length(var.azs) : 0

#   vpc_id               = aws_vpc.this.id
#   cidr_block           = element(var.database_subnets, count.index)
#   availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
#   availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null

#   tags = merge(
#     {
#       "Name" = format(
#         "${"subnet"}-%s-${var.name}-%s",
#         var.subnet_database_name,
#         element(var.azs, count.index),
#       )
#     },
#     var.tags,
#     var.database_subnet_tags,
#   )
# }


# resource "aws_db_subnet_group" "database" {
#   count = var.create_database_subnet_group && length(var.database_subnets) >= length(var.azs) ? 1 : 0

#   name        = format("${"db-group"}-%s", var.subnet_database_name)
#   description = "Database subnet group for ${var.subnet_database_name}"
#   subnet_ids  = aws_subnet.database.*.id

#   tags = merge(
#     {
#       "Name" = format(
#         "${"db-group"}-%s",
#         var.subnet_database_name,
#       )
#     },
#     var.tags,
#     var.database_subnet_group_tags,
#   )
# }


# ################################################################################
# # Infra Route Table
# ################################################################################

# resource "aws_route_table" "infra" {
#   count  = length(var.infra_subnets) > 0 ? local.nat_gateway_count : 0
#   vpc_id = aws_vpc.this.id

#   tags = merge(
#     {
#       "Name" = format(
#         "${"rt"}-%s-%s",
#         var.subnet_infra_name,
#         element(var.azs, count.index),
#       )
#     },
#     var.tags,
#     var.infra_route_table_tags,
#   )
# }

# ################################################################################
# # infra subnet
# ################################################################################

# resource "aws_subnet" "infra" {
#   count = length(var.infra_subnets) >= length(var.azs) ? length(var.azs) : 0

#   vpc_id               = aws_vpc.this.id
#   cidr_block           = element(var.infra_subnets, count.index)
#   availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
#   availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null

#   tags = merge(
#     {
#       "Name" = format(
#         "${"subnet"}-%s-${var.name}-%s",
#         var.subnet_infra_name,
#         element(var.azs, count.index),
#       )
#     },
#     var.tags,
#     var.infra_subnet_tags,
#   )
# }


# ################################################################################
# # Route table associations
# ################################################################################

# resource "aws_route_table_association" "public" {
#   count = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

#   subnet_id      = element(aws_subnet.public.*.id, count.index)
#   route_table_id = element(aws_route_table.public.*.id, count.index)
# }

# resource "aws_route_table_association" "private" {
#   count = length(var.private_subnets) > 0 ? local.route_private_count : 0

#   subnet_id      = element(aws_subnet.private.*.id, count.index)
#   route_table_id = element(aws_route_table.private.*.id, count.index)
# }

# resource "aws_route_table_association" "database" {
#   count = length(var.database_subnets) > 0 ? local.route_database_count : 0

#   subnet_id      = element(aws_subnet.database.*.id, count.index)
#   route_table_id = element(aws_route_table.database.*.id, count.index)
# }

# resource "aws_route_table_association" "infra" {
#   count = length(var.infra_subnets) > 0 ? local.route_infra_count : 0

#   subnet_id      = element(aws_subnet.infra.*.id, count.index)
#   route_table_id = element(aws_route_table.infra.*.id, count.index)
# }



