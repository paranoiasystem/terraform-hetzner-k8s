variable "lb_name" {
  type        = string
  description = "The name of the load balancer"
  default     = "k8s-lb"
}

variable "lb_type" {
  type        = string
  description = "The type of the load balancer"
  default     = "lb11"
}

variable "location" {
  type        = string
  description = "The location of the load balancer"
  default     = "nbg1"
}

variable "network_id" {
  type        = string
  description = "The ID of the network"
  default     = "hcloud_network.network.id"
}

variable "targets" {
  type = list(object({
    id = string
  }))
  description = "The targets of the load balancer"
}