variable "token" {
    type = string
    sensitive = true
}

variable "root-pass" {
    type = string
    sensitive = true
}

variable "ssh_public_key" {
    type = string
}

variable "ssh_private_key" {
    type = string
}