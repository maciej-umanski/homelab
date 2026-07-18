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
