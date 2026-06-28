locals {
  wg_subnet_prefix = "10.10.80"
  wg_address       = "${local.wg_subnet_prefix}.1"
  wg_address_cidr  = "${local.wg_address}/24"

  clients = {
    for idx, client in sort(tolist(var.wireguard_clients)) : client => {
      ip_address = "${local.wg_subnet_prefix}.${idx + 2}/32"
    }
  }
}

resource "routeros_interface_wireguard" "this" {
  name        = "wireguard"
  listen_port = 13231
  mtu         = 1420
}

resource "routeros_ip_address" "wg_ip" {
  address   = local.wg_address_cidr
  interface = routeros_interface_wireguard.this.name
}

resource "wireguard_asymmetric_key" "this" {
  for_each = local.clients
}

resource "routeros_interface_wireguard_peer" "this" {
  for_each = local.clients

  name       = each.key
  interface  = routeros_interface_wireguard.this.name
  public_key = wireguard_asymmetric_key.this[each.key].public_key

  allowed_address = [each.value.ip_address]
}

resource "local_sensitive_file" "wireguard_config" {
  for_each = local.clients

  filename = "${path.module}/wireguard_config/${each.key}.conf"
  content  = <<-EOT
    [Interface]
    PrivateKey = ${wireguard_asymmetric_key.this[each.key].private_key}
    Address = ${each.value.ip_address}
    DNS = ${local.wg_address}

    [Peer]
    PublicKey = ${routeros_interface_wireguard.this.public_key}
    Endpoint = ${routeros_ip_cloud.this.dns_name}:${routeros_interface_wireguard.this.listen_port}
    AllowedIPs = 0.0.0.0/0
    PersistentKeepalive = 25
  EOT
}