terraform {
  required_providers {
    linode = {
        source = "linode/linode"
    }
  }
}

provider "linode" {
    token = var.token 
}

resource "linode_instance" "proxy" {
  label = "Proxy"
  image = "linode/fedora36"
  region = "eu-central"
  type = "g6-nanode-1"
  root_pass = var.root-pass
  authorized_keys = [linode_sshkey.pubkey.ssh_key]
  provisioner "local-exec" {
    command = "while ! nc -z ${linode_instance.proxy.ip_address} 22 > /dev/null; do sleep 10;done"
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${linode_instance.proxy.ip_address},' --private-key ${var.ssh_private_key} setup.yaml"
  }
}

resource "linode_sshkey" "pubkey" {
  label = "pubkey"
  ssh_key = chomp(file(var.ssh_public_key))
}




variable "token" {}
variable "root-pass" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}