terraform {
  required_version = ">= 0.13"

  required_providers {
    vault = {
      source = "hashicorp/vault"
    }
    keycloak = {
      source  = "mrparkers/keycloak"
      version = ">= 2.0.0"
    }
  }
}

locals {
  // values from docker-compose.yml
  vault_root_token = "${var.vault_rt}"
  keycloak_user = "${var.keycloak_username}"
  keycloak_password = "${var.keycloak_passwd}"
}

provider "vault" {
  // see docker-compose.yml
  address = "${var.vault_server}"
  token   = local.vault_root_token
}

provider "keycloak" {
  client_id = "admin-cli"
  username  = local.keycloak_user
  password  = local.keycloak_password
  // see docker-compose.yml
  url       = "${var.keycloak_server}"
}
