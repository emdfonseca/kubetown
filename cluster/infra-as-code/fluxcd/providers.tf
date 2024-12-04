terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
    flux = {
      source = "fluxcd/flux"
    }
  }
}

locals {
  kube_config_path = pathexpand("~/.kube/config")
}

provider "flux" {
  kubernetes = {
    config_path = local.kube_config_path
  }
  git = {
    url = "https://github.com/${var.github_org}/${var.github_repository}.git"
    http = {
      username = "git" # This can be any string when using a personal access token
      password = var.github_token
    }
  }
}

provider "github" {
  owner = var.github_org
  token = var.github_token
}
