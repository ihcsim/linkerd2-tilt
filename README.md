# Linkerd Tilt
This repository contains the Tiltfile used in the [_Code Fast and Test Accurately Without Kubectl_](https://cfp.cloud-native.rejekts.io/cloud-native-rejekts-na-2019/talk/HYEW3M/) talk at [Rejekts NA 2019](https://cloud-native.rejekts.io/). The Tiltfile automates the build and deploy steps of the [Linkerd control planei](https://github.com/linkerd/linkerd2).

## Resources

* Presentation slide: https://cfp.cloud-native.rejekts.io/media/Rejekts_NA_2019_-_Linkerd__Tilt_i7tr018.pdf
* Presentation recording: Coming soon

## Getting Started
The project is tested with the following software:

* [Linkerd edge-19.11.2](https://linkerd.io/2/getting-started/#step-0-setup)
* [Tilt v0.10.17, built 2019-11-01](https://docs.tilt.dev/install.html)
* [Kind v0.5.1](https://kind.sigs.k8s.io)
* [jq 1.5-1-a5b5cbe](https://stedolan.github.io/jq/)

To get started, copy the following files to your Linkerd fork:

Copy from           | Copy to
------------------- | ------
`Tiltfile`          | Linkerd project root folder
`tilt_options.json` | Linkerd project root folder
`.tiltignore`       | Linkerd project root folder
`bin/_tilt`         | Linkerd project `bin` folder

When ready, run:
```sh
$ tilt up
```

When done:
```sh
$ tilt down
```
