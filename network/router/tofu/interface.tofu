locals {
  ether1 = "ether1"
  ether2 = "ether2"
  ether3 = "ether3"
  ether4 = "ether4"
  ether5 = "ether5"
}

import {
  id = local.ether1
  to = routeros_interface_ethernet.switch
}

import {
  id = local.ether2
  to = routeros_interface_ethernet.wan
}

import {
  id = local.ether3
  to = routeros_interface_ethernet.lan_1
}

import {
  id = local.ether4
  to = routeros_interface_ethernet.lan_2
}

import {
  id = local.ether5
  to = routeros_interface_ethernet.mgmt
}

resource "routeros_interface_ethernet" "switch" {
  factory_name = local.ether1
  name         = "ether1"
}

resource "routeros_interface_ethernet" "wan" {
  factory_name = local.ether2
  name         = "ether2"
}

resource "routeros_interface_ethernet" "lan_1" {
  factory_name = local.ether3
  name         = "ether3"
}

resource "routeros_interface_ethernet" "lan_2" {
  factory_name = local.ether4
  name         = "ether4"
}

resource "routeros_interface_ethernet" "mgmt" {
  factory_name = local.ether5
  name         = "ether5"
}