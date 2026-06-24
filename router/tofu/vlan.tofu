module "vlan_interface_list" {
  source = "./modules/interface_list"

  name = "lan"
  members = [
    routeros_interface_vlan.legacy.name,
    module.vlan_trusted.name,
    module.vlan_servers.name,
    module.vlan_iot.name,
    module.vlan_guest.name,
  ]
}

module "vlan_trusted" {
  source = "./modules/vlan"

  vlan_id      = 20
  bridge       = routeros_interface_bridge.this.name
  tagged_ports = [routeros_interface_ethernet.switch.name]
}

module "vlan_servers" {
  source = "./modules/vlan"

  vlan_id      = 30
  bridge       = routeros_interface_bridge.this.name
  tagged_ports = [routeros_interface_ethernet.switch.name]
}

module "vlan_iot" {
  source = "./modules/vlan"

  vlan_id      = 40
  bridge       = routeros_interface_bridge.this.name
  tagged_ports = [routeros_interface_ethernet.switch.name]
}

module "vlan_guest" {
  source = "./modules/vlan"

  vlan_id = 50
  bridge  = routeros_interface_bridge.this.name
}