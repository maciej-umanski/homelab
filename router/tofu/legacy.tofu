# Configuration for backwards compatibility for existing devices to connect to without needing to change WiFi settings.
# This is not intended for long-term use, but will be kept around until all devices have been migrated to the new WiFi network.

variable "wifi_legacy_5ghz_ssid" {
  type        = string
  description = "The SSID for the main WiFi network"
  sensitive   = true
}

variable "wifi_legacy_5ghz_pass" {
  type        = string
  description = "The password for the main WiFi network"
  sensitive   = true
}

variable "wifi_legacy_2_4ghz_ssid" {
  type        = string
  description = "The SSID for the Main WiFi network"
  sensitive   = true
}

variable "wifi_legacy_2_4ghz_pass" {
  type        = string
  description = "The password for the Main WiFi network"
  sensitive   = true
}

module "vlan_legacy" {
  source = "./modules/vlan"

  vlan_id               = 10
  bridge                = routeros_interface_bridge.this.name
  first_three_ip_octets = "192.168.1"

  tagged_ports = [
    routeros_interface_ethernet.switch.name
  ]

  untagged_ports = [
    routeros_interface_ethernet.lan_1.name,
    routeros_interface_ethernet.lan_2.name
  ]
}

module "wifi_legacy_5ghz" {
  source = "./modules/wifi"

  vlan_id          = module.vlan_legacy.vlan_id
  bridge           = routeros_interface_bridge.this.name
  ssid             = var.wifi_legacy_5ghz_ssid
  pass             = var.wifi_legacy_5ghz_pass
  parent_interface = routeros_wifi.wifi_5_ghz.name
}

module "wifi_legacy_2_4ghz" {
  source = "./modules/wifi"

  vlan_id          = module.vlan_legacy.vlan_id
  bridge           = routeros_interface_bridge.this.name
  ssid             = var.wifi_legacy_2_4ghz_ssid
  pass             = var.wifi_legacy_2_4ghz_pass
  ft_enabled       = false
  parent_interface = routeros_wifi.wifi_2_4_ghz.name
}