output "ansible_inventory_content" {
  description = "The content of the Ansible inventory file"
  value       = local_file.ansible_inventory.content
}