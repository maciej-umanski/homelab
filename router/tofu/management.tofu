locals {
  vlan_id   = 99
  vlan_name = "vlan99"
  router_ip = "10.10.99.1"
  switch_ip = "10.10.99.2"
  port      = "ether5"
}

import {
  id = local.vlan_name
  to = module.vlan_mgmt.routeros_interface_vlan.this
}

import {
  id = "untagged=${local.vlan_name}"
  to = module.vlan_mgmt.routeros_interface_bridge_vlan.this
}

import {
  id = "interface=${local.vlan_name}"
  to = module.vlan_mgmt.routeros_ip_address.this
}

import {
  id = "${local.vlan_name}-ip-pool"
  to = module.vlan_mgmt.routeros_ip_pool.this
}

import {
  id = "${local.vlan_name}-dhcp-server"
  to = module.vlan_mgmt.routeros_ip_dhcp_server.this
}

import {
  id = "gateway=${local.router_ip}"
  to = module.vlan_mgmt.routeros_ip_dhcp_server_network.this
}

import {
  id = "pvid=${local.vlan_id}"
  to = module.vlan_mgmt.routeros_interface_bridge_port.this[local.port]
}

module "vlan_mgmt" {
  source = "./modules/vlan"

  vlan_id        = local.vlan_id
  bridge         = routeros_interface_bridge.this.name
  tagged_ports   = [routeros_interface_ethernet.switch.name]
  untagged_ports = [routeros_interface_ethernet.mgmt.name]
}

module "mgmt_interface_list" {
  source = "./modules/interface_list"

  name = "mgmt"

  members = [
    module.vlan_mgmt.name,
    routeros_interface_ethernet.mgmt.name,
    module.vlan_trusted.name
  ]
}

resource "routeros_ip_neighbor_discovery_settings" "this" {
  discover_interface_list = module.mgmt_interface_list.name
}

resource "routeros_tool_mac_server" "this" {
  allowed_interface_list = module.mgmt_interface_list.name
}

resource "routeros_tool_mac_server_winbox" "this" {
  allowed_interface_list = module.mgmt_interface_list.name
}