data "terraform_remote_state" "talos" {
  backend = "local"
  config = {
    path = "../talos/terraform.tfstate"
  }
}
