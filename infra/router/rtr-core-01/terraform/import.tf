import {
  id = local.bridge
  to = routeros_interface_bridge.this
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
  to = module.vlan["management"].module.ip_config.routeros_ip_address.this
}

import {
  id = "${local.vlan_name}-ip-pool"
  to = module.vlan["management"].module.ip_config.routeros_ip_pool.this
}

import {
  id = "${local.vlan_name}-dhcp-server"
  to = module.vlan["management"].module.ip_config.routeros_ip_dhcp_server.this
}

import {
  id = "gateway=${local.router_ip}"
  to = module.vlan["management"].module.ip_config.routeros_ip_dhcp_server_network.this
}

import {
  id = "pvid=${local.vlan_id}"
  to = module.vlan["management"].routeros_interface_bridge_port.this["ether5"]
}