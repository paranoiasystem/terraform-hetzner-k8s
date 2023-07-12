resource "hcloud_load_balancer" "load_balancer" {
  name               = var.lb_name
  load_balancer_type = var.lb_type
  location           = var.location

}

resource "hcloud_load_balancer_target" "target" {
  for_each = { for i, target in var.targets : i => target }

  type            = "server"
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  server_id        = each.value.id
  use_private_ip   = true
}

resource "hcloud_load_balancer_network" "load_balancer_network" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  network_id       = var.network_id
}

resource "hcloud_load_balancer_service" "load_balancer_http" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  protocol         = "http"
}

# resource "hcloud_managed_certificate" "managed_cert" {
#   name         = "managed_cert"
#   domain_names = ["*.example.com", "example.com"]
#   labels = {
#     "k8s" = "managed_cert"
#   }
# }

# resource "hcloud_load_balancer_service" "load_balancer_https" {
#   load_balancer_id = hcloud_load_balancer.load_balancer.id
#   protocol         = "https"
#   http {
#     certificates = [hcloud_managed_certificate.managed_cert.id]
#   }
# }