#------------------------------------------------------------------------------#
# Keycloak Basics
#------------------------------------------------------------------------------#

resource "keycloak_realm" "realm" {
  realm   = "${var.realm_name}"
  enabled = true
}

resource "keycloak_user" "user_shubham" {
  realm_id   = keycloak_realm.realm.id
  username   = "shubham"
  enabled    = true

  email      = "shubham.tamboli@bfctech.io"
  first_name = "shubham"
  last_name  = "Tamboli"

  initial_password {
    value     = "shubham"
    temporary = false
  }
}

resource "keycloak_user_roles" "read_roles" {
  realm_id = keycloak_realm.realm.id
  user_id  = keycloak_user.user_shubham.id

  role_ids = [
    keycloak_role.reader_role.id
  ]
}

resource "keycloak_user" "user_admin" {
  realm_id   = keycloak_realm.realm.id
  username   = "admin"
  enabled    = true

  email      = "admin@bfctech.io"
  first_name = "admin"
  last_name  = "admin"

  initial_password {
    value     = "admin"
    temporary = false
  }
}

resource "keycloak_user_roles" "admin_roles" {
  realm_id = keycloak_realm.realm.id
  user_id  = keycloak_user.user_admin.id

  role_ids = [
    keycloak_role.management_role.id
  ]
}

#------------------------------------------------------------------------------#
# Keycloak Vault OIDC Client
#------------------------------------------------------------------------------#

resource "keycloak_openid_client" "openid_client" {
  realm_id            = keycloak_realm.realm.id
  client_id           = "vault"

  name                = "vault"
  enabled             = true
  standard_flow_enabled = true

  access_type         = "CONFIDENTIAL"
  valid_redirect_uris = [
    "${var.vault_server}/*"
  ]

  login_theme = "keycloak"
}

resource "keycloak_openid_user_client_role_protocol_mapper" "user_client_role_mapper" {
  realm_id   = keycloak_realm.realm.id
  client_id  = keycloak_openid_client.openid_client.id
  name       = "user-client-role-mapper"
  claim_name = format("resource_access.%s.roles",keycloak_openid_client.openid_client.client_id)
  multivalued = true
}

resource "keycloak_role" "management_role" {
  realm_id    = keycloak_realm.realm.id
  client_id   = keycloak_openid_client.openid_client.id
  name        = "management"
  description = "Management role"
  composite_roles = [
    keycloak_role.reader_role.id
  ]
}

resource "keycloak_role" "reader_role" {
  realm_id    = keycloak_realm.realm.id
  client_id   = keycloak_openid_client.openid_client.id
  name        = "reader"
  description = "Reader role"
}
