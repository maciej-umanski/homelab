resource "routeros_system_identity" "this" {
  name = var.system.router_name
}

resource "routeros_system_clock" "this" {
  time_zone_name       = var.system.timezone
  time_zone_autodetect = false
}

resource "routeros_system_ntp_client" "this" {
  enabled = true
  servers = [var.system.ntp_server]
}

resource "routeros_tool_bandwidth_server" "this" {
  enabled = false
}

resource "routeros_ip_ssh_server" "this" {
  strong_crypto = true
}

resource "routeros_ipv6_settings" "this" {
  disable_ipv6 = true
}
