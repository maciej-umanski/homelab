resource "routeros_interface_wireless_security_profiles" "uplink" {
  name                 = "uplink-profile"
  mode                 = "dynamic-keys"
  authentication_types = ["wpa2-psk"]
  wpa2_pre_shared_key  = var.uplink.passphrase
}

resource "routeros_interface_wireless" "uplink" {
  name             = "wlan1"
  mode             = "station"
  ssid             = var.uplink.ssid
  security_profile = routeros_interface_wireless_security_profiles.uplink.name
  disabled         = false
}

resource "routeros_ip_dhcp_client" "uplink" {
  interface         = routeros_interface_wireless.uplink.name
  add_default_route = "yes"
  use_peer_dns      = true
}

module "wan_interface_list" {
  source = "../../../_common/terraform/routeros/interface_list"

  name    = "wan"
  members = [routeros_interface_wireless.uplink.name]
}