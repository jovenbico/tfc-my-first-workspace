locals {
  databases = yamldecode(file("value.yaml"))["databases"]
}

resource "random_password" "password" {
  for_each = local.databases
  length   = 16
  special  = true
}

resource "postgresql_role" "my_role" {
  for_each = local.databases

  name     = each.value.owner
  login    = true
  password = random_password.password[each.key].result
  #   password = "r@nd0m-s3cr3t"
}

resource "postgresql_database" "my_db" {
  for_each = local.databases

  name  = each.key
  owner = each.value.owner

  depends_on = [
    postgresql_role.my_role
  ]
}
