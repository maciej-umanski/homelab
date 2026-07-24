locals {
  wg_subnet_prefix = "10.10.80"
  wg_subnet_mask   = 32
  wg_address       = "${local.wg_subnet_prefix}.1"
  wg_address_cidr  = "${local.wg_address}/24"
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
  for_each = var.wireguard_clients
}

resource "routeros_interface_wireguard_peer" "this" {
  for_each = var.wireguard_clients

  name       = each.key
  interface  = routeros_interface_wireguard.this.name
  public_key = wireguard_asymmetric_key.this[each.key].public_key

  allowed_address = ["${local.wg_subnet_prefix}.${each.value.ip}/${local.wg_subnet_mask}"]
}

resource "local_sensitive_file" "wireguard_config" {
  for_each = var.wireguard_clients

  filename        = "${path.module}/wireguard_config/${each.key}.conf"
  file_permission = "0600"
  content         = <<-EOT
    [Interface]
    PrivateKey = ${wireguard_asymmetric_key.this[each.key].private_key}
    Address = "${local.wg_subnet_prefix}.${each.value.ip}/${local.wg_subnet_mask}"
    DNS = ${local.wg_address}

    [Peer]
    PublicKey = ${routeros_interface_wireguard.this.public_key}
    Endpoint = ${routeros_ip_cloud.this.dns_name}:${routeros_interface_wireguard.this.listen_port}
    AllowedIPs = 0.0.0.0/0
    PersistentKeepalive = 25
  EOT
}
