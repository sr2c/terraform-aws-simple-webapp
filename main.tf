module "conf_log" {
  source                       = "sr2c/ec2-conf-log/aws"
  version                      = "0.0.3"
  context                      = module.this.context
  attributes                   = ["conflog"]
  disable_configuration_bucket = var.disable_configuration_bucket
  disable_logs_bucket          = var.disable_logs_bucket
}

module "instance" {
  source                      = "cloudposse/ec2-instance/aws"
  version                     = "0.45.1"
  attributes                  = ["instance"]
  ami                         = data.aws_ami.ubuntu.id
  ami_owner                   = data.aws_ami.ubuntu.owner_id
  instance_type               = var.instance_class
  vpc_id                      = data.aws_vpc.default.id
  security_groups             = var.rds_engine == "postgres" ? [aws_security_group.allow_rds_access[0].id] : []
  subnet                      = data.aws_subnet.first.id
  context                     = module.this.context
  instance_profile            = module.conf_log.instance_profile_name
  associate_public_ip_address = true
  security_group_rules = [
    {
      "cidr_blocks" : [
        "0.0.0.0/0"
      ],
      "description" : "Allow all outbound traffic",
      "from_port" : 0,
      "protocol" : "-1",
      "to_port" : 65535,
      "type" : "egress"
    },
    {
      "cidr_blocks" : [
        "0.0.0.0/0"
      ],
      "description" : "Allow access to HTTP",
      "from_port" : 80,
      "protocol" : "6",
      "to_port" : 80,
      "type" : "ingress"
    },
    {
      "cidr_blocks" : [
        "0.0.0.0/0"
      ],
      "description" : "Allow access to HTTPS",
      "from_port" : 443,
      "protocol" : "6",
      "to_port" : 443,
      "type" : "ingress"
    }
  ]
}
