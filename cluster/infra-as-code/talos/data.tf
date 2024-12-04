data "talos_client_configuration" "this" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = [for k, v in data.terraform_remote_state.nodes.outputs.controlplanes : v.ip_v4]
  nodes = concat(
    [for k, v in data.terraform_remote_state.nodes.outputs.controlplanes : v.ip_v4],
    [for k, v in data.terraform_remote_state.nodes.outputs.workers : v.ip_v4]
  )
}

data "terraform_remote_state" "nodes" {
  backend = "local"
  config = {
    path = "../contabo/terraform.tfstate"
  }
}

data "talos_machine_configuration" "controlplanes" {
  cluster_name     = var.cluster_name
  machine_type     = "controlplane"
  cluster_endpoint = var.cluster_endpoint
  machine_secrets  = talos_machine_secrets.this.machine_secrets
}

data "talos_machine_configuration" "workers" {
  cluster_name     = var.cluster_name
  machine_type     = "worker"
  cluster_endpoint = var.cluster_endpoint
  machine_secrets  = talos_machine_secrets.this.machine_secrets
}
