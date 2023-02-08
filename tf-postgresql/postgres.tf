locals {
  databases = yamldecode(file("value.yaml"))["databases"]
}

# resource "random_password" "password" {
#   for_each = local.databases
#   length   = 16
#   special  = true
# }

resource "postgresql_role" "role" {
  for_each = local.databases

  name  = each.value.owner
  login = true
  # password = random_password.password[each.key].result
  password = each.value.password
}

resource "postgresql_database" "db" {
  for_each = local.databases

  name  = each.key
  owner = each.value.owner

  depends_on = [
    postgresql_role.role
  ]
}

# !!! It works with it !!! #
############################
# resource "postgresql_grant" "owner_db" {
#   for_each = local.databases

#   database    = each.key
#   role        = each.value.owner
#   schema      = "public"
#   object_type = "database"
#   privileges  = ["CONNECT", "CREATE", "TEMPORARY"]

#   depends_on = [
#     postgresql_grant.public_revoke_schema,
#     postgresql_grant.public_revoke_database
#   ]
# }

resource "postgresql_grant" "owner_schema" {
  for_each = local.databases

  database    = each.key
  role        = each.value.owner
  schema      = "public"
  object_type = "schema"
  privileges  = ["CREATE", "USAGE"]

  depends_on = [
    postgresql_grant.public_revoke_schema,
    postgresql_grant.public_revoke_database
  ]
}

# Revoke default accesses for PUBLIC role to the databases
resource "postgresql_grant" "public_revoke_database" {
  for_each = local.databases

  database    = each.key
  role        = "public"
  object_type = "database"
  privileges  = []

  with_grant_option = true

  depends_on = [
    postgresql_database.db
  ]
}

# Revoke default accesses for PUBLIC role to the public schema
resource "postgresql_grant" "public_revoke_schema" {
  for_each = local.databases

  database    = each.key
  role        = "public"
  schema      = "public"
  object_type = "schema"
  privileges  = []

  with_grant_option = true

  depends_on = [
    postgresql_database.db
  ]
}