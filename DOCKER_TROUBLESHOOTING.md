# Docker Troubleshooting and Crash Recovery Guide

## 1. Project Overview

This project uses Docker to containerise a Next.js application.

Docker packages the application and its dependencies into an image, which can be used to create and run containers.

## 2. Checking Container Status

To check currently running containers:

```bash
docker ps
```

To check all containers, including stopped containers:

```bash
docker ps -a
```

## 3. Viewing Application Logs

To view application logs:

```bash
docker logs my-first-app-container
```

To continuously monitor logs:

```bash
docker logs -f my-first-app-container
```

Press Ctrl+C to exit live log monitoring.

## 4. Inspecting Container Details

To check container status:

```bash
docker inspect -f '{{.State.Status}}' my-first-app-container
```

To check restart count:

```bash
docker inspect -f '{{.RestartCount}}' my-first-app-container
```

To check exit code:

```bash
docker inspect -f '{{.State.ExitCode}}' my-first-app-container
```

## 5. Managing Containers

To stop a container:

```bash
docker stop my-first-app-container
```

To start an existing container:

```bash
docker start my-first-app-container
```

To restart a container:

```bash
docker restart my-first-app-container
```

## 6. Docker Restart Policies

Docker restart policies help containers recover when their main process exits.

Available policies:

- no: Does not automatically restart the container.
- always: Always attempts to restart the container.
- unless-stopped: Restarts unless the container was manually stopped.
- on-failure: Restarts when the container exits with a non-zero exit code.

To configure a restart policy:

```bash
docker update --restart unless-stopped my-first-app-container
```

To verify the restart policy:

```bash
docker inspect -f '{{.HostConfig.RestartPolicy.Name}}' my-first-app-container
```

## 7. Crash Investigation

When a container stops unexpectedly:

1. Check its status using `docker ps -a`.
2. Check its logs using `docker logs my-first-app-container`.
3. Inspect its exit code.
4. Check its restart count.
5. Investigate error messages in the logs.
6. Correct the underlying problem.
7. Restart the container if appropriate.

Common exit codes:

- 0: Process exited successfully.
- 1: General application error.
- 137: Process was killed using SIGKILL or terminated by a forced kill.

An exit code alone does not always identify the root cause.

## 8. Testing Automatic Restart

A separate test container was created to verify Docker restart policies.

The test confirmed that Docker automatically restarted the container after its process exited.

The restart count increased, confirming that the restart policy was working.

The temporary test container was removed after testing.

## 9. GitHub Actions Automation

A GitHub Actions workflow was created at:

`.github/workflows/docker.yml`

The workflow automatically:

1. Starts when code is pushed to the main branch.
2. Checks out the repository.
3. Sets up Docker Buildx.
4. Builds the Docker image.
5. Reports whether the build succeeded or failed.

The workflow currently builds an image but does not publish it to a container registry or deploy it.

## 10. Important Docker Commands

| Command | Purpose |
|---|---|
| `docker images` | Lists Docker images |
| `docker ps` | Lists running containers |
| `docker ps -a` | Lists all containers |
| `docker logs CONTAINER` | Displays logs |
| `docker stop CONTAINER` | Stops a container |
| `docker start CONTAINER` | Starts a container |
| `docker restart CONTAINER` | Restarts a container |
| `docker rm -f CONTAINER` | Force-removes a container |
| `docker inspect CONTAINER` | Displays detailed container information |
| `docker build -t NAME .` | Builds a Docker image |
| `docker run -d -p 3000:3000 NAME` | Runs a container with port mapping |

## 11. Project Completion Summary

Completed tasks:

- Created a Dockerfile.
- Created a .dockerignore file.
- Configured environment variables.
- Built a Docker image.
- Ran the application inside a Docker container.
- Verified the application through localhost:3000.
- Explored application logs.
- Practised container stop, start and restart operations.
- Configured and tested Docker restart policies.
- Pushed Docker configuration to GitHub.
- Created a GitHub Actions workflow.
- Successfully verified the automated Docker build.

## 12. Conclusion

This project provided practical experience with Docker containerisation, container monitoring, restart policies, crash investigation and GitHub Actions automation.

The next step is to explore deployment, automated testing and production troubleshooting.

## 13. Deployment and Verification

The Next.js application was deployed using Vercel.

Deployment URL:
https://my-first-app-ten-theta.vercel.app

Verification:
- Opened the deployment URL in a browser.
- Confirmed that the application was accessible.
- Also verified the Docker container locally at http://localhost:3000.

The Vercel deployment and local Docker container are separate deployments.
