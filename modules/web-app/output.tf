output "instance_id" {
  value       = aws_instance.my_vm.id
  description = "Instance ID"
}
output "ec2_server_ip" {
  value = aws_instance.web_server.public_ip
}