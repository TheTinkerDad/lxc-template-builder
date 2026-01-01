source "lxc" "ct" {
  config_file = "./config/lxc.conf"
  template_name = "download"
  template_parameters = ["-d", "ubuntu", "-r", "jammy", "-a", "amd64"]
}

build {
  sources = ["source.lxc.ct"]

  provisioner "file" {
    source      = "ssh-keys/ansible-key.pub"
    destination = "/tmp/ansible-key.pub"
  }

  provisioner "shell" {
    script = "scripts/script.sh"
  }

  post-processor "shell-local" {
    inline = ["echo Build successful!"]
  }
}
