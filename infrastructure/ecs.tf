resource "aws_ecs_cluster" "default" {name = "${terraform.env}"}
resource "aws_ecs_service" "default" {
  name = "${terraform.env}"
  cluster = "${aws_ecs_cluster.default.id}"
  task_definition = "${aws_ecs_task_definition.default.arn}"
  desired_count = 1
  launch_type = "FARGATE"
  network_configuration {
    security_groups = ["${data.aws_security_group.default.id}"]
    subnets = ["${data.aws_subnet_ids.default.ids}"]
  }
}
resource "aws_ecs_task_definition" "default" {
  execution_role_arn = "${aws_iam_role.default.arn}"
  family = "${terraform.env}"
  requires_compatibilities = ["FARGATE"]
  cpu = "256"
  memory = "512"
  network_mode = "awsvpc"
  container_definitions = <<DEFINITION
[
  {
  "cpu": 256,
  "image": "${data.aws_caller_identity.default.account_id}.dkr.ecr.${data.aws_region.default.name}.amazonaws.com/${terraform.env}",
  "memory": 512,
  "name": "default",
  "networkMode": "awsvpc"
  }
]
DEFINITION
}