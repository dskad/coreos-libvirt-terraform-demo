output "coreos_img_url" {
  value = local.img_url
}

output "coreos_release" {
  value = local.coreos_release
}

output "ip_addresses" {
  value = libvirt_domain.coreos[*].network_interface.0.addresses
}