locals {
  vlan_name          = "${var.name_prefix}${var.vlan_id}-${var.name_suffix}"
  first_three_octets = "${var.first_two_octets}.${var.vlan_id}"
}

resource "routeros_interface_vlan" "this" {
  interface = var.bridge
  name      = local.vlan_name
  vlan_id   = var.vlan_id
}

module "ip_config" {
  source = "../ip_config"

  name_prefix        = local.vlan_name
  first_three_octets = local.first_three_octets
  interface          = routeros_interface_vlan.this.name
  static_leases      = var.static_leases
}

resource "routeros_interface_bridge_vlan" "this" {
  bridge   = var.bridge
  vlan_ids = [routeros_interface_vlan.this.vlan_id]
  tagged   = concat(var.tagged_ports, [var.bridge])
  untagged = var.untagged_ports
}

resource "routeros_interface_bridge_port" "this" {
  for_each = toset(var.untagged_ports)

  bridge      = var.bridge
  interface   = each.key
  pvid        = routeros_interface_vlan.this.vlan_id
  frame_types = "admit-only-untagged-and-priority-tagged"
}
