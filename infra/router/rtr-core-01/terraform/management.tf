locals {
  vlan_id              = 99
  vlan_name            = "vlan${local.vlan_id}-management"
  router_ip            = "10.10.${local.vlan_id}.1"
  management_interface = "ether5"
}

module "management_interface_list" {
  source = "../../../_common/terraform/routeros/interface_list"

  name = "management"
  members = [
    module.vlan["management"].name,
    module.vlan["trusted"].name,
    local.management_interface
  ]
}

resource "routeros_ip_neighbor_discovery_settings" "this" {
  discover_interface_list = module.management_interface_list.name
}

resource "routeros_tool_mac_server" "this" {
  allowed_interface_list = module.management_interface_list.name
}

resource "routeros_tool_mac_server_winbox" "this" {
  allowed_interface_list = module.management_interface_list.name
}
