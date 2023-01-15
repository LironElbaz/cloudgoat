#IAM Users
resource "aws_iam_user" "cg-lara" {
  name = "lara"
  tags = {
    Name      = "cg-lara-${var.cgid}"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    git_org   = "LironElbaz"
    git_repo  = "cloudgoat"
    yor_trace = "yor_trace"
  }
}
resource "aws_iam_access_key" "cg-lara" {
  user = "${aws_iam_user.cg-lara.name}"
}
resource "aws_iam_user" "cg-mcduck" {
  name = "McDuck"
  tags = {
    Name      = "cg-mcduck-${var.cgid}"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    git_org   = "LironElbaz"
    git_repo  = "cloudgoat"
    yor_trace = "yor_trace"
  }
}
resource "aws_iam_access_key" "cg-mcduck" {
  user = "${aws_iam_user.cg-mcduck.name}"
}

#IAM User Policies
resource "aws_iam_policy" "cg-lara-policy" {
  name        = "cg-lara-s3-policy"
  description = "cg-lara-policy"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::cg-logs-s3-bucket-${local.cgid_suffix}"
    },
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::cg-logs-s3-bucket-${local.cgid_suffix}/*"
    },
    {
      "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeVpcs",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "rds:DescribeDBInstances",
        "elasticloadbalancing:DescribeLoadBalancers"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
  tags = {
    git_org   = "LironElbaz"
    git_repo  = "cloudgoat"
    yor_trace = "yor_trace"
  }
}
resource "aws_iam_policy" "cg-mcduck-policy" {
  name        = "cg-mcduck-s3-policy"
  description = "cg-mcduck-policy"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::cg-keystore-s3-bucket-${local.cgid_suffix}"
    },
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::cg-keystore-s3-bucket-${local.cgid_suffix}/*"
    },
    {
      "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeVpcs",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "rds:DescribeDBInstances"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
  tags = {
    git_org   = "LironElbaz"
    git_repo  = "cloudgoat"
    yor_trace = "yor_trace"
  }
}
#IAM User Policy Attachments
resource "aws_iam_user_policy_attachment" "cg-lara-attachment" {
  user       = "${aws_iam_user.cg-lara.name}"
  policy_arn = "${aws_iam_policy.cg-lara-policy.arn}"
}
resource "aws_iam_user_policy_attachment" "cg-mcduck-attachment" {
  user       = "${aws_iam_user.cg-mcduck.name}"
  policy_arn = "${aws_iam_policy.cg-mcduck-policy.arn}"
}