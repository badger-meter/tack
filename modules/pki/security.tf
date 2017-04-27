resource "aws_security_group" "pki" {

  description = "k8s pki security group"

  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
    cidr_blocks = [ "${ var.cidr-vpc }" ]
  }

  name = "${ var.tags["env"] }-k8s-${ var.name }-pki"

  tags {
    KubernetesCluster = "${ var.name }"
    # kz8s = "${ var.name }"
    Name = "${ var.tags["env"] }-k8s-${ var.name }-pki"
    builtWith = "terraform"
    env = "${ var.tags["env"] }"
    Purpose = "${ var.tags["purpose"] }"
  }

  vpc_id = "${ var.vpc-id }"
}
