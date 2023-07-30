output "postgres_database_uri" {
  description = "URI to access the database created in the RDS instance."
  value = local.postgres_database_uri
}