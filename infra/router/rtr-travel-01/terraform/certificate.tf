resource "routeros_system_certificate" "root_ca" {
  name        = "local-root-cert"
  common_name = "local-cert"
  key_size    = "prime256v1"
  key_usage   = ["key-cert-sign", "crl-sign"]
  trusted     = true
  sign {}

  lifecycle { ignore_changes = [sign] }
}

resource "routeros_system_certificate" "webfig" {
  name         = "webfig"
  common_name  = "10.30.20.1"
  country      = "PL"
  locality     = "WAW"
  organization = "MACIEJ-UMANSKI"
  unit         = "HOME"
  days_valid   = 3650
  key_size     = "prime256v1"
  key_usage    = ["key-cert-sign", "crl-sign", "digital-signature", "key-agreement", "tls-server"]
  trusted      = true
  sign { ca = routeros_system_certificate.root_ca.name }

  lifecycle { ignore_changes = [sign] }
}
