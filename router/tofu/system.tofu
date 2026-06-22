resource "routeros_system_identity" "this" {
  name = "router"
}

resource "routeros_system_clock" "this" {
  time_zone_name       = "Europe/Warsaw"
  time_zone_autodetect = false
}

resource "routeros_system_ntp_client" "this" {
  enabled = true
  servers = ["time.cloudflare.com"]
}

resource "routeros_ip_cloud" "this" {
  ddns_enabled = true
}

resource "routeros_tool_bandwidth_server" "this" {
  enabled = false
}

resource "routeros_ip_neighbor_discovery_settings" "this" {
  discover_interface_list = routeros_interface_list.mgmt.name
}

resource "routeros_tool_mac_server" "this" {
  allowed_interface_list = routeros_interface_list.mgmt.name
}

resource "routeros_tool_mac_server_winbox" "this" {
  allowed_interface_list = routeros_interface_list.mgmt.name
}

resource "routeros_ip_ssh_server" "ssh" {
  strong_crypto = true
}

resource "routeros_ipv6_settings" "this" {
  disable_ipv6 = true
}

resource "routeros_disk_settings" "this" {
  auto_media_interface = routeros_interface_bridge.this.name
  auto_media_sharing   = false
  auto_smb_sharing     = false
}