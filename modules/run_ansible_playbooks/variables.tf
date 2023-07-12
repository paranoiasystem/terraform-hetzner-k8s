variable "ansible_inventory_content" {
  description = "The content of the Ansible inventory file"
  type        = string
}

variable "ssh_private_key" {
  description = "The SSH private key"
  type        = string
  sensitive   = true
}