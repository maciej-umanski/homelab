variable "first_three_octets" {
  type        = string
  description = "The first three octets of the IP address for the VLAN interface"
}

variable "network_size" {
  type        = number
  description = "The network size (CIDR) for the VLAN interface"
  default     = 24
}

variable "first_usable_ip" {
  type        = number
  description = "The last octet of the first usable IP address for the VLAN interface"
  default     = 100
}

variable "last_usable_ip" {
  type        = number
  description = "The last octet of the last usable IP address for the VLAN interface"
  default     = 250
}

variable "dhcp_lease_time" {
  type        = string
  description = "The DHCP lease time for the VLAN interface"
  default     = "1d"
}

variable "interface" {
  type        = string
  description = "The name of the interface to which the VLAN interface will be added"
}

variable "name_prefix" {
  type        = string
  description = "The prefix for the resources created by this module"
  default     = "lan"
}

variable "static_leases" {
  type = map(object({
    ip        = string
    mac       = string
    hostnames = optional(list(string), [])
    wildcard  = optional(bool, false)
  }))
  description = "Static DHCP leases (hostname -> { last ip octet, mac, hostnames, wildcard })"
  default     = {}
}
