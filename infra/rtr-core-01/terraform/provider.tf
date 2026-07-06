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
  hosturl  = var.routeros_url
  username = var.routeros_username
  password = var.routeros_password
  insecure = var.routeros_insecure
}
