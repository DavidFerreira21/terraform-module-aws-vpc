output "vcp_id" {
  description = "string of vpc id"
  value = aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "string of cidr block"
  value = aws_vpc.this.cidr_block
}

output "public_subnets_ids" {
 description = "map of public_subnets ids"
 value = { for k, v in aws_subnet.public : k => v.id }
}

output "private_subnets_ids" {
 description = "map of private_subnets ids"
 value = {for k, v in aws_subnet.private : k => v.id }
}
output "infra_subnets_ids" {
  description = "map of infra_subnets ids"
  value = { for k, v in aws_subnet.infra : k => v.id }
}

output "database_subnets_ids" {
  description = "map of database_subnets ids"
  value = { for k, v in aws_subnet.database : k => v.id }
}

output "public_route_table_ids" {
  description = "list of public_route_table ids"
  value = aws_route_table.public[*].id
}

output "private_route_table_ids" {
  description = "list of private_route_table ids"
  value = aws_route_table.private[*].id
}


output "infra_route_table_ids" {
  description = "list of infra_route_table ids"
  value = aws_route_table.infra[*].id
}

output "database_route_table_ids" {
  description = "list of database_route_table ids"
  value = aws_route_table.database[*].id
}






