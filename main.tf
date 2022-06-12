resource "libvirt_domain" "coreos" {
  name            = format(var.hostname_format, count.index)
  autostart       = true
  vcpu            = var.vcpu
  memory          = var.vmem
  qemu_agent      = true
  count           = var.node_count
  fw_cfg_name     = "opt/com.coreos/config"
  coreos_ignition = libvirt_ignition.ignition[count.index].id

  network_interface {
    bridge         = "br0"
    wait_for_lease = true
  }

  disk {
    volume_id = libvirt_volume.coreos_node[count.index].id
    scsi      = true
  }

  xml {
    xslt = file("./xsl/add_GA_channel.xsl")
  }

}

resource "libvirt_ignition" "ignition" {
  name    = "${format(var.hostname_format, count.index)}-ignition"
  pool    = "default"
  count   = var.node_count
  content = data.ignition_config.k3s_ignition_config[count.index].rendered
}
