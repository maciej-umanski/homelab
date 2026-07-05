terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.99.1"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "0.4.0"
    }
  }
  backend "http" {
    address        = "http://10.10.30.247:3000/api/packages/maciej/terraform/state/rtr-core-01"
    lock_address   = "http://10.10.30.247:3000/api/packages/maciej/terraform/state/rtr-core-01/lock"
    unlock_address = "http://10.10.30.247:3000/api/packages/maciej/terraform/state/rtr-core-01/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    username       = "maciej"
  }
}

provider "routeros" {
  hosturl  = var.routeros_url
  username = var.routeros_username
  password = var.routeros_password
  insecure = var.routeros_insecure
}
