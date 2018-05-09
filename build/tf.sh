#! /usr/bin/env sh

terraform init \
  -plugin-dir=/tf \
  -backend-config="dynamodb_table=${NS}" \
  -backend-config="bucket=${NS}" \
  -backend-config="key=${ENVIRONMENT_NAME}" \
  -reconfigure

terraform workspace select "btcd-ecs-${ENVIRONMENT_NAME}" || terraform workspace new "btcd-ecs-${ENVIRONMENT_NAME}"

terraform workspace list