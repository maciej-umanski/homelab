resource "routeros_interface_vlan" "pppoe" {
  name      = "pppoe-vlan"
  vlan_id   = var.pppoe_vlan_id
  interface = routeros_interface_ethernet.wan.name
}

resource "routeros_interface_pppoe_client" "this" {
  name              = "pppoe-client"
  interface         = routeros_interface_vlan.pppoe.name
  user              = var.pppoe_username
  password          = var.pppoe_password
  add_default_route = true
  use_peer_dns      = false
  disabled          = false
}

module "wan_interface_list" {
  source = "./modules/interface_list"

  name    = "wan"
  members = [routeros_interface_pppoe_client.this.name]
}