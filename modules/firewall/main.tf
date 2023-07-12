source "hcloud_firewall" "k8s_firewall" {
  name = "k8s-firewall"

  rule {
    description = "Allow ICMP In"
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    description = "Allow SSH In"
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    description = "Allow ICMP Out"
    direction = "out"
    protocol = "icmp"
    destination_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    description = "Allow DNS TCP Out"
    direction = "out"
    protocol = "tcp"
    port = "53"
    destination_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    description = "Allow DNS UDP Out"
    direction = "out"
    protocol = "udp"
    port = "53"
    destination_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    description = "Allow HTTP Out"
    direction = "out"
    protocol = "tcp"
    port = "80"
    destination_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    description = "Allow HTTPS Out"
    direction = "out"
    protocol = "tcp"
    port = "443"
    destination_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    description = "Allow NTP UDP Out"
    direction = "out"
    protocol = "udp"
    port = "123"
    destination_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

}