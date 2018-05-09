## Contents

> The only host dependency is `docker-compose`; nothing is directly installed; `docker-machine` can be used if directory mounting is set up and/or paths are specified in an override file -- with a cloud-based host, the first run should take less than a minute, and the daemons should bootstrap within 2-3

```
.
├── default.env
├── docker-compose.yml
├── (override.yml)
├── .gitignore
├── README.md
├── build
├── infrastructure
└── source
```

1. The build directory is for integrating these artifacts with a CI system; e.g. an image that can manage the infrastructure and deployment of the workload
1. The infrastructure directory is for declarative code-config describing the deployment target infrastructure
1. The source directory is for building and packaging the workload itself

## Overview

The design is based on a subset of the following parameters:

- :white_check_mark: coin daemon: the workload above is the btcd daemon
- :white_check_mark: playbook: an ansible playbook stands in for a CI file
- :white_check_mark: verify sources: git tag signature is checked on _go-get_ cloned repo
- :white_check_mark: compile sources: package is _go-get_ compiled
- :white_check_mark: registry: ecr is used
- :x: ec2: fargate is used
- :x: atomic (Dockerfile and daemon requirements too simple)
- :x: Kubernetes (scheduler requirements too simple)
- :x: Ansible-Container (Dockerfile too simple to benefit; does not cache image layers)

The invocation layers that emulate a CI process (and can be integrated into one at any layer) are the following:

1. Compose builds the CI image
1. CI container invokes Ansible
1. Ansible invokes local tools and APIs

### Quick Start

The expected environment variables without reasonable defaults (i.e. credentials) are pass-thru declared in `default.env`. There are two methods of setting them before executing the CI process, which provisions a small-footprint cluster and deploys the daemon.

The infrastructure and source directories can also be used directly with their respective tools, Ansible, Terraform and Docker.

#### Environment Option

Set variables in the shell environment: `AWS_ACCESS_KEY_ID=**** ... docker-compose up --build`. On subsequent runs the rebuild will short-circuit and the build switch is not necessary.

#### Override File Option

Create an override file to use with docker-compose, and set the variables there: `docker-compose -f docker-compose.yml -f override.yml up --build`. On subsequent runs the rebuild will short-circuit and the build switch is not necessary.

#### Cleanup

After building the CI image, you can clean up everything at once with the run subcommand: `... run ci destroy=everything`. The `CMD` is passed to Ansible as extra variables. Because of S3 bucket API consistency limitations, there is also the option to pass `destroy-infrastructure`, which leaves the low-cost remote state resources in place.
