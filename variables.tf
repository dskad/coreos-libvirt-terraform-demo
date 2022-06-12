# CoreOS Channel (stable,testing,next)
variable "coreos_channel" {
  description = "CoreOS Channel (stable,testing,next)"
  type        = string
  default     = "testing"

  validation {
    condition     = contains(["stable", "testing", "next"], var.coreos_channel)
    error_message = "The coreos_channel value must be one of 'stabe', 'testing', 'next'."
  }
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