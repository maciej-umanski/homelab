module "vlan" {
  source = "../../_common/terraform/routeros/vlan"

  for_each = var.main_network.vlans

  name_suffix    = each.key
  vlan_id        = each.value.id
  tagged_ports   = each.value.tagged_ports
  untagged_ports = each.value.untagged_ports
  static_leases  = each.value.leases
  bridge         = routeros_interface_bridge.this.name
}

module "vlan_interface_list" {
  source = "../../_common/terraform/routeros/interface_list"

  name = "lan"
  members = [
    module.vlan["trusted"].name,
    module.vlan["servers"].name,
    module.vlan["iot"].name,
    module.vlan["guest"].name,
    module.vlan["gaming"].name
  ]
}
