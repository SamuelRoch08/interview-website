output "vpc_id" {
  value = aws_vpc.main.id
}

output "publics_subnets_ids" {
  value = aws_subnet.publics[*].id
}

output "datas_subnets_ids" {
  value = aws_subnet.datas[*].id
}

output "apps_subnets_ids" {
  value = aws_subnet.apps[*].id
}

output "nat_public_ips" {
  value = aws_eip.eip[*].public_ip
}