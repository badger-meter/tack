resource "aws_iam_role" "worker" {
  name = "${ var.env }-k8s-${ var.name }-worker-role"

  assume_role_policy = <<EOS
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOS
}

resource "aws_iam_instance_profile" "worker" {
  name = "${ var.env }-k8s-${ var.name }-worker-role"

  role = "${ aws_iam_role.worker.name }"
}

resource "aws_iam_role_policy" "worker" {
  name = "${ var.env }-k8s-${var.name}-worker-role"
  role = "${ aws_iam_role.worker.id }"
  # Removed from policy
  #        "ec2:CreateRoute",
  #        "ec2:DeleteRoute",
  #        "ec2:ReplaceRoute",
  #        "ec2:DescribeRouteTables",
  #        "ec2:DescribeInstances"
  policy = <<EOS
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": [ "${ var.s3-bucket-arn }/ca.pem" ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "ec2:AttachVolume",
        "ec2:DetachVolume"
      ],
      "Resource": "*"
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
}

resource "null_resource" "dummy_dependency" {
  depends_on = [
    "aws_iam_role.worker",
    "aws_iam_role_policy.worker",
    "aws_iam_instance_profile.worker",
  ]
}
