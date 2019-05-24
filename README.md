# Linkerd Tilt
This repository contains the Tiltfile to run [Tilt](https://tilt.dev/) with the [Linkerd 2](https://linkerd.io/) control plane.

## Objectives
The goal of this project is to find a tool that improves my development workflow.

Specifically, the tool will enable:
* Uninterrrupted development experience with fast feedback loop; i.e. rebuild and redeploy only what is changed
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

The `tilt_options.json` support the following options:

Option                 | Description
---------------------- | -----------------------------------------
`default_registry`     | the Docker registry to use for the images
`linkerd_install_opts` | additional options to be added to the Linkerd `install` command

### Tilt

To get started, copy the following folders and files to the Linkerd repository:

Copy from           | Copy to
------------------- | ------
`Tiltfile`          | Linkerd project root folder
`tilt_options.json` | Linkerd project root folder
`.tiltignore`       | Linkerd project root folder
`bin/*`             | Linkerd project `bin` folder

Generate the mTLS assets with:
```sh
$ NEW_TLS_ASSETS=true bin/tilt-gen-tls.sh
```
All the mTLS assets can be found in the `.tls` folder.

Then run:
```sh
$ tilt up
```

This will install the Linkerd 2 control plane using the `linkerd install` command.

When done, use `tilt down` to remove the control plane.
