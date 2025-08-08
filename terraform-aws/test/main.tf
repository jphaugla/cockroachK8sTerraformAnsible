module "mymodule" {
   source 		= "../"
   cluster_prefix       = "jph-eks"
   aws_config           = ["/Users/jasonhaugland/.aws2/config"]
   aws_credentials      = ["/Users/jasonhaugland/.aws2/credentials"]
   git_home             = "/Users/jasonhaugland/gits/cockroachK8sTerraformAnsible/"
   cidr 		=  "10.0.0.0/16"
   private_subnets      = ["10.0.1.0/25", "10.0.2.0/25", "10.0.3.0/25"]
   public_subnets       = ["10.0.4.0/25", "10.0.5.0/25", "10.0.6.0/25"]
   region 		= "us-east-1"
   cockroach_namespace  = "cockroach"
   run_k8s_cockroach    = "yes"
   eks_cluster_version  = "1.33"
   eks_vm_size          = "t3.xlarge"
   dbadmin_user_name    = "jhaugland"
   dbadmin_user_password = "jasonrocks"
   my_ip_address      = "162.222.52.25"
}
 
output "cluster_endpoint" {
  value = module.mymodule.cluster_endpoint
}

output "cluster_security_group_id" {
  value = module.mymodule.cluster_security_group_id
}

output "region" {
  value = module.mymodule.region
}

output "cluster_name" {
  value = module.mymodule.cluster_name
}

#output "ebs_volume_id" {
#  value = module.mymodule.ebs_volume_id
#}
