locals {
  wifi_5_ghz   = "wifi1"
  wifi_2_4_ghz = "wifi2"
}

import {
  id = local.wifi_2_4_ghz
  to = routeros_wifi.main["wifi2"]
}

import {
  id = local.wifi_5_ghz
  to = routeros_wifi.main["wifi1"]
}

# =============================================================
# Main - Dual-band unified SSID with PPSK dynamic VLAN
# =============================================================

resource "routeros_wifi_steering" "main" {
  name = "main-steering"
  rrm  = true
  wnm  = true
}

resource "routeros_wifi_datapath" "main" {
  name   = "main-datapath"
  bridge = routeros_interface_bridge.this.name
}

resource "routeros_wifi_configuration" "main" {
  name      = "main-configuration"
  ssid      = var.main_network.ssid
  country   = "Poland"
  hide_ssid = var.main_network.hidden
  steering  = { config = routeros_wifi_steering.main.name }
  datapath  = { config = routeros_wifi_datapath.main.name }
}

resource "routeros_wifi_security" "main" {
  name                   = "main-security"
  authentication_types   = ["wpa2-psk"]
  ft                     = true
  multi_passphrase_group = "main-ppsk"

  depends_on = [module.vlan]
}

resource "routeros_wifi_security_multi_passphrase" "main" {
  for_each = {
    for k, v in var.main_network.vlans : k => v
    if v.ppsk != null
  }

  group      = "main-ppsk"
  passphrase = each.value.ppsk
  vlan_id    = module.vlan[each.key].vlan_id

  depends_on = [module.vlan]
}

resource "routeros_wifi" "main" {
  for_each = toset([local.wifi_5_ghz, local.wifi_2_4_ghz])

  name     = each.key
  disabled = false

  configuration = {
    config = routeros_wifi_configuration.main.name
  }

  security = {
    config = routeros_wifi_security.main.name
  }
}

resource "routeros_interface_bridge_port" "main" {
  for_each = routeros_wifi.main

  bridge      = routeros_interface_bridge.this.name
  interface   = each.value.name
  frame_types = "admit-only-vlan-tagged"
}

# =============================================================
# Guest - 5 GHz virtual AP (slave) with client isolation
# =============================================================

resource "routeros_wifi_datapath" "guest" {
  name             = "guest-datapath"
  bridge           = routeros_interface_bridge.this.name
  client_isolation = true
}

resource "routeros_wifi_configuration" "guest" {
  name     = "guest-configuration"
  ssid     = var.guest_network.ssid
  country  = "Poland"
  datapath = { config = routeros_wifi_datapath.guest.name }
}

resource "routeros_wifi_security" "guest" {
  name                 = "guest-security"
  authentication_types = ["wpa2-psk", "wpa3-psk"]
  ft                   = true
  passphrase           = var.guest_network.pass
}

resource "routeros_wifi" "guest" {
  name             = "guest-${local.wifi_5_ghz}"
  master_interface = local.wifi_5_ghz
  disabled         = false

  configuration = {
    config = routeros_wifi_configuration.guest.name
  }

  security = {
    config = routeros_wifi_security.guest.name
  }
}

resource "routeros_interface_bridge_port" "guest" {
  bridge      = routeros_interface_bridge.this.name
  interface   = routeros_wifi.guest.name
  pvid        = module.vlan["guest"].vlan_id
  frame_types = "admit-only-untagged-and-priority-tagged"
}
