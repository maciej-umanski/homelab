locals {
  wifi_5_ghz   = "wifi1"
  wifi_2_4_ghz = "wifi2"
}

import {
  id = local.wifi_2_4_ghz
  to = module.wifi_trusted.routeros_wifi.this["wifi2"]
}

import {
  id = local.wifi_5_ghz
  to = module.wifi_trusted.routeros_wifi.this["wifi1"]
}

resource "routeros_wifi_steering" "this" {
  name = "wifi-steering"
  rrm  = true
  wnm  = true
}

module "wifi_trusted" {
  source = "../../../_common/terraform/routeros/wifi"

  vlan_id              = module.vlan_trusted.vlan_id
  bridge               = routeros_interface_bridge.this.name
  parent_interfaces    = [local.wifi_5_ghz, local.wifi_2_4_ghz]
  ssid                 = var.trusted_wifi_ssid
  pass                 = var.trusted_wifi_pass
  steering             = routeros_wifi_steering.this.name
  use_parent_interface = true
}

module "wifi_iot" {
  source = "../../../_common/terraform/routeros/wifi"

  vlan_id           = module.vlan_iot.vlan_id
  bridge            = routeros_interface_bridge.this.name
  parent_interfaces = [local.wifi_2_4_ghz]
  ssid              = var.iot_wifi_ssid
  pass              = var.iot_wifi_pass
  hide_ssid         = true
}

module "wifi_guest" {
  source = "../../../_common/terraform/routeros/wifi"

  vlan_id           = module.vlan_guest.vlan_id
  bridge            = routeros_interface_bridge.this.name
  parent_interfaces = [local.wifi_5_ghz, local.wifi_2_4_ghz]
  ssid              = var.guest_wifi_ssid
  pass              = var.guest_wifi_pass
  steering          = routeros_wifi_steering.this.name
}