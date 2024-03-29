source "lxc" "ct" {
  config_file = "./config/lxc.conf"
  template_name = "download"
  template_parameters = ["-d", "ubuntu", "-r", "focal", "-a", "amd64"]
}

build {
  sources = ["source.lxc.ct"]

  provisioner "shell" {
    script = "scripts/script.sh"
  }

  post-processor "shell-local" {
    inline = ["echo Build successful!"]
  }
}
