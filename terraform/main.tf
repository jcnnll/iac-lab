terraform {
  required_version = ">= 1.14.8"

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.1"
    }
  }
}

resource "local_file" "config" {
  # Use single $ to resolve the path and render the template
  filename = "${path.module}/.dns.yaml"
  content = templatefile("${path.module}/vm_base.tftpl", {
    image_url   = "https://cloud-images.ubuntu.com/releases/jammy/release/ubuntu-22.04-server-cloudimg-arm64.img"
    socket_path = "/tmp/vlab_vmnet"
    static_ip   = "192.168.2.10"
    hostname    = "dns"
    cpus        = 1
    memory      = "512MiB"
  })
}

resource "null_resource" "dns" {
  depends_on = [local_file.config]

  provisioner "local-exec" {
    command = "limactl create --name=dns ${local_file.config.filename} && limactl start dns"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "limactl stop dns && limactl delete dns"
  }
}

