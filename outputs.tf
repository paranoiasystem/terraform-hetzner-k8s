output "ssh_private_key" {
  description = "The private SSH key of the bastion host"
  value       = module.ssh_key.private_key
  sensitive   = true
}

output "ssh_public_key" {
  description = "The public SSH key of the bastion host"
  value       = module.ssh_key.public_key
}

output "bastion_ip" {
  description = "The IP address of the bastion host"
  value       = module.bastion_host.bastion_ip
}
