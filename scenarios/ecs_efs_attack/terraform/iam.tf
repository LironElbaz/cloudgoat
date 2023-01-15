
###########  EC2 Roles ###############

resource "aws_iam_role" "cg-ec2-ruse-role" {
  name               = "cg-ec2-role-${var.cgid}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    Name      = "cg-ec2-role-${var.cgid}"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    git_org   = "LironElbaz"
    git_repo  = "cloudgoat"
    yor_trace = "yor_trace"
  }
}


#IAM Admin Role

resource "aws_iam_role" "cg-efs-admin-role" {
  name               = "cg-efs-admin-role-${var.cgid}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    Name      = "cg-ec2-efsUser-role-${var.cgid}"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    git_org   = "LironElbaz"
    git_repo  = "cloudgoat"
    yor_trace = "yor_trace"
  }
}

###### IAM Lambda Role ######

resource "aws_iam_role" "cg-lambda-role" {
  name = "cg-lambda-role-${var.cgid}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
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

#Iam Role Policy for ec2 "ruse-box"
resource "aws_iam_policy" "cg-ec2-ruse-role-policy" {
  name        = "cg-ec2-ruse-role-policy-${var.cgid}"
  description = "cg-ec2-ruse-role-policy-${var.cgid}"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
              "ecs:Describe*",
              "ecs:List*",
              "ecs:RegisterTaskDefinition",
              "ecs:UpdateService",
              "iam:PassRole",
              "iam:List*",
              "iam:Get*",
              "ec2:CreateTags",
              "ec2:DescribeInstances", 
              "ec2:DescribeImages",
              "ec2:DescribeTags", 
              "ec2:DescribeSnapshots"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
  tags = {
    git_org   = "LironElbaz"
    git_repo  = "cloudgoat"
    yor_trace = "yor_trace"
  }
}

resource "aws_iam_policy" "cg-efs-admin-role-policy" {
  name        = "cg-efs-admin-role-policy-${var.cgid}"
  description = "cg-efs-admin-role-policy-${var.cgid}"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
              "elasticfilesystem:ClientMount"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
  tags = {
    git_org   = "LironElbaz"
    git_repo  = "cloudgoat"
    yor_trace = "yor_trace"
  }
}


################### ECS #####################



#IAM Role
resource "aws_iam_role" "cg-ecs-role" {
  name               = "cg-ecs-role-${var.cgid}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    Name      = "cg-ecs-role-${var.cgid}"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    git_org   = "LironElbaz"
    git_repo  = "cloudgoat"
    yor_trace = "yor_trace"
  }
}
#Iam Role Policy
resource "aws_iam_policy" "cg-ecs-role-policy" {
  name        = "cg-ecs-role-policy-${var.cgid}"
  description = "cg-ecs-role-policy-${var.cgid}"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeImages",
                "logs:CreateLogStream",
                "ec2:DescribeInstances",
                "ec2:DescribeTags",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:GetAuthorizationToken",
                "ssm:TerminateSession",
                "ec2:DescribeSnapshots",
                "logs:PutLogEvents",
                "ecr:BatchCheckLayerAvailability"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "ssm:StartSession",
            "Resource": "arn:aws:ec2:*:*:instance/*",
            "Condition": {
                "StringEquals": {
                    "aws:ResourceTag/StartSession": "true"
                }
            }
        }
    ]
}
POLICY
  tags = {
    git_org   = "LironElbaz"
    git_repo  = "cloudgoat"
    yor_trace = "yor_trace"
  }
}


            