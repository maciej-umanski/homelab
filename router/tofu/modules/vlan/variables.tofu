variable "vlan_id" {
  type        = string
  description = "The ID of the VLAN interface"
}

variable "bridge" {
  type        = string
  description = "The name of the bridge to which the VLAN interface will be added"
}

variable "name_prefix" {
  type        = string
  description = "The prefix for the VLAN interface name"
  default     = "vlan"
}

variable "first_two_ip_octets" {
  type        = string
  description = "The first two octets of the IP address for the VLAN interface"
  default     = "10.10"
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

variable "tagged_ports" {
  type        = list(string)
  description = "A list of tagged ports to add to the bridge for this VLAN"
  default     = []
}

variable "untagged_ports" {
  type        = list(string)
  description = "A list of untagged ports to add to the bridge for this VLAN"
  default     = []
}