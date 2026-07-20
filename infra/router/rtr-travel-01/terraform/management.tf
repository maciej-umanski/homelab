resource "routeros_ip_neighbor_discovery_settings" "this" {
  discover_interface_list = module.lan_interface_list.name
}

resource "routeros_tool_mac_server" "this" {
  allowed_interface_list = module.lan_interface_list.name
}

resource "routeros_tool_mac_server_winbox" "this" {
  allowed_interface_list = module.lan_interface_list.name
}

resource "routeros_tool_mac_server_ping" "this" {
  enabled = false
}
