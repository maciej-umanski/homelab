module "vlan_interface_list" {
  source = "./modules/interface_list"

  name    = "lan"
  members = [routeros_interface_vlan.legacy.name, module.vlan_main.name]
}

module "vlan_main" {
  source = "./modules/vlan"

  vlan_id        = 20
  bridge         = routeros_interface_bridge.this.name
  tagged_ports   = [routeros_interface_ethernet.lan_1.name]
  untagged_ports = [routeros_interface_ethernet.lan_2.name]
}