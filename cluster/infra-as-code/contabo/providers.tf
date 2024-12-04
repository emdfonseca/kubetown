terraform {
  required_version = ">= 1.3.0"
  required_providers {
    contabo = {
      source  = "contabo/contabo"
      version = "=0.1.26"
    }
  }
}

provider "contabo" {
  # set the following environment variables:
  # CNTB_OAUTH2_CLIENT_ID
  # CNTB_OAUTH2_CLIENT_SECRET
  # CNTB_OAUTH2_USER
  # CNTB_OAUTH2_PASS
}
