module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.tag_env}-eks"
  cluster_version = "1.29"

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets


  node_security_group_additional_rules = {
    ingress_source_security_group_id = {
      protocol = "tcp"
      from_port = 80
      to_port = 80
      type = "ingress"
      source_security_group_id = module.eks.node_security_group_id
      description = "Ingress from another computed sg"
    }
  }

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    internal-service = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
      subnet_ids = module.vpc.private_subnets
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

}

