output "instance_id" {
  description = "ID of the EC2 instance created."
  value       = module.instance.id
}

output "postgres_database_uri" {
  description = "URI to access the database created in the RDS instance."
  value       = local.postgres_database_uri
}