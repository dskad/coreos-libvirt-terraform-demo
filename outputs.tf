output "ip_addresses" {
  value = libvirt_domain.coreos[*].network_interface.0.addresses
}