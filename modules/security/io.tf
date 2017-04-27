variable "cidr-allow-ssh" {}
variable "cidr-vpc" {}
variable "depends-id" {}
variable "name" {}
variable "vpc-id" {}
variable "tags" { type="map" }

#output "bastion-id" { value = "${ aws_security_group.bastion.id }" }
output "depends-id" { value = "${ null_resource.dummy_dependency.id }" }
output "etcd-id" { value = "${ aws_security_group.etcd.id }" }
output "external-elb-id" { value = "${ aws_security_group.external-elb.id }" }
output "worker-id" { value = "${ aws_security_group.worker.id }" }
