import {
  id = "bridge"
  to = routeros_interface_bridge.this
}

resource "routeros_interface_bridge" "this" {
  name           = "bridge"
  vlan_filtering = true
}