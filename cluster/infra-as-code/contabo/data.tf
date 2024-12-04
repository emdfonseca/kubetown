data "contabo_image" "image" {
  id = var.image_id
}

data "contabo_instance" "controlplanes" {
  for_each = toset(var.controlplanes)
  id       = each.value
}

data "contabo_instance" "workers" {
  for_each = toset(var.workers)
  id       = each.value
}

