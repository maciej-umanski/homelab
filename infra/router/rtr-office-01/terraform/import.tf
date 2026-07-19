import {
  id = local.bridge
  to = routeros_interface_bridge.this
}

import {
  id = "interface=ether1"
  to = routeros_interface_bridge_port.lan["ether1"]
}

import {
  id = "interface=ether2"
  to = routeros_interface_bridge_port.lan["ether2"]
}

import {
  id = "interface=ether3"
  to = routeros_interface_bridge_port.lan["ether3"]
}

import {
  id = "interface=${local.bridge}"
  to = module.ip_config.routeros_ip_address.this
}

import {
  id = "lan-ip-pool"
  to = module.ip_config.routeros_ip_pool.this
}

import {
  id = "lan-dhcp-server"
  to = module.ip_config.routeros_ip_dhcp_server.this
}

import {
  id = "gateway=${local.router_ip}"
  to = module.ip_config.routeros_ip_dhcp_server_network.this
}

import {
  id = "name=wlan1"
  to = routeros_interface_wireless.uplink
}
