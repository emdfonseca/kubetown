variable "reinstall" {
  type    = bool
  default = false
}

variable "image_id" {
  type = string
}

variable "controlplanes" {
  type = list(string)
}

variable "workers" {
  type = list(string)
}
