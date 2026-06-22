resource "routeros_interface_list" "mgmt" { name = "mgmt" }
resource "routeros_interface_list" "lan" { name = "lan" }
resource "routeros_interface_list" "wan" { name = "wan" }

resource "routeros_interface_list_member" "mgmt_members" {
  for_each = {
    "mgmt"   = module.vlan_mgmt.name
    "legacy" = module.vlan_legacy.name
  }

  list      = routeros_interface_list.mgmt.name
  interface = each.value
}

resource "routeros_interface_list_member" "lan_members" {
  for_each = {
    "legacy" = module.vlan_legacy.name
    "mgmt"   = module.vlan_mgmt.name
  }

  list      = routeros_interface_list.lan.name
  interface = each.value
}

resource "routeros_interface_list_member" "wan_members" {
  list      = routeros_interface_list.wan.name
  interface = routeros_interface_pppoe_client.this.name
}

resource "routeros_ip_firewall_nat" "this" {
  chain         = "srcnat"
  out_interface = routeros_interface_pppoe_client.this.name
  action        = "masquerade"
}

resource "routeros_ip_firewall_filter" "input_est_rel" {
  chain            = "input"
  action           = "accept"
  connection_state = "established,related,untracked"
  place_before     = routeros_ip_firewall_filter.input_mgmt.id
}

resource "routeros_ip_firewall_filter" "input_mgmt" {
  chain             = "input"
  action            = "accept"
  in_interface_list = routeros_interface_list.mgmt.name
  dst_port          = "8291,22,80,443"
  protocol          = "tcp"
  place_before      = routeros_ip_firewall_filter.input_invalid.id
}

resource "routeros_ip_firewall_filter" "input_invalid" {
  chain            = "input"
  action           = "drop"
  connection_state = "invalid"
  place_before     = routeros_ip_firewall_filter.input_icmp.id
}

resource "routeros_ip_firewall_filter" "input_icmp" {
  chain        = "input"
  action       = "accept"
  protocol     = "icmp"
  place_before = routeros_ip_firewall_filter.input_dns_udp.id
}

resource "routeros_ip_firewall_filter" "input_dns_udp" {
  chain             = "input"
  action            = "accept"
  in_interface_list = routeros_interface_list.lan.name
  dst_port          = "53"
  protocol          = "udp"
  place_before      = routeros_ip_firewall_filter.input_dns_tcp.id
}

resource "routeros_ip_firewall_filter" "input_dns_tcp" {
  chain             = "input"
  action            = "accept"
  in_interface_list = routeros_interface_list.lan.name
  dst_port          = "53"
  protocol          = "tcp"
  place_before      = routeros_ip_firewall_filter.input_drop_all.id
}

resource "routeros_ip_firewall_filter" "input_drop_all" {
  chain        = "input"
  action       = "drop"
  place_before = routeros_ip_firewall_filter.forward_fasttrack.id
}

resource "routeros_ip_firewall_filter" "forward_fasttrack" {
  chain            = "forward"
  action           = "fasttrack-connection"
  connection_state = "established,related"
  place_before     = routeros_ip_firewall_filter.forward_est_rel.id
}

resource "routeros_ip_firewall_filter" "forward_est_rel" {
  chain            = "forward"
  action           = "accept"
  connection_state = "established,related,untracked"
  place_before     = routeros_ip_firewall_filter.forward_invalid.id
}

resource "routeros_ip_firewall_filter" "forward_invalid" {
  chain            = "forward"
  action           = "drop"
  connection_state = "invalid"
  place_before     = routeros_ip_firewall_filter.forward_lan_to_wan.id
}

resource "routeros_ip_firewall_filter" "forward_lan_to_wan" {
  chain              = "forward"
  action             = "accept"
  connection_state   = "new"
  in_interface_list  = routeros_interface_list.lan.name
  out_interface_list = routeros_interface_list.wan.name
  place_before       = routeros_ip_firewall_filter.forward_port_forwarding.id
}

resource "routeros_ip_firewall_filter" "forward_port_forwarding" {
  chain                = "forward"
  action               = "accept"
  connection_nat_state = "dstnat"
  place_before         = routeros_ip_firewall_filter.forward_drop_all.id
}

resource "routeros_ip_firewall_filter" "forward_drop_all" {
  chain  = "forward"
  action = "drop"
}