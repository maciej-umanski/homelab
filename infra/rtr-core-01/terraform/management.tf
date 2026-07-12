locals {
  vlan_id              = 99
  vlan_name            = "vlan${local.vlan_id}-management"
  router_ip            = "10.10.${local.vlan_id}.1"
  management_interface = "ether5"
}

import {
  id = local.vlan_name
  to = module.vlan["management"].routeros_interface_vlan.this
}

import {
  id = "untagged=${local.management_interface}"
  to = module.vlan["management"].routeros_interface_bridge_vlan.this
}

import {
  id = "interface=${local.vlan_name}"
  to = module.vlan["management"].routeros_ip_address.this
}

import {
  id = "${local.vlan_name}-ip-pool"
  to = module.vlan["management"].routeros_ip_pool.this
}

import {
  id = "${local.vlan_name}-dhcp-server"
  to = module.vlan["management"].routeros_ip_dhcp_server.this
}

import {
  id = "gateway=${local.router_ip}"
  to = module.vlan["management"].routeros_ip_dhcp_server_network.this
}

import {
  id = "pvid=${local.vlan_id}"
  to = module.vlan["management"].routeros_interface_bridge_port.this["ether5"]
}

module "management_interface_list" {
  source = "../../_common/terraform/routeros/interface_list"

  name = "management"
  members = [
    module.vlan["management"].name,
    module.vlan["trusted"].name,
    local.management_interface
  ]
}

resource "routeros_ip_neighbor_discovery_settings" "this" {
  discover_interface_list = module.management_interface_list.name
}

resource "routeros_tool_mac_server" "this" {
  allowed_interface_list = module.management_interface_list.name
}

resource "routeros_tool_mac_server_winbox" "this" {
  allowed_interface_list = module.management_interface_list.name
}
