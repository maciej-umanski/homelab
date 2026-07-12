resource "routeros_interface_bridge_port" "switch" {
  bridge      = routeros_interface_bridge.this.name
  interface   = var.switch_config.interface
  frame_types = "admit-only-vlan-tagged"
}

resource "routeros_ip_firewall_addr_list" "switch" {
  list    = "switch"
  address = var.switch_config.ip
}
