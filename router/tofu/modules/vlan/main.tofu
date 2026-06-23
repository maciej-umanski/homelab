locals {
  vlan_name             = "${var.name_prefix}${var.vlan_id}"

  router_address        = "${var.first_three_ip_octets}.1"
  router_address_cidr   = "${local.router_address}/${var.network_size}"
  network_address       = "${var.first_three_ip_octets}.0"
  network_address_cidr  = "${local.network_address}/${var.network_size}"
  ip_range_start        = "${var.first_three_ip_octets}.${var.first_usable_ip}"
  ip_range_end          = "${var.first_three_ip_octets}.${var.last_usable_ip}"
  ip_range              = ["${local.ip_range_start}-${local.ip_range_end}"]
}

resource "routeros_interface_vlan" "this" {
  interface = var.bridge
  name      = local.vlan_name
  vlan_id   = var.vlan_id
}

resource "routeros_interface_bridge_vlan" "this" {
  bridge   = var.bridge
  vlan_ids = [routeros_interface_vlan.this.vlan_id]
  tagged   = concat(var.tagged_ports, [var.bridge])
  untagged = var.untagged_ports
}

resource "routeros_ip_address" "this" {
  address   = local.router_address_cidr
  interface = routeros_interface_vlan.this.name
  network   = local.network_address
}

resource "routeros_ip_pool" "this" {
  name   = "${local.vlan_name}-ip-pool"
  ranges = local.ip_range
}

resource "routeros_ip_dhcp_server" "this" {
  name                      = "${local.vlan_name}-dhcp-server"
  interface                 = routeros_interface_vlan.this.name
  address_pool              = routeros_ip_pool.this.name
  dynamic_lease_identifiers = "client-mac,client-id"
  lease_time                = var.dhcp_lease_time
  add_arp                   = true
}

resource "routeros_ip_dhcp_server_network" "this" {
  address    = local.network_address_cidr
  gateway    = local.router_address
  dns_server = [local.router_address]
}

resource "routeros_interface_bridge_port" "this" {
  for_each = toset(var.untagged_ports)

  bridge      = var.bridge
  interface   = each.key
  pvid        = routeros_interface_vlan.this.vlan_id
  frame_types = "admit-only-untagged-and-priority-tagged"
}