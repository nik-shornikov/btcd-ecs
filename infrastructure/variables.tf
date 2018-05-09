variable "rpcpass" {default = "SomeDecentp4ssw0rd"}
variable "miningaddr" {default = "12c6DSiU4Rq3P4ZxziKxzrL5LmMBrzjrJX"}
variable "count" {default = 1}
output "assert" {value = "true"}
output "registry" {value = "${aws_ecr_repository.default.registry_id}"}
output "repo" {value = "${aws_ecr_repository.default.repository_url}"}