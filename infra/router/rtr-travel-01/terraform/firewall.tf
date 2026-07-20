resource "routeros_ip_firewall_nat" "masquerade_wg" {
  chain         = "srcnat"
  out_interface = routeros_interface_wireguard.this.name
  action        = "masquerade"
}

resource "routeros_ip_firewall_nat" "masquerade_wan" {
  chain              = "srcnat"
  out_interface_list = module.wan_interface_list.name
  action             = "masquerade"
}

resource "routeros_ip_firewall_filter" "input_est_rel" {
  chain            = "input"
  action           = "accept"
  connection_state = "established,related,untracked"
}

resource "routeros_ip_firewall_filter" "input_invalid" {
  chain            = "input"
  action           = "drop"
  connection_state = "invalid"
  log              = var.firewall_log_enabled
  log_prefix       = "DROP-INPUT-INVALID: "
  place_before     = routeros_ip_firewall_filter.input_est_rel.id
}

resource "routeros_ip_firewall_filter" "input_lan" {
  chain             = "input"
  action            = "accept"
  in_interface_list = module.lan_interface_list.name
}

resource "routeros_ip_firewall_filter" "input_drop_wan" {
  chain             = "input"
  action            = "drop"
  in_interface_list = module.wan_interface_list.name
  log               = var.firewall_log_enabled
  log_prefix        = "DROP-INPUT-WAN: "
}

resource "routeros_ip_firewall_filter" "forward_est_rel" {
  chain            = "forward"
  action           = "accept"
  connection_state = "established,related,untracked"
}

resource "routeros_ip_firewall_filter" "forward_invalid" {
  chain            = "forward"
  action           = "drop"
  connection_state = "invalid"
  log              = var.firewall_log_enabled
  log_prefix       = "DROP-FWD-INVALID: "
  place_before     = routeros_ip_firewall_filter.forward_est_rel.id
}

resource "routeros_ip_firewall_filter" "forward_drop_wan_new" {
  chain                = "forward"
  action               = "drop"
  in_interface_list    = module.wan_interface_list.name
  connection_state     = "new"
  connection_nat_state = "!dstnat"
  log                  = var.firewall_log_enabled
  log_prefix           = "DROP-FWD-WAN: "
  place_before         = routeros_ip_firewall_filter.forward_invalid.id
}
