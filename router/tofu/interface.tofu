import {
  id = "ether1"
  to = routeros_interface_ethernet.switch
}

import {
  id = "ether2"
  to = routeros_interface_ethernet.wan
}

import {
  id = "ether3"
  to = routeros_interface_ethernet.lan_1
}

import {
  id = "ether4"
  to = routeros_interface_ethernet.lan_2
}

import {
  id = "ether5"
  to = routeros_interface_ethernet.mgmt
}

import {
  id = "wifi1"
  to = routeros_wifi.wifi_5_ghz
}

import {
  id = "wifi2"
  to = routeros_wifi.wifi_2_4_ghz
}

resource "routeros_interface_ethernet" "switch" {
  factory_name = "ether1"
  name         = "ether1"
}

resource "routeros_interface_ethernet" "wan" {
  factory_name = "ether2"
  name         = "ether2"
}

resource "routeros_interface_ethernet" "lan_1" {
  factory_name = "ether3"
  name         = "ether3"
}

resource "routeros_interface_ethernet" "lan_2" {
  factory_name = "ether4"
  name         = "ether4"
}

resource "routeros_interface_ethernet" "mgmt" {
  factory_name = "ether5"
  name         = "ether5"
}

resource "routeros_wifi_configuration" "this" {
  name      = "master-wifi-configuration"
  ssid      = "SomeSSID"
  country   = "Poland"
  hide_ssid = true
}

resource "routeros_wifi" "wifi_5_ghz" {
  name     = "wifi1"
  disabled = false

  configuration = {
    config = routeros_wifi_configuration.this.name
  }
}

resource "routeros_wifi" "wifi_2_4_ghz" {
  name     = "wifi2"
  disabled = false

  configuration = {
    config = routeros_wifi_configuration.this.name
  }
}