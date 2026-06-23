module "vlan_interface_list" {
  source = "./modules/interface_list"

  name    = "lan"
  members = [module.vlan_legacy.name]
}