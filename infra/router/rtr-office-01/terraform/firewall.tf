resource "routeros_ip_firewall_nat" "masquerade" {
  chain         = "srcnat"
  out_interface = routeros_interface_wireless.uplink.name
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
  log              = var.system.firewall_log_enabled
  log_prefix       = "DROP-INPUT-INVALID: "
  place_before     = routeros_ip_firewall_filter.input_icmp.id
}

resource "routeros_ip_firewall_filter" "input_icmp" {
  chain        = "input"
  action       = "accept"
  protocol     = "icmp"
  limit        = "50/5s,5:packet"
  place_before = routeros_ip_firewall_filter.input_lan.id
}

resource "routeros_ip_firewall_filter" "input_lan" {
  chain        = "input"
  action       = "accept"
  in_interface = routeros_interface_bridge.this.name
  place_before = routeros_ip_firewall_filter.input_drop_all.id
}

resource "routeros_ip_firewall_filter" "input_drop_all" {
  chain        = "input"
  action       = "drop"
  log          = var.system.firewall_log_enabled
  log_prefix   = "DROP-INPUT: "
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
  log              = var.system.firewall_log_enabled
  log_prefix       = "DROP-FWD-INVALID: "
  place_before     = routeros_ip_firewall_filter.forward_lan_to_wan.id
}

resource "routeros_ip_firewall_filter" "forward_lan_to_wan" {
  chain            = "forward"
  action           = "accept"
  connection_state = "new"
  in_interface     = routeros_interface_bridge.this.name
  out_interface    = routeros_interface_wireless.uplink.name
  place_before     = routeros_ip_firewall_filter.forward_drop_all.id
}

resource "routeros_ip_firewall_filter" "forward_drop_all" {
  chain      = "forward"
  action     = "drop"
  log        = var.system.firewall_log_enabled
  log_prefix = "DROP-FWD: "
}
