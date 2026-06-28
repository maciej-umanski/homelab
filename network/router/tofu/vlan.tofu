module "vlan_interface_list" {
  source = "./modules/interface_list"

  name = "lan"
  members = [
    module.vlan_trusted.name,
    module.vlan_servers.name,
    module.vlan_iot.name,
    module.vlan_guest.name,
  ]
}

module "vlan_trusted" {
  source = "./modules/vlan"

  vlan_id      = 20
  name_suffix  = "trusted"
  bridge       = routeros_interface_bridge.this.name
  tagged_ports = [routeros_interface_ethernet.switch.name]
}

module "vlan_servers" {
  source = "./modules/vlan"

  vlan_id      = 30
  name_suffix  = "servers"
  bridge       = routeros_interface_bridge.this.name
  tagged_ports = [routeros_interface_ethernet.switch.name]
}

module "vlan_iot" {
  source = "./modules/vlan"

  vlan_id      = 40
  name_suffix  = "iot"
  bridge       = routeros_interface_bridge.this.name
  tagged_ports = [routeros_interface_ethernet.switch.name]
}

module "vlan_guest" {
  source = "./modules/vlan"

  vlan_id     = 50
  name_suffix = "guest"
  bridge      = routeros_interface_bridge.this.name
}