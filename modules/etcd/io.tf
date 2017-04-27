variable "ami-id" {}
variable "aws" {
  type = "map"
}
variable "cluster-domain" {}
variable "depends-id" {}
variable "dns-service-ip" {}
variable "etcd-ips" {}
variable "etcd-security-group-id" {}
variable "external-elb-security-group-id" {}
variable "instance-profile-name" {}
variable "instance-type" {}
variable "internal-tld" {}

variable "ip-k8s-service" {}

variable "k8s" {
  type = "map"
}

variable "name" {}
variable "s3-bucket" {}
variable "pod-ip-range" {}
variable "service-cluster-ip-range" {}
variable "subnet-ids-private" {}
variable "subnet-ids-public" {}
variable "vpc-id" {}
variable "tags" { type="map" }

output "depends-id" { value = "${ null_resource.dummy_dependency.id }" }
output "external-elb" { value = "${ aws_elb.external.dns_name }" }
output "internal-ips" { value = "${ join(",", aws_instance.etcd.*.public_ip) }" }
