import {
  id = local.wifi_2_4_ghz
  to = module.wifi_main.routeros_wifi.this[local.wifi_2_4_ghz]
}

import {
  id = local.wifi_5_ghz
  to = module.wifi_main.routeros_wifi.this[local.wifi_5_ghz]
}

module "wifi_main" {
  source = "./modules/wifi"

  vlan_id              = module.vlan_main.vlan_id
  bridge               = routeros_interface_bridge.this.name
  parent_interfaces    = [local.wifi_5_ghz, local.wifi_2_4_ghz]
  ssid                 = var.main_wifi_ssid
  pass                 = var.main_wifi_pass
  use_parent_interface = true
}