resource "routeros_interface_vlan" "pppoe" {
  name      = "pppoe-vlan"
  vlan_id   = var.pppoe.vlan_id
  interface = var.pppoe.interface
}

resource "routeros_interface_pppoe_client" "this" {
  name              = "pppoe-client"
  interface         = routeros_interface_vlan.pppoe.name
  user              = var.pppoe.username
  password          = var.pppoe.password
  add_default_route = true
  use_peer_dns      = false
  disabled          = false
}

module "wan_interface_list" {
  source = "../../_common/terraform/routeros/interface_list"

  name    = "wan"
  members = [routeros_interface_pppoe_client.this.name]
}
