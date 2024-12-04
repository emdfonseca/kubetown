output "kubeconfig_file" {
  value     = local_sensitive_file.kubeconfig.content
  sensitive = true
}

output "talosconfig_file" {
  value     = local_sensitive_file.talosconfig.content
  sensitive = true
}

output "kubeconfig" {
  value     = talos_cluster_kubeconfig.this.kubernetes_client_configuration
  sensitive = true
}
