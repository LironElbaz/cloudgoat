#AWS SSM Parameters
resource "aws_ssm_parameter" "cg-ec2-public-key" {
  name        = "cg-ec2-public-key-${var.cgid}"
  description = "cg-ec2-public-key-${var.cgid}"
  type        = "String"
  value       = "${file("../cloudgoat.pub")}"
  tags = {
    Name      = "cg-ec2-public-key-${var.cgid}"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    git_org   = "LironElbaz"
    git_repo  = "cloudgoat"
    yor_trace = "yor_trace"
  }
}
resource "aws_ssm_parameter" "cg-ec2-private-key" {
  name        = "cg-ec2-private-key-${var.cgid}"
  description = "cg-ec2-private-key-${var.cgid}"
  type        = "String"
  value       = "${file("../cloudgoat")}"
  tags = {
    Name      = "cg-ec2-private-key-${var.cgid}"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    git_org   = "LironElbaz"
    git_repo  = "cloudgoat"
    yor_trace = "yor_trace"
  }
}