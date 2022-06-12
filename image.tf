data "http" "coreos_metadata" {
  url = "https://builds.coreos.fedoraproject.org/streams/${var.coreos_channel}.json"
}

locals {
  coreos_metadata        = jsondecode(data.http.coreos_metadata.body)
  img_url                = local.coreos_metadata.architectures.x86_64.artifacts.qemu.formats["qcow2.xz"].disk.location
  coreos_release         = local.coreos_metadata.architectures.x86_64.artifacts.qemu.release
  signature              = local.coreos_metadata.architectures.x86_64.artifacts.qemu.formats["qcow2.xz"].disk.signature
  sha256_hash            = local.coreos_metadata.architectures.x86_64.artifacts.qemu.formats["qcow2.xz"].disk.sha256
  uncompress_sha256_hash = local.coreos_metadata.architectures.x86_64.artifacts.qemu.formats["qcow2.xz"].disk.uncompressed-sha256
  img_file               = "${path.root}/img/fedora-coreos-${local.coreos_release}-qemu.x86_64.qcow2"
  img_file_exists        = fileexists(local.img_file)
}

resource "null_resource" "coreos_img_download" {
  triggers = {
    on_version_change = "${local.coreos_release}"
    # file_downloaded = local.img_file_exists
  }

  provisioner "local-exec" {
    command = "curl --create-dirs --output-dir img/${path.root} -OL ${local.img_url}"
  }

  provisioner "local-exec" {
    command = "xz -d ${local.img_file}.xz"
  }
}