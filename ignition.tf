data "ignition_config" "k3s_ignition_config" {
  systemd = [
    data.ignition_systemd_unit.qemu_ga.rendered,
    data.ignition_systemd_unit.k3s_install.rendered
  ]

  files = [
    data.ignition_file.hostname[count.index].rendered,
    data.ignition_file.silence_audit_messages.rendered,
    data.ignition_file.k3s_install_script.rendered
  ]

  users = [
    data.ignition_user.core.rendered
  ]

  count = var.node_count
}

# get systemd files
data "ignition_systemd_unit" "k3s_install" {
  name = "k3s-install.service"
  depends_on = [
    data.ignition_file.k3s_install_script
  ]
  content = templatefile("${path.module}/units/k3s-install.service.tftpl",
    { env_config = var.k3s_install_options }
    )
}

data "ignition_systemd_unit" "qemu_ga" {
  name    = "qemu-ga-install.service"
  content = file("${path.module}/units/qemu-ga.service")
}

# Get kernel config file (turn off the console noise!)
data "local_file" "silence_audit_conf" {
  filename = "${path.module}/sysctl/20-silence-audit.conf"
}

data "ignition_file" "silence_audit_messages" {
  path = "/etc/sysctl.d/20-silence-audit.conf"
  mode = 420 # decimal 0644
  content {
    content = data.local_file.silence_audit_conf.content
  }
}

# Set the noes hostname
data "ignition_file" "hostname" {
  path  = "/etc/hostname"
  mode  = 420 # decimal 0644
  count = var.node_count
  content {
    content = format(var.hostname_format, count.index)
  }
}

# Get k3s install script
data "ignition_file" "k3s_install_script" {
  path = "/opt/k3s-install.sh"
  mode = 777
  source {
    source = "https://get.k3s.io"
  }
}

# Add users
data "ignition_user" "core" {
  name = "core"
  ssh_authorized_keys = var.ssh_authorized_keys
}
