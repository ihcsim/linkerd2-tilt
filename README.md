# Linkerd Tilt
This repository contains the Tiltfile to run [Tilt](https://tilt.dev/) with the [Linkerd 2](https://linkerd.io/) control plane.

## Objectives
The goal of this project is to find a tool that improves the efficiency of the development of the Linkerd2 control plane.

Specifically, the tool will enable:
* Easy development experience with fast feedback loop
  * Rebuild and re-deploy only what is changed
* Works with the current [Linkerd2 control plane repository](https://github.com/linkerd/linkerd2) layout, which contains:
  * source code for multiple components
  * mulitple Dockerfiles
  * static assets like CSS and Javascripts
  * partial "uninjected" helm charts
  * protobuf files
  * shared libraries in the `pkg` folder
* A way to pin the image tag and pass it to the Dockerfile as a build argument

## Getting Started
The project uses the following software:

* [Tilt v0.7.13, built 2019-04-11](https://docs.tilt.dev/install.html)
* [Minikube](https://github.com/kubernetes/minikube)
* [Linkerd 2](https://linkerd.io/2/tasks/install/)

### Tilt

Create the following symlinks from the Linkerd2 repository to this repository:
```bash
ln -s `pwd`/linkerd-tilt/Tiltfile $GOPATH/src/github.com/linkerd/linkerd2/Tiltfile
ln -s `pwd`/linkerd-tilt/sh $GOPATH/src/github.com/linkerd/linkerd2/sh
ln -s `pwd`/linkerd-tilt/tls $GOPATH/src/github.com/linkerd/linkerd2/tls
```

Run `tilt up` to bring up Tilt. When done, use `tilt down` to remove the control plane.
