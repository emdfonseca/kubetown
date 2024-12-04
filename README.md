# Setting up the kubernetes cluster

## 1. Install Talos Linux on the contabo nodes

1. Define the nodes that will be part of the cluster by editing `cluster/contabo/terraform.tfvars`.

1. Execute the terraform code to format all nodes and install Talos Linux on them.

```bash
$ cd cluster/contabo
$ terraform apply
```

## 2. Bootstrap Talos Linux

1. Execute the terraform code to boostrap all nodes and store the kubectl and talosctl configuration files in your home directory.

```bash
$ cd cluster/talos
$ terraform apply
```

## 3. Set up fluxcd
