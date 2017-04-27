resource "aws_iam_role" "pki" {

  name = "${ var.tags["env"] }-k8s-${ var.name }-pki"

  assume_role_policy = <<EOS
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOS

}


resource "aws_iam_instance_profile" "pki" {
  name = "${ var.tags["env"] }-k8s-${ var.name }-pki"
  role = "${ aws_iam_role.pki.name }"
}


resource "aws_iam_role_policy" "master" {

  name = "${ var.tags["env"] }-k8s-${ var.name }-pki"

  policy = <<EOS
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Put*"
      ],
      "Effect": "Allow",
      "Resource": [ "${ var.s3-bucket-arn }/*" ]
    }
  ]
}
EOS

  role = "${ aws_iam_role.pki.id }"

}
