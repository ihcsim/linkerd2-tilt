# Linkerd Tilt
This repository contains the Tiltfile to run [Tilt](https://docs.tilt.dev/welcome_to_tilt.html) with the [Linkerd](https://linkerd.io/) control plane.

## Getting Started
The project uses the following software:

* [Linkerd](https://linkerd.io/2/tasks/install/)
* [Tilt v0.10.8, built 2019-09-20](https://docs.tilt.dev/install.html)
* [Kind v0.5.1](https://kind.sigs.k8s.io)
* [jq 1.5-1-a5b5cbe](https://stedolan.github.io/jq/)

The `tilt_options.json` support the following options:

Option                 | Description
---------------------- | -----------------------------------------
`allow_k8s_contexts`   | the k8s context names that Tilt is allowed to run (for development on remote clusters only)
`default_registry`     | the Docker registry to use for the images (for development on remote clusters only)
`linkerd_install_opts` | additional options to be added to the Linkerd `install` command

To get started, copy the following files to your Linkerd fork:

Copy from           | Copy to
------------------- | ------
`Tiltfile`          | Linkerd project root folder
`tilt_options.json` | Linkerd project root folder
`.tiltignore`       | Linkerd project root folder
`bin/_tilt`         | Linkerd project `bin` folder

Install the Linkerd CLI by following the instruction [here](https://linkerd.io/2/getting-started/).

When ready, run:
```sh
$ tilt up
```
Notice that by default, the `TRIGGER_MODE_MANUAL` mode is used, implying that
Tilt will only update any changes in the Linkerd components when manually
triggered from the Tilt UI. See [dpcs](https://docs.tilt.dev/manual_update_control.html)
for more information.

When done:
```sh
$ tilt down
```
