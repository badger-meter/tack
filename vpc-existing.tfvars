# # This is merged in with terraform.tfvars for override/existing VPC purposes.  Only to be used in conjunction with modules_override.tf

# # The existing VPC CIDR range, ensure that the the etcd, controller and worker IPs are in this range
cidr.vpc = "10.1.0.0/16"

# # etcd server static IPs, ensure that they fall within the exisiting VPC private subnet range
etcd-ips = "10.1.0.55,10.1.0.56,10.1.0.57"

# # Put your existing VPC info here:
vpc-existing {
	id = "vpc-a7bc4dc3"
	gateway-id = "igw-cdf4d3a8"
	subnet-ids-public = "subnet-7c7f2225"
	subnet-ids-private = "subnet-587f2201"
}
