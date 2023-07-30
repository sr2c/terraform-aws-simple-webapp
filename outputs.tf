output "configuration_bucket" {
  description = "Name of S3 bucket to be used by Ansible SSM connection plugin."
  value       = module.conf_log.conf_bucket_id
}

output "instance_id" {
  description = "ID of the EC2 instance created."
  value       = module.instance.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance."
  value       = module.instance.public_ip
}

output "logging_bucket" {
  description = "Name of S3 bucket which may be used to hold log outputs."
  value       = module.conf_log.log_bucket_id
}

output "postgres_database_uri" {
  description = "URI to access the database created in the RDS instance."
  value       = local.postgres_database_uri
}

output "rds_hostname" {
  value = (var.rds_engine == "postgres") ? module.rds_instance[0].instance_endpoint : ""
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