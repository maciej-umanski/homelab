variable "system" {
  type = object({
    firewall_log_enabled = optional(bool, false)
  })
  description = "System settings"
}

variable "routeros" {
  type = object({
    url      = string
    username = optional(string, "admin")
    password = string
    insecure = optional(bool, true)
  })
  description = "RouterOS connection settings"
  sensitive   = true
}

variable "pppoe" {
  type = object({
    vlan_id   = number
    username  = string
    password  = string
    interface = string
  })
  description = "PPPoE WAN connection settings"
  sensitive   = true
}

variable "guest_network" {
  type = object({
    ssid = string
    pass = string
  })
  description = "Guest WiFi network (isolated, single-band 5 GHz virtual AP)"
}

variable "main_network" {
  type = object({
    ssid   = string
    hidden = optional(bool, false)
    vlans = map(object({
      id             = number
      ppsk           = optional(string)
      tagged_ports   = optional(list(string), [])
      untagged_ports = optional(list(string), [])
      leases = optional(map(object({
        ip        = number
        mac       = string
        hostnames = optional(list(string), [])
        wildcard  = optional(bool, false)
      })), {})
    }))
  })
  description = "Main unified WiFi network with per-segment VLAN configuration and PPSK dynamic VLAN assignment"
}

variable "wireguard_clients" {
  type        = set(string)
  description = "A set of WireGuard client names to create"
  default     = []
}

variable "switch_config" {
  type = object({
    ip        = string
    interface = string
  })
  description = "Switch configuration for the main network (IP address and interface)"
}
