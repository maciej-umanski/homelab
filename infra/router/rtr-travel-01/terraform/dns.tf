resource "routeros_ip_dns" "this" {
  allow_remote_requests = true
  servers               = [var.wireguard.gateway, "1.1.1.1"]
}
