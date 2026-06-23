resource "routeros_interface_bridge_port" "switch_port" {
  bridge      = routeros_interface_bridge.this.name
  interface   = routeros_interface_ethernet.switch.name
  frame_types = "admit-only-vlan-tagged"
}

resource "routeros_ip_firewall_addr_list" "switches" {
  list    = "switches"
  address = "10.10.99.2"
}