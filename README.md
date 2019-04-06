# Linkerd Skaffold
This repository contains the skaffold.yaml that can be used to develop the [Linkerd 2](https://linkerd.io/) control plane.

[Skaffold](https://skaffold.dev/) is a command line tool that facilitates continuous development for Kubernetes applications.

## Getting Started
Create the following symlinks from the Linkerd 2 repository to tihs repository:
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
