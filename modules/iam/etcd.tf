resource "aws_iam_role" "master" {
  name = "${ var.env }-k8s-${ var.name }-controller-role"

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

resource "aws_iam_instance_profile" "master" {
  name = "${ var.env }-k8s-${ var.name }-controller-role"

  role = "${ aws_iam_role.master.name }"
}

resource "aws_iam_role_policy" "master" {
  name = "${ var.env }-k8s-${ var.name }-controller-role"

  policy = <<EOS
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Get*"
      ],
      "Effect": "Allow",
      "Resource": [ "${ var.s3-bucket-arn }/*" ]
    },
    {
      "Action": [
        "ec2:*",
        "elasticloadbalancing:*"
        ],
      "Effect": "Allow",
      "Resource": [ "*" ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:BatchGetImage"
      ],
      "Resource": "*"
    }
  ]
}
EOS

  role = "${ aws_iam_role.master.id }"
}
