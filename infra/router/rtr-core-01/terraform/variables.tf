variable "system" {
  type = object({
    router_name          = string
    firewall_log_enabled = optional(bool, false)
    timezone             = optional(string, "Europe/Warsaw")
    ntp_server           = optional(string, "time.cloudflare.com")
  })
  description = "System settings"
}

variable "routeros" {
  type = object({
    url      = optional(string, "https://10.10.99.1")
    username = optional(string, "sysadmin")
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
  type = map(object({
    ip = number
  }))
  description = "WireGuard clients configuration (IP address assignment)"
}

variable "switch_config" {
  type = object({
    ip        = string
    interface = string
  })
  description = "Switch configuration for the main network (IP address and interface)"
}
