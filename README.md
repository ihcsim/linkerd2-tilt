# Linkerd Tilt/Skaffold
This repository contains the Tiltfile and skaffold.yaml that can be used to develop the [Linkerd 2](https://linkerd.io/) control plane.

Both [Tilt](https://tilt.dev/) and [Skaffold](https://skaffold.dev/) are tools used for continuous local development of containerized applications to be deployed as Kubernetes workloads.

Some of the benefits of using Tilt and Skaffold include:

* Fast feedback loop between local code change and testing
* Auto management of images tag
* Easy consistent "local-to-cluster" configuration such as port-forwarding

## Objectives

* Easier development experience for the Linkerd 2 control plane
* Don't want to change repository structure
* Manually specify the image tag (as build arg)

Repository structure:

* One Dockerfile shared by the different components
* A shared `pkg` folder
* Automatically inject proxy sidecar container during deployment

## Getting Started
The project uses the following software:

* [Tilt v0.7.13, built 2019-04-11](https://docs.tilt.dev/install.html)
* [Skaffold v0.26.0](https://github.com/GoogleContainerTools/skaffold)
* [Minikube](https://github.com/kubernetes/minikube)
* [Linkerd 2](https://linkerd.io/2/tasks/install/)

### Tilt

### Skaffold
Create the following symlinks from the Linkerd 2 repository to this repository:
```bash
ln -s `pwd`/linkerd-skaffold/Makefile $GOPATH/src/github.com/linkerd/linkerd2/Makefile
ln -s `pwd`/linkerd-skaffold/skaffold $GOPATH/src/github.com/linkerd/linkerd2/skaffold
```

```bash
# install the Linkerd control plane
make linkerd

# sync the control plane deployment manifests with the local YAML files
make sync

# use the `skaffold build` command to build and tag the control plane component images
make build

# use the `skaffold dev` command to start a dev pipeline
PROFILE=proxy-injector make dev
```
