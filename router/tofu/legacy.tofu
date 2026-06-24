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

resource "routeros_interface_vlan" "legacy" {
  interface = routeros_interface_bridge.this.name
  name      = "legacy"
  vlan_id   = 10
}

resource "routeros_interface_bridge_vlan" "legacy" {
  bridge   = routeros_interface_bridge.this.name
  vlan_ids = [routeros_interface_vlan.legacy.vlan_id]
  tagged   = [routeros_interface_bridge.this.name, routeros_interface_ethernet.switch.name]
}

resource "routeros_ip_address" "legacy" {
  address   = "192.168.1.1/24"
  interface = routeros_interface_vlan.legacy.name
  network   = "192.168.1.0"
}

resource "routeros_ip_pool" "legacy" {
  name   = "legacy-ip-pool"
  ranges = ["192.168.1.100-192.168.1.250"]
}

resource "routeros_ip_dhcp_server" "legacy" {
  name                      = "legacy-dhcp-server"
  interface                 = routeros_interface_vlan.legacy.name
  address_pool              = routeros_ip_pool.legacy.name
  dynamic_lease_identifiers = "client-mac,client-id"
  lease_time                = "1d"
  add_arp                   = true
}

resource "routeros_ip_dhcp_server_network" "legacy" {
  address    = "192.168.1.0/24"
  gateway    = "192.168.1.1"
  dns_server = ["192.168.1.1"]
}

resource "routeros_wifi_security" "legacy_5_ghz" {
  name                 = "legacy-wifi-5-security"
  authentication_types = ["wpa2-psk", "wpa3-psk"]
  passphrase           = var.wifi_legacy_5ghz_pass
}

resource "routeros_wifi_configuration" "legacy_5_ghz" {
  name    = "legacy-wifi-5-configuration"
  ssid    = var.wifi_legacy_5ghz_ssid
  country = "Poland"
}

resource "routeros_wifi" "legacy_5_ghz" {
  name             = "legacy-wifi-5-ghz"
  master_interface = "wifi1"
  disabled         = false

  configuration = {
    config = routeros_wifi_configuration.legacy_5_ghz.name
  }
  security = {
    config = routeros_wifi_security.legacy_5_ghz.name
  }
}

resource "routeros_interface_bridge_port" "legacy_5_ghz" {
  bridge      = routeros_interface_bridge.this.name
  interface   = routeros_wifi.legacy_5_ghz.name
  pvid        = routeros_interface_vlan.legacy.vlan_id
  frame_types = "admit-only-untagged-and-priority-tagged"
}

resource "routeros_wifi_security" "legacy_2_4_ghz" {
  name                 = "legacy-wifi-2-4-security"
  authentication_types = ["wpa2-psk", "wpa3-psk"]
  passphrase           = var.wifi_legacy_2_4ghz_pass
}

resource "routeros_wifi_configuration" "legacy_2_4_ghz" {
  name    = "legacy-wifi-2-4-configuration"
  ssid    = var.wifi_legacy_2_4ghz_ssid
  country = "Poland"
}

resource "routeros_wifi" "legacy_2_4_ghz" {
  name             = "legacy-wifi-2-4-ghz"
  master_interface = "wifi2"
  disabled         = false

  configuration = {
    config = routeros_wifi_configuration.legacy_2_4_ghz.name
  }

  security = {
    config = routeros_wifi_security.legacy_2_4_ghz.name
  }
}
resource "routeros_interface_bridge_port" "legacy_2_4_ghz" {
  bridge      = routeros_interface_bridge.this.name
  interface   = routeros_wifi.legacy_2_4_ghz.name
  pvid        = routeros_interface_vlan.legacy.vlan_id
  frame_types = "admit-only-untagged-and-priority-tagged"
}
