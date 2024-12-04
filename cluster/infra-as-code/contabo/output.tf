output "controlplanes" {
  value = [for node in data.contabo_instance.controlplanes : {
    id           = node.id
    image_id     = node.image_id
    display_name = node.display_name
    ip_v4        = node.ip_config[0].v4[0].ip
    ip_v6        = node.ip_config[0].v6[0].ip
    status       = node.status
    product_id   = node.product_id
  }]
}

output "workers" {
  value = [for node in data.contabo_instance.workers : {
    id           = node.id
    image_id     = node.image_id
    display_name = node.display_name
    ip_v4        = node.ip_config[0].v4[0].ip
    ip_v6        = node.ip_config[0].v6[0].ip
    status       = node.status
    product_id   = node.product_id
  }]
}
