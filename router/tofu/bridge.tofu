resource "routeros_interface_bridge" "this" {
  name           = "bridge"
  vlan_filtering = true
}