resource "aws_iam_role" "default" {
  name = "${terraform.env}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "default" {
  role = "${aws_iam_role.default.name}"
  policy_arn = "${data.aws_iam_policy.ecs.arn}"
}