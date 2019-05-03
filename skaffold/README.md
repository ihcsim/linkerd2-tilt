# Skaffold

The `skaffold.yaml` file is tested with Skaffold v0.26.0. Unlike with Tilt, there isn't a way to only rebuild code that is changes. The closest I get is to rely on Skaffold profiles to perform selective deployments.

To get started, create the following symlinks from the Linkerd2 repository to this repository:
```bash
ln -s `pwd`/linkerd-tilt/Makefile $GOPATH/src/github.com/linkerd/linkerd2/Makefile
ln -s `pwd`/linkerd-tilt/skaffold $GOPATH/src/github.com/linkerd/linkerd2/skaffold
```

The Makefile provides targets to install the control plane, synchronized the k8s YAML files and run Skaffold:
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
