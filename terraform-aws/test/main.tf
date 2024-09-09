module "mymodule" {
   source 		= "../"
   cluster_prefix       = "jph-eks"
   aws_config           = ["/Users/jasonhaugland/.aws2/config"]
   aws_credentials      = ["/Users/jasonhaugland/.aws2/credentials"]
   cidr 		=  "10.0.0.0/16"
   private_subnets      = ["10.0.1.0/25", "10.0.2.0/25", "10.0.3.0/25"]
   public_subnets       = ["10.0.4.0/25", "10.0.5.0/25", "10.0.6.0/25"]
   region 		= "us-east-1"
   cockroach_namespace  = "cockroach"
   run_k8s_cockroach    = "yes"
   eks_cluster_version  = "1.30"
}
