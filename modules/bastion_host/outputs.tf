output "bastion_ip" {
  description = "The IP of the bastion host"
  value       = hcloud_server.bastion_host.ipv4_address
}