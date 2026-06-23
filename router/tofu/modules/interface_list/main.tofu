resource "routeros_interface_list" "this" {
  name = var.name
}

resource "routeros_interface_list_member" "this" {
  for_each = toset(var.members)

  list      = routeros_interface_list.this.name
  interface = each.key
}