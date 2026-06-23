import {
  id = "vlan99"
  to = module.vlan_mgmt.routeros_interface_vlan.this
}

import {
  id = "untagged=vlan99"
  to = module.vlan_mgmt.routeros_interface_bridge_vlan.this
}

import {
  id = "interface=vlan99"
  to = module.vlan_mgmt.routeros_ip_address.this
}

import {
  id = "vlan99-ip-pool"
  to = module.vlan_mgmt.routeros_ip_pool.this
}

import {
  id = "vlan99-dhcp-server"
  to = module.vlan_mgmt.routeros_ip_dhcp_server.this
}

import {
  id = "gateway=10.10.99.1"
  to = module.vlan_mgmt.routeros_ip_dhcp_server_network.this
}

import {
  id = "pvid=99"
  to = module.vlan_mgmt.routeros_interface_bridge_port.this["ether5"]
}

module "vlan_mgmt" {
  source = "./modules/vlan"

  vlan_id               = 99
  first_three_ip_octets = "10.10.99"
  bridge                = routeros_interface_bridge.this.name
  tagged_ports          = [routeros_interface_ethernet.switch.name]
  untagged_ports        = [routeros_interface_ethernet.mgmt.name]
}

module "mgmt_interface_list" {
  source = "./modules/interface_list"

  name = "mgmt"

  members = [
    module.vlan_mgmt.name,
    routeros_interface_ethernet.mgmt.name,
    module.vlan_legacy.name
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