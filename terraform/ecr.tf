module "ecr" {
  name = "${var.tag_env}-ecr"
  source = "cloudposse/ecr/aws"
  version = "0.40.0"
  image_name = ["${var.tag_env}/api", "${var.tag_env}/ui", "${var.tag_env}/lambda"]
  use_fullname = true
  force_delete = true
  image_tag_mutability = "MUTABLE"
}