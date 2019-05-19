# Linkerd Tilt
This repository contains the Tiltfile to run [Tilt](https://tilt.dev/) with the [Linkerd 2](https://linkerd.io/) control plane.

## Objectives
The goal of this project is to find a tool that improves my development workflow.

Specifically, the tool will enable:
* Uninterrrupted development experience with fast feedback loop
  * Rebuild and redeploy only what is changed
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

* [Tilt v0.8.0, built 2019-04-22](https://docs.tilt.dev/install.html)
* [Minikube](https://github.com/kubernetes/minikube)
* [Linkerd 2](https://linkerd.io/2/tasks/install/)

### Tilt

Create the following symlinks from the Linkerd2 repository to this repository:
```bash
ln -s `pwd`/linkerd-tilt/Tiltfile $GOPATH/src/github.com/linkerd/linkerd2/Tiltfile
ln -s `pwd`/linkerd-tilt/sh $GOPATH/src/github.com/linkerd/linkerd2/sh
ln -s `pwd`/linkerd-tilt/tls $GOPATH/src/github.com/linkerd/linkerd2/tls
ln -s `pwd`/linkerd-tilt/.tiltignore $GOPATH/src/github.com/linkerd/linkerd2/.tiltignore
```

To get started, generate the mTLS assets with
```sh
$ NEW_TLS_ASSETS=true sh/gen-tls.sh
```
All done self-signed TLS assets used for mTLS will be stored in the git-ignored `tls` folder. The folder path can be overridden by using the `TLS_FOLDER` environment variable.

Then run:
```sh
$ tilt up
```

This will install the Linkerd 2 control plane using the `linkerd install` command.

When done, use `tilt down` to remove the control plane.
