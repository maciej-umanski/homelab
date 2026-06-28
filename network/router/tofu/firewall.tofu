resource "routeros_ip_firewall_nat" "this" {
  chain         = "srcnat"
  out_interface = routeros_interface_pppoe_client.this.name
  action        = "masquerade"
}

# =============================================================
# INPUT CHAIN (Traffic destined FOR the router itself)
# =============================================================

resource "routeros_ip_firewall_filter" "input_est_rel" {
  chain            = "input"
  action           = "accept"
  connection_state = "established,related,untracked"
  place_before     = routeros_ip_firewall_filter.input_invalid.id
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
  limit        = "50/5s,5:packet"
  place_before = routeros_ip_firewall_filter.input_router_mgmt.id
}

resource "routeros_ip_firewall_filter" "input_router_mgmt" {
  chain             = "input"
  action            = "accept"
  in_interface_list = module.mgmt_interface_list.name
  dst_port          = "8291,22,80,443"
  protocol          = "tcp"
  place_before      = routeros_ip_firewall_filter.input_dns_udp.id
}

resource "routeros_ip_firewall_filter" "input_dns_udp" {
  chain             = "input"
  action            = "accept"
  in_interface_list = module.vlan_interface_list.name
  dst_port          = "53"
  protocol          = "udp"
  place_before      = routeros_ip_firewall_filter.input_dns_tcp.id
}

resource "routeros_ip_firewall_filter" "input_dns_tcp" {
  chain             = "input"
  action            = "accept"
  in_interface_list = module.vlan_interface_list.name
  dst_port          = "53"
  protocol          = "tcp"
  place_before      = routeros_ip_firewall_filter.input_mdns.id
}

resource "routeros_ip_firewall_filter" "input_mdns" {
  chain        = "input"
  action       = "accept"
  protocol     = "udp"
  dst_port     = "5353"
  dst_address  = "224.0.0.251"
  place_before = routeros_ip_firewall_filter.input_wireguard_handshake.id
}

resource "routeros_ip_firewall_filter" "input_wireguard_handshake" {
  chain             = "input"
  action            = "accept"
  protocol          = "udp"
  dst_port          = routeros_interface_wireguard.this.listen_port
  in_interface_list = module.wan_interface_list.name
  place_before      = routeros_ip_firewall_filter.input_wireguard_router.id
}

resource "routeros_ip_firewall_filter" "input_wireguard_router" {
  chain        = "input"
  action       = "accept"
  in_interface = routeros_interface_wireguard.this.name
  place_before = routeros_ip_firewall_filter.input_drop_all.id
}

resource "routeros_ip_firewall_filter" "input_drop_all" {
  chain        = "input"
  action       = "drop"
  place_before = routeros_ip_firewall_filter.forward_fasttrack.id
}

# =============================================================
# FORWARD CHAIN (Traffic passing THROUGH the router)
# =============================================================

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
  place_before     = routeros_ip_firewall_filter.forward_switch_mgmt.id
}

# Moved down into the FORWARD block to maintain linked-list structure
resource "routeros_ip_firewall_filter" "forward_switch_mgmt" {
  chain             = "forward"
  action            = "accept"
  connection_state  = "new"
  in_interface_list = module.mgmt_interface_list.name
  dst_address_list  = routeros_ip_firewall_addr_list.switch.list
  dst_port          = "80"
  protocol          = "tcp"
  place_before      = routeros_ip_firewall_filter.forward_port_forwarding.id
}

resource "routeros_ip_firewall_filter" "forward_port_forwarding" {
  chain                = "forward"
  action               = "accept"
  connection_nat_state = "dstnat"
  place_before         = routeros_ip_firewall_filter.forward_trusted_to_servers.id
}

resource "routeros_ip_firewall_filter" "forward_trusted_to_servers" {
  chain            = "forward"
  action           = "accept"
  connection_state = "new"
  in_interface     = module.vlan_trusted.name
  out_interface    = module.vlan_servers.name
  place_before     = routeros_ip_firewall_filter.forward_servers_to_iot.id
}

resource "routeros_ip_firewall_filter" "forward_servers_to_iot" {
  chain            = "forward"
  action           = "accept"
  connection_state = "new"
  in_interface     = module.vlan_servers.name
  out_interface    = module.vlan_iot.name
  place_before     = routeros_ip_firewall_filter.forward_wireguard_to_servers.id
}

resource "routeros_ip_firewall_filter" "forward_wireguard_to_servers" {
  chain            = "forward"
  action           = "accept"
  connection_state = "new"
  in_interface     = routeros_interface_wireguard.this.name
  out_interface    = module.vlan_servers.name
  place_before     = routeros_ip_firewall_filter.forward_wireguard_to_iot.id
}

resource "routeros_ip_firewall_filter" "forward_wireguard_to_iot" {
  chain            = "forward"
  action           = "accept"
  connection_state = "new"
  in_interface     = routeros_interface_wireguard.this.name
  out_interface    = module.vlan_iot.name
  place_before     = routeros_ip_firewall_filter.forward_wireguard_to_wan.id
}

resource "routeros_ip_firewall_filter" "forward_wireguard_to_wan" {
  chain              = "forward"
  action             = "accept"
  connection_state   = "new"
  in_interface       = routeros_interface_wireguard.this.name
  out_interface_list = module.wan_interface_list.name
  place_before       = routeros_ip_firewall_filter.forward_lan_to_wan.id
}

resource "routeros_ip_firewall_filter" "forward_lan_to_wan" {
  chain              = "forward"
  action             = "accept"
  connection_state   = "new"
  in_interface_list  = module.vlan_interface_list.name
  out_interface_list = module.wan_interface_list.name
  place_before       = routeros_ip_firewall_filter.forward_drop_all.id
}

resource "routeros_ip_firewall_filter" "forward_drop_all" {
  chain  = "forward"
  action = "drop"
}