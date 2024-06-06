module "rds" {
  source = "cloudposse/rds-cluster/aws"
  version = "1.7.0"

  name                 = "${var.tag_env}-rds"
  engine               = "aurora-mysql"
  engine_mode          = "serverless"
  cluster_family       = "aurora-mysql5.7"
  cluster_size         = 0
  cluster_type         = "regional"
  admin_user           = random_password.rds_admin_username.result
  admin_password       = random_password.rds_password.result
  db_name              = random_password.rds_db_name.result
  db_port              = 3306
  vpc_id               = module.vpc.vpc_id
  security_groups      = [module.eks.node_security_group_id, aws_security_group.bastion_host.id]
  subnets              = module.vpc.database_subnets
  enable_http_endpoint = true

  scaling_configuration = [
    {
      auto_pause               = true
      max_capacity             = 16
      min_capacity             = 1
      seconds_until_auto_pause = 300
      timeout_action           = "ForceApplyCapacityChange"
    }
  ]

  tags = {
    Name = "${var.tag_env}-rds"
  }
}

resource "random_password" "rds_password" {
  length = 7
  special = true
  override_special = "!#"
}

resource "random_password" "rds_admin_username" {
  length = 16
  special = false
  numeric = false
}

resource "random_password" "rds_db_name" {
  length = 7
  special = false
  numeric = false
}

resource "aws_ssm_parameter" "save_rds_password_to_ssm" {
  name = "/${var.tag_env}/rds/password"
  description = "rds password"
  type = "SecureString"
  value = random_password.rds_password.result
}

resource "aws_ssm_parameter" "save_rds_endpoint_to_ssm" {
  name = "/${var.tag_env}/rds/endpoint"
  description = "rds endpoint"
  type = "SecureString"
  value = module.rds.endpoint
}

resource "aws_ssm_parameter" "save_rds_admin_username_to_ssm" {
  name = "/${var.tag_env}/rds/username"
  description = "rds username"
  type = "SecureString"
  value = random_password.rds_admin_username.result
}
