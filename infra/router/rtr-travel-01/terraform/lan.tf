locals {
  bridge              = "bridge"
  ethernet_interfaces = ["ether2", "ether3"]
  first_three_octets  = "10.30.20"
}

resource "routeros_interface_bridge" "this" {
  name = local.bridge
}

resource "routeros_interface_bridge_port" "lan" {
  for_each = toset(local.ethernet_interfaces)

  bridge    = routeros_interface_bridge.this.name
  interface = each.key
}

module "ip_config" {
  source = "../../../_common/terraform/routeros/ip_config"

  first_three_octets = local.first_three_octets
  interface          = routeros_interface_bridge.this.name
}

module "lan_interface_list" {
  source = "../../../_common/terraform/routeros/interface_list"

  name    = "LAN"
  members = concat(local.ethernet_interfaces, [routeros_interface_wireless.downlink.name, local.bridge])
}
