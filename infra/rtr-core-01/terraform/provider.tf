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
  backend "local" {
    path = "./tfstate/terraform.tfstate"
  }
}

provider "routeros" {
  hosturl  = var.routeros.url
  username = var.routeros.username
  password = var.routeros.password
  insecure = var.routeros.insecure
}
