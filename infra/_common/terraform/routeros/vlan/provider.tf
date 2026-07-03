terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.99.1"
    }
    dns = {
      source  = "hashicorp/dns"
      version = "3.5.0"
    }
  }
}