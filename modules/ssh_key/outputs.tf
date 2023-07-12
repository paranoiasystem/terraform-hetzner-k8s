output "public_key" {
  description = "The public key"
  value       = tls_private_key.tls_key.public_key_openssh
}

output "private_key" {
  description = "The private key"
  value       = tls_private_key.tls_key.private_key_pem
  sensitive   = true
}

output "ssh_key_id" {
  description = "The ID of the SSH key"
  value       = hcloud_ssh_key.ssh_key.id
}
