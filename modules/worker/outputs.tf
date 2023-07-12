output "worker_ip_address" {
  value = { 
    for hcloud_server in hcloud_server.worker : 
    hcloud_server.name => [for network in hcloud_server.network : network.ip] 
  }
}

output "worker_ids" {
  value = [ for hcloud_server in hcloud_server.worker : { id = hcloud_server.id } ]
}