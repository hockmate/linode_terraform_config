terraform {
  required_providers {
    linode = {
        source = "linode/linode"
    }
  }
}

provider "linode" {
    token = var.token
    api_version = "v4beta"
}

resource "linode_instance" "vm3" {
    label = "VM-3"
    image = "linode/fedora36"
    region = "eu-central"
    type = "g6-standard-2"
    root_pass = var.root-pass
}

resource "linode_firewall" "vm3_fw" {
  label = "VM3-firewall"

  inbound {
    label = "allow-http"
    action = "ACCEPT"
    protocol = "TCP"
    ports = "80"
    ipv4 = ["0.0.0.0/0"]
  }
  inbound_policy = "DROP"

  outbound_policy = "ACCEPT"

  linodes = [linode_instance.vm3.id]
}

variable "token" {}
variable "root-pass" {}