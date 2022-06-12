terraform {
  required_version = ">=1.0"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.12"
    }

    ignition = {
      source  = "community-terraform-providers/ignition"
      version = "2.1.2"
    }

    http = {
      source  = "hashicorp/http"
      version = "2.2.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
  }
}
