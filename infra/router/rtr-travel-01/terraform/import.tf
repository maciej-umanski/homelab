import {
  id = local.bridge
  to = routeros_interface_bridge.this
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
  id = "gateway=${local.first_three_octets}.1"
  to = module.ip_config.routeros_ip_dhcp_server_network.this
}

import {
  id = "admin"
  to = routeros_system_user.admin
}

import {
  id = "*1"
  to = routeros_system_certificate.root_ca
}

import {
  id = "*2"
  to = routeros_system_certificate.webfig
}
