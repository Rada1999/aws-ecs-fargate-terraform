output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "nat_gateway_public_ip" {
  description = "Public IP of the NAT Gateway"
  value       = aws_eip.nat.public_ip
}

output "ecr_repository_url" {
  description = "URL of the ECR repository - use this to push images"
  value       = aws_ecr_repository.app.repository_url
}

output "alb_url" {
  description = "URL of the load balancer - open this in a browser"
  value       = "http://${aws_lb.app.dns_name}"
}

output "cloudfront_url" {
  description = "HTTPS URL served by CloudFront - open this in a browser"
  value       = "https://${aws_cloudfront_distribution.app.domain_name}"
}
