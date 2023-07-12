output "controlplane_ip_address" {
  value = { 
    for hcloud_server in hcloud_server.controlplane : 
    hcloud_server.name => [for network in hcloud_server.network : network.ip]
  }
}

output "controlplane_ids" {
  value = [ for hcloud_server in hcloud_server.controlplane : { id = hcloud_server.id } ]
}