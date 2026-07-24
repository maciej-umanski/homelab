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

resource "routeros_ip_cloud" "this" {
  ddns_enabled = "yes"
}

resource "routeros_tool_bandwidth_server" "this" {
  enabled = false
}

resource "routeros_ipv6_settings" "this" {
  disable_ipv6 = true
}

resource "routeros_disk_settings" "this" {
  auto_media_interface = routeros_interface_bridge.this.name
  auto_media_sharing   = false
  auto_smb_sharing     = false
}

resource "routeros_ip_ssh_server" "this" {
  strong_crypto = true
  host_key_size = 2048
}

resource "routeros_system_user" "admin" {
  name     = "admin"
  group    = "full"
  disabled = true
}

resource "routeros_system_routerboard_settings" "this" {
  auto_upgrade = true
}

resource "routeros_ip_settings" "this" {
  rp_filter           = "strict"
  tcp_syncookies      = true
  allow_fast_path     = true
  ip_forward          = true
  secure_redirects    = false
  send_redirects      = false
  accept_redirects    = false
  accept_source_route = false
  icmp_rate_limit     = 10
}
