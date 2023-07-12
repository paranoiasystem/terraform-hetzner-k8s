resource "hcloud_server" "worker" {
  count       = var.qty
  name        = "worker-${count.index}"
  image       = var.os_type
  server_type = var.server_type
  location    = var.location
  ssh_keys = [var.ssh_key_id]
  labels = {
    "k8s" = "worker"
  }

  public_net {
    ipv4_enabled = false
    ipv6_enabled = false
  }

  network {
    network_id = var.private_network_id
  }

  provisioner "remote-exec" {
    inline = [
      "ip route add default via 10.0.0.1",
      "sudo apt update",
      "sudo apt upgrade -y",
      "sudo apt install networkd-dispatcher -y",
      "printf '#!/bin/sh\n\n/sbin/ip route add default via 10.0.0.1\n' | sudo tee /etc/networkd-dispatcher/routable.d/50-masq",
      "sudo chmod +x /etc/networkd-dispatcher/routable.d/50-masq",
      "echo 'DNS=185.12.64.2 185.12.64.1' | sudo tee -a /etc/systemd/resolved.conf",
      "sudo systemctl restart systemd-resolved",
      "sudo systemctl restart networkd-dispatcher",
      "sudo apt install python3 -y",
      "echo Done!"
    ]

    connection {
      host        = tolist(self.network)[0].ip
      type        = "ssh"
      user        = "root"
      private_key = var.ssh_private_key

      bastion_host        = var.bastion_host_ip
      bastion_user        = "root"
      bastion_private_key = var.ssh_private_key
    }
  }

}
