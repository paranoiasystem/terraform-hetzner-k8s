provider "hcloud" {
  token = var.hcloud_token
}
module "ssh_key" {
  source       = "./modules/ssh_key"
  ssh_key_name = "k8s-cluster-key"
}

module "private_network" {
  source                 = "./modules/private_network"
  network_name           = "k8s-network"
}

module "bastion_host" {
  source = "./modules/bastion_host"
  ssh_key_id = module.ssh_key.ssh_key_id
  private_network_id = module.private_network.network_id
  ssh_private_key = module.ssh_key.private_key
}

module "controlplane" {
  source = "./modules/controlplane"
  ssh_key_id = module.ssh_key.ssh_key_id
  private_network_id = module.private_network.network_id
  ssh_private_key = module.ssh_key.private_key
  bastion_host_ip = module.bastion_host.bastion_ip

  depends_on = [ module.bastion_host ]
}

module "worker" {
  source = "./modules/worker"
  ssh_key_id = module.ssh_key.ssh_key_id
  private_network_id = module.private_network.network_id
  ssh_private_key = module.ssh_key.private_key
  bastion_host_ip = module.bastion_host.bastion_ip

  depends_on = [ module.bastion_host ]
}

module "load_balancer" {
  source = "./modules/load_balancer"
  network_id = module.private_network.network_id
  targets = concat(module.controlplane.controlplane_ids, module.worker.worker_ids)
}

module "ansible_inventory" {
  source = "./modules/ansible_inventory"
  controlplane_ip_address = module.controlplane.controlplane_ip_address
  worker_ip_address = module.worker.worker_ip_address
  bastion_host_ip = module.bastion_host.bastion_ip
}

# module "run_ansible_playbooks" {
#   source = "./modules/run_ansible_playbooks"
#   ansible_inventory_content = module.ansible_inventory.ansible_inventory_content
#   ssh_private_key = module.ssh_key.private_key
# }