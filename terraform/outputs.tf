output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.octa_server.id
}

output "public_ip" {
  description = "Elastic IP address"
  value       = aws_eip.octa_server_ip.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name"
  value       = aws_instance.octa_server.public_dns
}
