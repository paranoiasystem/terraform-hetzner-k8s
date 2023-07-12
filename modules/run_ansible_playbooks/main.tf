resource "null_resource" "run_ansible_playbooks" {
  # Triggers every time ansible_inventory's content changes
  triggers = {
    ansible_inventory = var.ansible_inventory_content
  }

  provisioner "local-exec" {
    command = <<-EOT
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i "${path.root}/ansible/inventory" "${path.root}/ansible/playbooks/initial.yml"
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i "${path.root}/ansible/inventory" "${path.root}/ansible/playbooks/kube-cluster/kube-dependencies.yml"
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i "${path.root}/ansible/inventory" "${path.root}/ansible/playbooks/kube-cluster/master.yml"
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i "${path.root}/ansible/inventory" "${path.root}/ansible/playbooks/kube-cluster/worker.yml"
    EOT
  }
}