module "vlan_mgmt" {
  source = "./modules/vlan"

  vlan_id        = 99
  bridge         = routeros_interface_bridge.this.name
  untagged_ports = [routeros_interface_ethernet.ether5.name]
}