locals {
  router_address       = "${var.first_three_octets}.1"
  router_address_cidr  = "${local.router_address}/${var.network_size}"
  network_address      = "${var.first_three_octets}.0"
  network_address_cidr = "${local.network_address}/${var.network_size}"
  ip_range_start       = "${var.first_three_octets}.${var.first_usable_ip}"
  ip_range_end         = "${var.first_three_octets}.${var.last_usable_ip}"
  ip_range             = ["${local.ip_range_start}-${local.ip_range_end}"]
}

resource "routeros_ip_address" "this" {
  address   = local.router_address_cidr
  interface = var.interface
  network   = local.network_address
}

resource "routeros_ip_pool" "this" {
  name   = "${var.name_prefix}-ip-pool"
  ranges = local.ip_range
}

resource "routeros_ip_dhcp_server" "this" {
  name                      = "${var.name_prefix}-dhcp-server"
  interface                 = var.interface
  address_pool              = routeros_ip_pool.this.name
  lease_time                = var.dhcp_lease_time
  dynamic_lease_identifiers = "client-mac,client-id"
  disabled                  = false
  add_arp                   = true
}

resource "routeros_ip_dhcp_server_network" "this" {
  address    = local.network_address_cidr
  gateway    = local.router_address
  dns_server = [local.router_address]
}

resource "routeros_ip_dhcp_server_lease" "static" {
  for_each = var.static_leases

  address     = "${var.first_three_octets}.${each.value.ip}"
  mac_address = each.value.mac
  server      = routeros_ip_dhcp_server.this.name
  comment     = each.key
}

resource "routeros_ip_dns_record" "host" {
  for_each = {
    for item in flatten([
      for lease_key, lease in var.static_leases : [
        for hostname in lease.hostnames : {
          lease_key = lease_key
          hostname  = hostname
          ip        = lease.ip
        }
      ]
    ]) : item.hostname => item
  }

  name    = each.value.hostname
  address = "${var.first_three_octets}.${each.value.ip}"
  type    = "A"
}

resource "routeros_ip_dns_record" "host_wildcard" {
  for_each = {
    for item in flatten([
      for lease_key, lease in var.static_leases : [
        for hostname in lease.hostnames : {
          lease_key = lease_key
          hostname  = hostname
          ip        = lease.ip
        }
      ]
      if lease.wildcard
    ]) : "${item.hostname}-wildcard" => item
  }

  regexp  = ".+\\.${each.value.hostname}"
  address = "${var.first_three_octets}.${each.value.ip}"
  type    = "A"
}
