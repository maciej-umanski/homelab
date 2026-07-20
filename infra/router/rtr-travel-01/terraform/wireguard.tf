resource "routeros_interface_wireguard" "this" {
  name        = "wireguard"
  listen_port = 13231
  mtu         = 1420
  private_key = var.wireguard.private_key
}

resource "routeros_ip_address" "wireguard" {
  address   = var.wireguard.address
  interface = routeros_interface_wireguard.this.name
}

resource "routeros_interface_wireguard_peer" "core" {
  name                 = "rtr-core-01"
  interface            = routeros_interface_wireguard.this.name
  public_key           = var.wireguard.peer_public_key
  endpoint_address     = var.wireguard.endpoint
  endpoint_port        = 13231
  allowed_address      = ["0.0.0.0/0"]
  persistent_keepalive = "25s"
}

resource "routeros_routing_table" "vpn" {
  name = "vpn"
  fib  = true
}

resource "routeros_ip_route" "default_via_wg" {
  dst_address   = "0.0.0.0/0"
  gateway       = routeros_interface_wireguard.this.name
  routing_table = routeros_routing_table.vpn.name
}

resource "routeros_routing_rule" "lan_main" {
  dst_address = "${local.first_three_octets}.0/24"
  action      = "lookup-only-in-table"
  table       = "main"
}

resource "routeros_routing_rule" "bridge_vpn" {
  interface = routeros_interface_bridge.this.name
  action    = "lookup-only-in-table"
  table     = routeros_routing_table.vpn.name
}
