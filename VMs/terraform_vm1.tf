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

resource "linode_instance" "vm1" {
    label = "Master"
    image = "linode/fedora36"
    region = "eu-central"
    type = "g6-standard-2"
    root_pass = var.root-pass 
}

resource "linode_instance" "vm2" {
    label = "Worker-1"
    image = "linode/fedora36"
    region = "eu-central"
    type = "g6-standard-2"
    root_pass = var.root-pass 
}

resource "linode_instance" "vm3" {
    label = "Worker-2"
    image = "linode/fedora36"
    region = "eu-central"
    type = "g6-standard-2"
    root_pass = var.root-pass 
}

resource "linode_instance" "vm4" {
    label = "Proxy-jumper"
    image = "linode/fedora36"
    region = "eu-central"
    type = "g6-standard-1"
    root_pass = var.root-pass 
}

variable "token" {}
variable "root-pass" {}