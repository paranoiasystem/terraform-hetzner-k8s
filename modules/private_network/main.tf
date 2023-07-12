resource "hcloud_network" "private_network" {
  name     = var.network_name
  ip_range = var.network_ip_range
  labels = {
    name = var.network_name
  }
}

resource "hcloud_network_subnet" "network_subnet" {
  network_id   = hcloud_network.private_network.id
  type         = var.subnet_type
  ip_range     = var.network_ip_range
  network_zone = var.network_zone
}
