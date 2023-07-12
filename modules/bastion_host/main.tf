resource "hcloud_server" "bastion_host" {
  name        = "bastion-host"
  image       = var.os_type
  server_type = var.server_type
  location    = var.location

  ssh_keys = [
    var.ssh_key_id
  ]

  network {
    network_id = var.private_network_id
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt upgrade -y",
      "sudo apt install networkd-dispatcher -y",
      "printf '#!/bin/sh\n\n/bin/echo 1 > /proc/sys/net/ipv4/ip_forward\n/sbin/iptables -t nat -A POSTROUTING -s 10.0.0.0/16 -o eth0 -j MASQUERADE\n' | sudo tee /etc/networkd-dispatcher/routable.d/50-masq",
      "sudo chmod +x /etc/networkd-dispatcher/routable.d/50-masq",
      "sudo systemctl restart networkd-dispatcher",
      "sudo apt install python3 -y",
      "echo Done!"
    ]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = var.ssh_private_key
    }
  }

}

resource "hcloud_network_route" "bastion_host_nat" {
  network_id  = var.private_network_id
  destination = "0.0.0.0/0"
  gateway     = tolist(hcloud_server.bastion_host.network)[0].ip
}
