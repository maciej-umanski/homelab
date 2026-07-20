variable "routeros" {
  type = object({
    url      = string
    username = optional(string, "sysadmin")
    password = string
    insecure = optional(bool, true)
  })
  description = "RouterOS connection settings"
  sensitive   = true
}

variable "lan_wifi" {
  type = object({
    ssid = string
    pass = string
  })
  sensitive = true
}

variable "wan_wifi" {
  type = object({
    ssid = string
    pass = string
  })
  sensitive = true
}

variable "wireguard" {
  type = object({
    private_key     = string
    peer_public_key = string
    endpoint        = string
    address         = string
    gateway         = string
  })
  description = "WireGuard tunnel configuration back to home network"
  sensitive   = true
}

variable "firewall_log_enabled" {
  type        = bool
  default     = false
  description = "Enable logging of firewall rules"
}
