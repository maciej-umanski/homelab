locals {
  ether1 = "ether1"
  ether3 = "ether3"
  ether4 = "ether4"
}

import {
  id = local.ether1
  to = routeros_interface_ethernet.lan
}

import {
  id = local.ether3
  to = routeros_interface_ethernet.srv
}

import {
  id = local.ether4
  to = routeros_interface_ethernet.nas
}

resource "routeros_interface_ethernet" "lan" {
  factory_name = local.ether1
  name         = "ether1"
}

resource "routeros_interface_ethernet" "srv" {
  factory_name = local.ether3
  name         = "ether3"
}

resource "routeros_interface_ethernet" "nas" {
  factory_name = local.ether4
  name         = "ether4"
}
