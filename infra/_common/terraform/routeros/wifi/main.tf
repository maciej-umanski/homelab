locals {
  wifi_name = "${var.name_prefix}${var.vlan_id}"
}

resource "routeros_wifi_datapath" "this" {
  name             = "${local.wifi_name}-datapath"
  client_isolation = var.client_isolation
}

resource "routeros_wifi_configuration" "this" {
  name      = "${local.wifi_name}-configuration"
  ssid      = var.ssid
  country   = var.country
  hide_ssid = var.hide_ssid
  steering  = var.steering != "" ? { config = var.steering } : null
  datapath  = { config = routeros_wifi_datapath.this.name }
}

resource "routeros_wifi_security" "this" {
  name                 = "${local.wifi_name}-security"
  authentication_types = ["wpa2-psk", "wpa3-psk"]
  ft                   = var.ft_enabled
  passphrase           = var.pass
}

resource "routeros_wifi" "this" {
  for_each = var.parent_interfaces

  name             = var.use_parent_interface ? each.key : "${local.wifi_name}-${each.key}"
  master_interface = var.use_parent_interface ? null : each.key
  disabled         = false

  configuration = {
    config = routeros_wifi_configuration.this.name
  }

  security = {
    config = routeros_wifi_security.this.name
  }
}

resource "routeros_interface_bridge_port" "this" {
  for_each = routeros_wifi.this

  bridge      = var.bridge
  interface   = each.value.name
  pvid        = var.vlan_id
  frame_types = "admit-only-untagged-and-priority-tagged"
}