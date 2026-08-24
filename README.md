# Project 11 — Containerized CI/CD Pipeline with Jenkins

A minimal, reproducible CI/CD lab that builds a Docker image, runs it as a container, and verifies the application from a Jenkins pipeline.

## Architecture

```text
Git push
   |
   v
Jenkins
   |
   +--> Checkout
   +--> Validate files
   +--> docker build
   +--> docker run
   +--> HTTP smoke test
   |
   v
Containerized Nginx app
```

## Prerequisites

- Jenkins with the Pipeline plugin
- Docker CLI/daemon available to the Jenkins agent
- `curl`
- Git

The Jenkins agent must be permitted to use Docker.

## Local validation

```bash
./tests/test_project11.sh
```

Build and run manually:

```bash
docker build -t project11-app .
docker run --rm -p 8080:80 project11-app
```

Open `http://localhost:8080/`.

## Jenkins setup

1. Create a Pipeline job.
2. Point it at this Git repository.
3. Use `Jenkinsfile` from SCM.
4. Ensure the build agent has Docker access.
5. Run the pipeline.

The pipeline validates the application, builds an image tagged with `BUILD_NUMBER`, starts a test container, verifies the HTTP endpoint, and cleans up the container.

## Scope

This project intentionally demonstrates CI/CD fundamentals rather than production Jenkins administration. Credentials, registries, deployment environments, secrets management, and rollback strategies are introduced in later projects.
