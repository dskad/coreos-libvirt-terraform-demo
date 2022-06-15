# CoreOS Channel (stable,testing,next)
# variable "coreos_channel" {
#   description = "CoreOS Channel (stable,testing,next)"
#   type        = string
#   default     = "testing"

#   validation {
#     condition     = contains(["stable", "testing", "next"], var.coreos_channel)
#     error_message = "The coreos_channel value must be one of 'stabe', 'testing', 'next'."
#   }
# }

variable "img_file" {
  description = "CoreOS qcow2 image file"
  type        = string
  default     = "./img/fedora-coreos.qcow2"
}

variable "node_count" {
  description = "Number of nodes"
  default     = 1
}

# variable "control_plane_count" {
#   description = "Number of controle plane nodes"
#   default     = 1
# }

variable "vmem" {
  type        = number
  description = "Virtual RAM in MB"
  default     = 4096
}

variable "vcpu" {
  type        = number
  description = "Nnumber of virtual CPUs"
  default     = 2
}

variable "hostname_format" {
  type    = string
  default = "coreos%02d"
}

variable "ssh_authorized_keys" {
  type        = list(string)
  description = "SSH authorized keys to be added to the core user"
  validation {
    condition = length(var.ssh_authorized_keys) > 0
    error_message   = "The ssh_authorized_keys value must be set."
  }
  sensitive = true
}

variable "unit_description" {
  type        = string
  description = "Description of the systemd unit"
  default     = "Run QEMU guest agent container"
}

