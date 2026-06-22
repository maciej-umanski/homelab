resource "routeros_interface_ethernet" "ether1" {
  factory_name = local.hardware_interface.ether1
  name         = "ether1"
}

resource "routeros_interface_ethernet" "ether2" {
  factory_name = local.hardware_interface.ether2
  name         = "ether2"
}

resource "routeros_interface_ethernet" "ether3" {
  factory_name = local.hardware_interface.ether3
  name         = "ether3"
}

resource "routeros_interface_ethernet" "ether4" {
  factory_name = local.hardware_interface.ether4
  name         = "ether4"
}

resource "routeros_interface_ethernet" "ether5" {
  factory_name = local.hardware_interface.ether5
  name         = "ether5"
}

resource "routeros_wifi_configuration" "this" {
  name      = "master-wifi-configuration"
  ssid      = "SomeSSID"
  country   = "Poland"
  hide_ssid = true
}

resource "routeros_wifi" "wifi_5_ghz" {
  name     = local.hardware_interface.wifi_5_ghz
  disabled = false

  configuration = {
    config = routeros_wifi_configuration.this.name
  }
}

resource "routeros_wifi" "wifi_2_4_ghz" {
  name     = local.hardware_interface.wifi_2_4_ghz
  disabled = false

  configuration = {
    config = routeros_wifi_configuration.this.name
  }
}