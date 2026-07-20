resource "routeros_system_identity" "this" {
  name = "rtr-travel-01"
}

resource "routeros_system_clock" "this" {
  time_zone_autodetect = true
}

resource "routeros_system_ntp_client" "this" {
  enabled = true
  servers = ["time.cloudflare.com"]
}

resource "routeros_tool_bandwidth_server" "this" {
  enabled = false
}

resource "routeros_ipv6_settings" "this" {
  disable_ipv6 = true
}

resource "routeros_system_user" "admin" {
  name     = "admin"
  group    = "full"
  password = var.routeros.password
  disabled = true
}