resource "libvirt_volume" "coreos_base" {
  name   = "coreos_base.qcow2"
  source = var.img_file
  format = "qcow2"
}

resource "libvirt_volume" "coreos_node" {
  name           = "${format(var.hostname_format, count.index)}.qcow2"
  base_volume_id = libvirt_volume.coreos_base.id
  size           = 80 * 1024 * 1024 * 1024 # Size (80 Gb) is in bytes
  count          = var.node_count
}
