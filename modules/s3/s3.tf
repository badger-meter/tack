resource "aws_s3_bucket" "pki" {

  acl = "private"
  bucket = "${ var.bucket }"
  force_destroy = true

  region = "${ var.aws["region"] }"

  tags {
    builtWith = "terraform"
    KubernetesCluster = "${ var.name }"
    k8s = "${ var.name }"
    Name = "${ var.name }"
    env = "${ var.tags["env"] }"
    Purpose = "${ var.tags["purpose"] }"
  }

}
