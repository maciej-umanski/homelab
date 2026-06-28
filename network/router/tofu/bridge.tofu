locals {
  bridge = "bridge"
}

import {
  id = local.bridge
  to = routeros_interface_bridge.this
}

resource "routeros_interface_bridge" "this" {
  name           = local.bridge
  vlan_filtering = true
}