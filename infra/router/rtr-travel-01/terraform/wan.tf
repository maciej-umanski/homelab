locals {
  ether_interface = "ether1"
}

resource "routeros_ip_dhcp_client" "ether_uplink" {
  interface              = local.ether_interface
  add_default_route      = "yes"
  default_route_distance = 2
  use_peer_dns           = false
}

resource "routeros_ip_dhcp_client" "wifi_uplink" {
  interface              = routeros_interface_wireless.uplink.name
  add_default_route      = "yes"
  default_route_distance = 1
  use_peer_dns           = false
}

module "wan_interface_list" {
  source = "../../../_common/terraform/routeros/interface_list"

  name = "WAN"
  members = [
    local.ether_interface,
    routeros_interface_wireless.uplink.name,
  ]
}
