variable "name" {
  type        = string
  description = "The name of the interface list"
}

variable "members" {
  type        = list(string)
  description = "A list of interface names to include in the interface list"
}