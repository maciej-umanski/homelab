resource "routeros_interface_bridge_port" "switch" {
  bridge      = routeros_interface_bridge.this.name
  interface   = routeros_interface_ethernet.switch.name
  frame_types = "admit-only-vlan-tagged"
}

resource "routeros_ip_firewall_addr_list" "switch" {
  list    = "switch"
  address = local.switch_ip
}