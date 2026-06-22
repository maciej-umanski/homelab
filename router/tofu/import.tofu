# After bootstrapping the router with the `bootstrap` module, we can import the existing configuration into Terraform state.
# This allows us to manage the router's configuration with Terraform going forward.

locals {
  vlan        = "vlan99"
  ip_pool     = "${local.vlan}-ip-pool"
  dhcp_server = "${local.vlan}-dhcp-server"

  bridge_vlan_id  = "*4"
  bridge_port_id  = "*0"
  ip_address_id   = "*1"
  dhcp_network_id = "*1"
}

import {
  id = local.hardware_interface.bridge
  to = routeros_interface_bridge.this
}

import {
  id = local.vlan
  to = module.vlan_mgmt.routeros_interface_vlan.this
}

import {
  id = local.bridge_vlan_id
  to = module.vlan_mgmt.routeros_interface_bridge_vlan.this
}

import {
  id = local.ip_address_id
  to = module.vlan_mgmt.routeros_ip_address.this
}

import {
  id = local.ip_pool
  to = module.vlan_mgmt.routeros_ip_pool.this
}

import {
  id = local.dhcp_server
  to = module.vlan_mgmt.routeros_ip_dhcp_server.this
}

import {
  id = local.dhcp_network_id
  to = module.vlan_mgmt.routeros_ip_dhcp_server_network.this
}

import {
  id = local.hardware_interface.ether1
  to = routeros_interface_ethernet.ether1
}

import {
  id = local.hardware_interface.ether2
  to = routeros_interface_ethernet.ether2
}

import {
  id = local.hardware_interface.ether3
  to = routeros_interface_ethernet.ether3
}

import {
  id = local.hardware_interface.ether4
  to = routeros_interface_ethernet.ether4
}

import {
  id = local.hardware_interface.ether5
  to = routeros_interface_ethernet.ether5
}

import {
  id = local.bridge_port_id
  to = module.vlan_mgmt.routeros_interface_bridge_port.this[local.hardware_interface.ether5]
}

import {
  id = local.hardware_interface.wifi_5_ghz
  to = routeros_wifi.wifi_5_ghz
}

import {
  id = local.hardware_interface.wifi_2_4_ghz
  to = routeros_wifi.wifi_2_4_ghz
}