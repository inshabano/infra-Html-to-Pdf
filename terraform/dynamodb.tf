module "dynamodb_table" {
  source   = "terraform-aws-modules/dynamodb-table/aws"
  version  = "4.0.0"
  create_table = true
  name     = "${var.tag_env}-dynamodb-table"

  hash_key = "username"

  attributes = [
    {
      name = "username"
      type = "S"
    }
  ]

  tags =
    Environment = "${var.tag_env}"
  }
}

resources "aws_ssm_parameter" "save_dynamodb_table_name_to_ssm" {
  name = "/${var.tag_env}/dynamodb/table_name"
  description = "url for the created dynamodb table name"
  type = "SecureString"
  value = "${var.tag_env}-dynamodb_table"
}