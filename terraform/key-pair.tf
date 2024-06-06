resource "aws_key_pair" "html2pdf" {
  key_name = "${var.tag_env}-html2pdf"
  public_key = var.id_rsa
}