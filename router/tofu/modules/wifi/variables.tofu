variable "vlan_id" {
  type        = string
  description = "The ID of the VLAN interface"
}

variable "bridge" {
  type        = string
  description = "The name of the bridge to which the VLAN interface will be added"
}

variable "name_prefix" {
  type        = string
  description = "The prefix for the Wi-Fi interface name"
  default     = "wifi"
}

variable "country" {
  type        = string
  description = "The country config for WiFi"
  default     = "Poland"
}

variable "ft_enabled" {
  type        = bool
  description = "Whether to enable Fast Transition (802.11r) for the WiFi network associated with the VLAN interface"
  default     = true
}

variable "parent_interface" {
  type        = string
  description = "The parent radio interface for the WiFi network"
  default     = null
}

variable "ssid" {
  type        = string
  description = "The SSID for the WiFi network associated with the VLAN interface"
}

variable "pass" {
  type        = string
  description = "The password for the WiFi network associated with the VLAN interface"
}

variable "hide_ssid" {
  type        = bool
  description = "Whether to hide the SSID for the WiFi network associated with the VLAN interface"
  default     = false
}

variable "steering_name" {
  type        = string
  description = "The name of the WiFi steering configuration to use for the WiFi network to associate with"
  default     = ""
}