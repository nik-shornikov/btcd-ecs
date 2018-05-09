output "assert" {value = "true"}
output "registry" {value = "${aws_ecr_repository.default.registry_id}"}
output "repo" {value = "${aws_ecr_repository.default.repository_url}"}