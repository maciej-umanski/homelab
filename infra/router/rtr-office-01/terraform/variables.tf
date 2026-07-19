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
    url      = string
    username = optional(string, "admin")
    password = string
    insecure = optional(bool, true)
  })
  description = "RouterOS connection settings"
  sensitive   = true
}

variable "uplink" {
  type = object({
    ssid       = string
    passphrase = string
  })
  description = "WiFi uplink to the main network (station mode). The passphrase selects the target VLAN via the main router PPSK."
  sensitive   = true
}
