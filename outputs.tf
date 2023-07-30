output "instance_id" {
  description = "ID of the EC2 instance created."
  value       = module.instance.id
}

output "postgres_database_uri" {
  description = "URI to access the database created in the RDS instance."
  value       = local.postgres_database_uri
}

output "rds_hostname" {
  value = (var.rds_engine == "postgres") ? module.rds_instance[0].hostname : ""
}

output "rds_name" {
  value = var.rds_name
}

output "rds_password" {
  value = random_password.rds_password[0].result
}

output "rds_user" {
  value = var.rds_user
}