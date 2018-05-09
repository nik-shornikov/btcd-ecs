data "aws_caller_identity" "default" {}
data "aws_region" "default" {}
data "aws_vpc" "default" {default = true}
data "aws_subnet_ids" "default" {vpc_id = "${data.aws_vpc.default.id}"}
data "aws_security_group" "default" {vpc_id = "${data.aws_vpc.default.id}" name = "default"}
data "aws_iam_policy" "ecs" {arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"}