
module "eks" {

    source = "terraform-aws-modules/eks/aws"
    version = "~> 21.0"

    #Control plane configuration
    name               = local.name
    kubernetes_version = "1.30"
    endpoint_public_access = true

    vpc_id     = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets
    control_plane_subnet_ids = module.vpc.private_subnets  # here you can use intra_subnets also, but then you have to define vpc endpoints for EKS also, so, for simplicity using private_subnets, it will reduce cost and complexity also

    create_node_security_group = true  # to create security group for worker nodes

    # to avoid RBAC issues
    # enable_cluster_creator_admin_permissions = true  # you dont need this line, if you are using access_entries block below, it will create errors if you use both so comment this line and use access_entries block below

    addons = {

        coredns                = {}

        eks-pod-identity-agent = {
            before_compute = true
        }

        kube-proxy             = {}

        vpc-cni                = {
            before_compute = true
        }
    }
  

    # EKS Managed Node Group(s) configuration
    eks_managed_node_groups = {
      rks-cluster-node-group = {  
        # ami_type       = "AL2023_x86_64_STANDARD"  # if you dont want to use default AMI, then it will use linux AMI by default
        instance_types = ["t2.medium"]
  
        min_size     = 2
        max_size     = 3
        desired_size = 2

        capacity_type = "SPOT" #spot just for cost saving otherwise you can skip this option
      }
    }

    # How to create access_entries to allow Iam user to access the cluster
    access_entries = {

        # DevOps IAM User Access (Cluster Admin policy attached)
        devops_admin = {

            description   = "DevOps IAM User Access (Cluster Admin)"
            principal_arn = "arn:aws:iam::529088294745:user/rks007"
            type          = "STANDARD"  # important to set standard type


            policy_associations = {

                admin_access = {
                    policy_arn   = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy" #policy for full admin access
                    access_scope = { 
                        type = "cluster" 
                    }
                }
            }
        }
      
    }

    tags = {
        Environment = local.env
        Terraform   = "true"
    }
}