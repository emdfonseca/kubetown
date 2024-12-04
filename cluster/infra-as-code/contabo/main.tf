resource "contabo_instance" "controlplanes" {
  # This will only run if var.reinstall is true
  for_each = var.reinstall ? toset(var.controlplanes) : toset([])

  existing_instance_id = each.value
  image_id             = data.contabo_image.image.id
  display_name         = format("kbt%02s", index(var.controlplanes, each.key) + 1)
}

resource "contabo_instance" "workers" {
  # This will only run if var.reinstall is true
  for_each = var.reinstall ? toset(var.workers) : toset([])

  existing_instance_id = each.value
  image_id             = data.contabo_image.image.id
  display_name         = format("kbt%02s", index(var.workers, each.key) + 1)
}
