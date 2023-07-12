resource "tls_private_key" "tls_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "hcloud_ssh_key" "ssh_key" {
  name       = var.ssh_key_name
  public_key = tls_private_key.tls_key.public_key_openssh
}
