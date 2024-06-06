module "s3_bucket_for_logs" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.0"
  create_bucket = true
  acl    = "private"


  # Allow deletion of non-empty bucket
  force_destroy = true

  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  bucket = "${var.tag_env}-app-output-files-${data.aws_caller_identity.current.account_id}"

}

resource "aws_ssm_parameter" "save_name_of_s3_for_output_flies_to_ssm" {
  name = "/${var.tag_env}/s3_bucket/for_output_files/name"
  description = "url for the created amazon SQS queue"
  value = "${var.tag_env}-app-output-flies-${data.aws_caller_identity.current.account_id}"
}