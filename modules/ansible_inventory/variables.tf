variable "controlplane_ip_address" {
  type = map(list(string))
  default = {}
}

variable "worker_ip_address" {
  type = map(list(string))
  default = {}
}

variable "bastion_host_ip" {
  type = string
  default = ""
}