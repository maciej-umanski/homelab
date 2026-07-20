locals {
  wifi_interface  = "wlan1"
}

resource "routeros_interface_wireless_security_profiles" "uplink" {
  name                 = "wifi-uplink-security"
  mode                 = "dynamic-keys"
  authentication_types = ["wpa2-psk"]
  wpa2_pre_shared_key  = var.wan_wifi.pass

  lifecycle { ignore_changes = [wpa2_pre_shared_key] }
}

resource "routeros_interface_wireless" "uplink" {
  name             = local.wifi_interface
  mode             = "station"
  ssid             = var.wan_wifi.ssid
  security_profile = routeros_interface_wireless_security_profiles.uplink.name
  disabled         = false
  band             = "2ghz-b/g/n"

  lifecycle { ignore_changes = [ssid] }
}

resource "routeros_interface_wireless_security_profiles" "downlink" {
  name                 = "wifi-downlink-security"
  mode                 = "dynamic-keys"
  authentication_types = ["wpa2-psk"]
  wpa2_pre_shared_key  = var.lan_wifi.pass
}

resource "routeros_interface_wireless" "downlink" {
  name             = "${routeros_interface_wireless.uplink.name}-virtual"
  master_interface = routeros_interface_wireless.uplink.name
  mode             = "ap-bridge"
  ssid             = var.lan_wifi.ssid
  security_profile = routeros_interface_wireless_security_profiles.downlink.name
  disabled         = false
  band             = "2ghz-b/g/n"
}

resource "routeros_interface_bridge_port" "downlink" {
  bridge    = routeros_interface_bridge.this.name
  interface = routeros_interface_wireless.downlink.name
}
