variable "base_domain" {
  description = "Base domain for DNS records"
  type = string
}

variable "aws_region" {
  description = "AWS region to create resources"
  type = string
}

variable "tag_env" {
  description = "tag env for out all resources"
}

variable "id_rsa" {
  type = string
  description = "Public ssh key for ec2 instance"
}

variable "datadog_api_key" {
  type = string
  description = "Datadog API key"
}

variable "datadog_region" {
  description = "Datadog region"
  type = string
}

variable "datadog_application_key" {
  description = "Datadog application key"
  type = string
}

variable "registrationToken" {
  description = "Registration token to register github runner"
  type = string
}

variable "ci_project_repo" {
  description = "CI project repo to register github runner"
  type = string
}

variable "cd_project_repo" {
  description = "argo CD project repo"
  type = string
}

data "aws_availability_zone" "available" {}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
  depends_on = [
    module.eks.cluster_name
  ]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
  depends_on = [
    module.eks.cluster_name
  ]
}