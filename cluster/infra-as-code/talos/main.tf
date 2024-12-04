resource "talos_machine_secrets" "this" {}

resource "talos_machine_bootstrap" "this" {
  depends_on           = [talos_machine_configuration_apply.controlplane]
  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = [for k, v in data.terraform_remote_state.nodes.outputs.controlplanes : v.ip_v4][0]
}

resource "talos_cluster_kubeconfig" "this" {
  depends_on           = [talos_machine_bootstrap.this]
  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = [for k, v in data.terraform_remote_state.nodes.outputs.controlplanes : v.ip_v4][0]
}

resource "talos_machine_configuration_apply" "controlplane" {
  for_each = { for index, node in data.terraform_remote_state.nodes.outputs.controlplanes : index => node }

  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.controlplanes.machine_configuration
  node                        = each.value.ip_v4
  config_patches = [
    templatefile("${path.module}/nodeconfig.yaml.tmpl", {
      hostname        = each.value.display_name
      enable_mayastor = false
      controlplane    = true
    }),
  ]
}

resource "talos_machine_configuration_apply" "worker" {
  for_each = { for index, node in data.terraform_remote_state.nodes.outputs.workers : index => node }

  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.workers.machine_configuration
  node                        = each.value.ip_v4
  config_patches = [
    templatefile("${path.module}/nodeconfig.yaml.tmpl", {
      hostname        = each.value.display_name,
      enable_mayastor = each.value.product_id == "V46"
      controlplane    = false
    }),
  ]
}

resource "local_sensitive_file" "kubeconfig" {
  depends_on = [talos_cluster_kubeconfig.this]
  content    = talos_cluster_kubeconfig.this.kubeconfig_raw
  filename   = pathexpand("~/.kube/config")
}

resource "local_sensitive_file" "talosconfig" {
  depends_on = [data.talos_client_configuration.this]
  content    = data.talos_client_configuration.this.talos_config
  filename   = pathexpand("~/.talos/config")
}

