resource "local_file" "ansible_inventory" {
  content = templatefile(
    "${path.root}/templates/ansible_inventory.tpl",
    {
      controlplane = var.controlplane_ip_address
      worker = var.worker_ip_address
      bastion_host_ip = var.bastion_host_ip
      ssh_private_key_path = "${path.root}/ansible/private_key.pem"
    }
  )
  filename = "${path.root}/ansible/inventory"
}
