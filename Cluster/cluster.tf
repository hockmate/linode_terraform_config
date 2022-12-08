resource "linode_instance" "master" {
  count = 1
  label = "Master-${count.index + 1}"
  image = "linode/fedora36"
  region = "eu-central"
  type = "g6-standard-2"
  root_pass = var.root-pass 
  authorized_keys = [linode_sshkey.pubkey.ssh_key]
}

resource "local_file" "ipaddresses" {
  content = <<-EOT
%{for vm in linode_instance.master.* ~}
${vm.ip_address}
%{endfor}
  EOT
  filename = "master_ips.txt"
}