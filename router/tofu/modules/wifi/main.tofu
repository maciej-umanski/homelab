locals {
  wifi_name = "${var.parent_interface}-${var.name_prefix}${var.vlan_id}"
}

resource "routeros_wifi_security" "this" {
  name                 = "${local.wifi_name}-security"
  authentication_types = ["wpa2-psk", "wpa3-psk"]
  ft                   = var.ft_enabled
  passphrase           = var.pass
}

resource "routeros_wifi_configuration" "this" {
  name      = "${local.wifi_name}-configuration"
  ssid      = var.ssid
  country   = var.country
  hide_ssid = var.hide_ssid
  steering  = var.steering_name != "" ? { config = var.steering_name } : null
}

resource "routeros_wifi" "this" {
  name             = "${local.wifi_name}-5-ghz"
  master_interface = var.parent_interface
  disabled         = false

  configuration = {
    config = routeros_wifi_configuration.this.name
  }
  security = {
    config = routeros_wifi_security.this.name
  }
}

resource "routeros_interface_bridge_port" "this" {
  bridge      = var.bridge
  interface   = routeros_wifi.this.name
  pvid        = var.vlan_id
  frame_types = "admit-only-untagged-and-priority-tagged"
}