resource "routeros_interface_ethernet" "ether1" {
  factory_name = local.hardware_interface.ether1
  name         = "ether1"
  comment      = "Wan port, connected to ISP ONT"
}

resource "routeros_interface_ethernet" "ether2" {
  factory_name = local.hardware_interface.ether2
  name         = "ether2"
  comment      = "Trunk port to Proxmox VE host for virtual machine traffic"
}

resource "routeros_interface_ethernet" "ether3" {
  factory_name = local.hardware_interface.ether3
  name         = "ether3"
  comment      = "Trunk port to RB260GS MikroTik switch for wired LAN traffic"
}

resource "routeros_interface_ethernet" "ether4" {
  factory_name = local.hardware_interface.ether4
  name         = "ether4"
  comment      = "Miscellaneous port, used for connecting various devices such as network printer, NAS, etc. as needed"
}

resource "routeros_interface_ethernet" "ether5" {
  factory_name = local.hardware_interface.ether5
  name         = "ether5"
  comment      = "Management port, connected to dedicated management network for administration"
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