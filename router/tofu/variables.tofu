variable "tfstate_location" {
  type        = string
  description = "The location where the Terraform state file will be stored"
  default     = "./tfstate"
}

variable "routeros_url" {
  type        = string
  description = "The URL of the RouterOS device"
  default     = "http://10.10.99.1"
}

variable "routeros_username" {
  type        = string
  description = "The username for the RouterOS device"
  default     = "admin"
}

variable "routeros_insecure" {
  type        = bool
  description = "Whether to skip TLS verification for the RouterOS device"
  default     = true
}

variable "routeros_password" {
  type        = string
  description = "The password for the RouterOS device"
  sensitive   = true
}

variable "pppoe_username" {
  type        = string
  description = "The username for the PPPoE connection"
  sensitive   = true
}

variable "pppoe_password" {
  type        = string
  description = "The password for the PPPoE connection"
  sensitive   = true
}

variable "pppoe_vlan_id" {
  type        = number
  description = "The VLAN ID for the PPPoE connection"
  sensitive   = true
}

variable "main_wifi_ssid" {
  type        = string
  description = "The SSID for the main WiFi network"
  sensitive   = true
}

variable "main_wifi_pass" {
  type        = string
  description = "The password for the main WiFi network"
  sensitive   = true
}