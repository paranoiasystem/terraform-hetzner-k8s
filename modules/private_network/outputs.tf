output "network_id" {
  description = "The ID of the private network"
  value       = hcloud_network.private_network.id
}
