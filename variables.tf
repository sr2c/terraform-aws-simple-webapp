variable "disable_configuration_bucket" {
  description = "Disable the creation of the configuration bucket (used by Ansible SSM connection plugin)."
  default     = false
  type        = bool
}

variable "disable_logs_bucket" {
  description = "Disable the creation of the logs bucket."
  default     = true
  type        = bool
}

variable "instance_class" {
  description = "The class of EC2 instance to use. See https://aws.amazon.com/ec2/instance-types/ for options."
  type        = string
  default     = "t3.medium"
}

variable "rds_engine" {
  description = "Choose the AWS RDS database engine to use."
  type        = string
  default     = "none"

  validation {
    condition     = contains(["none", "postgres"], var.rds_engine)
    error_message = "The rds_engine variable must be 'none' or 'postgres'."
  }
}

variable "rds_instance_class" {
  description = "The class of RDS instance to use. See https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html for options."
  type        = string
  default     = "db.t3.medium"
}

variable "rds_allocated_storage" {
  description = "The allocated storage in gibibytes for the RDS instance."
  type        = number
  default     = 20
}

variable "rds_engine_version" {
  description = "The engine version of the RDS instance."
  type        = string
  default     = "15.3"

  validation {
    condition     = can(regex("^\\d+\\.\\d+$", var.rds_engine_version))
    error_message = "The RDS engine version must be two integers separated by a period."
  }
}

variable "rds_name" {
  type    = string
  default = "webapp"
}

variable "rds_user" {
  type    = string
  default = "webapp"
}