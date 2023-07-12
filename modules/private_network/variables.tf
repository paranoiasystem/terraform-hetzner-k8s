variable "network_name" {
  type        = string
  description = "The name of the network"
  default     = "my-network"
}
variable "network_ip_range" {
  type        = string
  description = "The IP range for the network"
  default     = "10.0.0.0/16"
}

variable "subnet_type" {
  type        = string
  description = "The type of the subnet"
  default     = "cloud"
}

variable "network_zone" {
  type        = string
  description = "The zone of the network"
  default     = "eu-central"
}
