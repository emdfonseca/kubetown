terraform {
  required_version = ">= 1.3.0"
  required_providers {
    talos = {
      source  = "siderolabs/talos"
      version = "0.7.0-alpha.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">=2.2.3"
    }
  }
}

provider "talos" {
  # Configuration options
}
