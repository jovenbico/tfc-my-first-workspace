## https://developer.hashicorp.com/terraform/language/functions/flatten
## https://www.daveperrett.com/articles/2021/08/19/nested-for-each-with-terraform/
locals {
  schemas    = [
                 "PRIVATE",
                 "PUBLIC",
                 "MY_SCHEMA",
               ]
  privileges = [
                 "CREATE TABLE",
                 "CREATE VIEW",
                 "USAGE",
               ]

  # Nested loop over both lists, and flatten the result.
  schema_privileges = distinct(flatten([
    for schema in local.schemas : [
      for privilege in local.privileges : {
        schema    = schema
        privilege = privilege
      }
    ]
  ]))
}

################## local.schema_privileges #####################
# [
#   { privilege: "CREATE TABLE", schema: "PRIVATE" },
#   { privilege: "CREATE VIEW",  schema: "PRIVATE" },
#   { privilege: "USAGE",        schema: "PRIVATE" },
#   { privilege: "CREATE TABLE", schema: "PUBLIC" },
#   { privilege: "CREATE VIEW",  schema: "PUBLIC" },
#   { privilege: "USAGE",        schema: "PUBLIC" },
#   { privilege: "CREATE TABLE", schema: "MY_SCHEMA" },
#   { privilege: "CREATE VIEW",  schema: "MY_SCHEMA" },
#   { privilege: "USAGE",        schema: "MY_SCHEMA" },
# ]

# resource "snowflake_schema_grant" "write_permissions" {
#   # We need a map to use for_each, so we convert our list into a map by adding a unique key:
#   for_each      = { for entry in local.schema_privileges: "${entry.schema}.${entry.privilege}" => entry }
#   database_name = "MY_DATABASE"
#   privilege     = each.value.privilege
#   roles         = "DAVE"
#   schema_name   = each.value.schema
# }