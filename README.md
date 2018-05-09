## Contents

```
.
├── default.env
├── docker-compose.yml
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

1. Docker-Compose builds the build container
1. Build container invokes an Ansible playbook
1. Ansible playbook invokes local tools and APIs

> The only host dependency is docker-compose; nothing is directly installed

### Quick Start

The expected environment variables without reasonable defaults (i.e. credentials) are pass-thru declared in `default.env`. There are two methods of setting them before executing the CI process, which provisions a small-footprint cluster and deploys the daemon.

> Docker-Machine can be used if directory mounting is set up and/or paths are specified in the override file

#### Environment

Set variables in the shell environment: `AWS_ACCESS_KEY_ID=**** ... docker-compose up --build`

#### Override File

Create an override file to use with docker-compose, and set the variables there: `docker-compose -f docker-compose.yml -f override.yml up --build`

#### Cleanup

With the build image on hand, you clean up everything at once like so: `docker-compose -f docker-compose.yml -f override.yml run ci destroy=everything`
