module "sqs" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "4.1.0"
  name = "${var.tag_env}-sqs"
  content_based_deduplication = true

  fifo_queue = true
  visibility_timeout_seconds = 360
  use_name_prefix = true

  create = true
}

resource "aws_ssm_parameter" "sqs_arn" {
  name = "/${var.tag_env}/sqs/arn"
  description = "ARN of the AWS SQS queue"
  type = "SecureString"
  value = module.sqs.queue_arn
}

resource "aws_ssm_parameter" "sqs_name" {
  name = "/${var.tag_env}/sqs/name"
  description = "Name pf thr created SQS queue"
  type = "SecureString"
  value = module.sqs.queue_name
}

resource "aws_ssm_parameter" "sqs_url_path" {
  name = "/${var.tag_env}/sqs/url"
  description = "URL for the AWS SQS queue"
  type = "SecureString"
  value = module.sqs.queue_id
}