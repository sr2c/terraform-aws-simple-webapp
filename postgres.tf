locals {
  rds_engine_major_version = element(split(".", var.rds_engine_version), 0)
  postgres_database_uri    = var.rds_engine == "postgres" ? "postgresql://${var.rds_user}:${random_password.rds_password[0].result}@${module.rds_instance[0].instance_endpoint}/${var.rds_name}" : ""
}

resource "aws_security_group" "allow_rds_access" {
  count       = (var.rds_engine == "postgres") ? 1 : 0
  name        = "${module.this.id}-rds-access"
  description = "Allow access to the database"
  vpc_id      = data.aws_vpc.default.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "random_password" "rds_password" {
  count            = (var.rds_engine == "postgres") ? 1 : 0
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

module "rds_instance" {
  count                       = (var.rds_engine == "postgres") ? 1 : 0
  source                      = "cloudposse/rds/aws"
  version                     = "0.40.0"
  context                     = module.this.context
  attributes                  = ["rds"]
  security_group_ids          = [aws_security_group.allow_rds_access[0].id]
  database_name               = var.rds_name
  database_user               = var.rds_user
  database_password           = random_password.rds_password[0].result
  database_port               = 5432
  storage_type                = "gp2"
  allocated_storage           = var.rds_allocated_storage
  storage_encrypted           = true
  engine                      = "postgres"
  engine_version              = var.rds_engine_version
  major_engine_version        = local.rds_engine_major_version
  instance_class              = var.rds_instance_class
  db_parameter_group          = "postgres${local.rds_engine_major_version}"
  publicly_accessible         = false
  subnet_ids                  = [data.aws_subnet.first.id, data.aws_subnet.second.id]
  vpc_id                      = data.aws_vpc.default.id
  auto_minor_version_upgrade  = true
  allow_major_version_upgrade = false
  apply_immediately           = false
  maintenance_window          = "Mon:03:00-Mon:04:00"
  skip_final_snapshot         = false
  copy_tags_to_snapshot       = true
  backup_retention_period     = 7
  backup_window               = "22:00-03:00"
}
