output "vpc_id" {
  value = aws_vpc.project_vpc.id
}

output "priv_sub_id" {
  value = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

output "pub_subnet_id" {
  value = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}