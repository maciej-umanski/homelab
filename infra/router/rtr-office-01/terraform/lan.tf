locals {
  bridge    = "bridge"
  lan_ports = ["ether2", "ether3"]
  router_ip = "10.20.30.1"
}


resource "routeros_interface_bridge" "this" {
  name = local.bridge
}

resource "routeros_interface_bridge_port" "lan" {
  for_each = toset(local.lan_ports)

  bridge    = routeros_interface_bridge.this.name
  interface = each.key
}

module "ip_config" {
  source             = "../../../_common/terraform/routeros/ip_config"

  first_three_octets = "10.20.30"
  interface          = routeros_interface_bridge.this.name
}

resource "routeros_ip_dns" "this" {
  allow_remote_requests = true
}

module "lan_interface_list" {
  source = "../../../_common/terraform/routeros/interface_list"

  name    = "lan"
  members = local.lan_ports
}
