locals {
  switch_interface = "ether1"
  switch_ip        = "10.10.99.2"
}

import {
  id = local.switch_interface
  to = routeros_interface_ethernet.switch
}

resource "routeros_interface_ethernet" "switch" {
  factory_name = local.switch_interface
  name         = "ether1"
}

resource "routeros_interface_bridge_port" "switch" {
  bridge      = routeros_interface_bridge.this.name
  interface   = routeros_interface_ethernet.switch.name
  frame_types = "admit-only-vlan-tagged"
}

resource "routeros_ip_firewall_addr_list" "switch" {
  list    = "switch"
  address = local.switch_ip
}
