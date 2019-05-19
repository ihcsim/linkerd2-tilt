# -*- mode: Python -*-

settings = read_json("tilt_option.json")

# prepends the provided file name with the project root path
def path(file):
  project_home = settings.get("project_home")
  return "{}/{}".format(project_home, file)

# generates the component name by stripping the 'linkerd-' prefix
def resource_name(id):
  if id.name.startswith("linkerd-"):
    return id.name[8:]

# (re-)install control plane, and watch all the deployments
def linkerd_yaml():
  watch_file(path("sh/init.sh"))
  return local(path("sh/init.sh"))

# compute the images tag using the `head_root_tag` function of the bin/_tag.sh
# script.
def image_tag():
  return str(local(path("sh/tag.sh")))

# returns the command use to build the custom image using the
# bin/docker-build-*.sh scripts
def build_image_cmd(component):
  return "{} {}".format(path("sh/build-image.sh"), component)

linkerd_path = path("bin/linkerd")

default_registry(settings.get("default_registry"))
k8s_yaml(linkerd_yaml())

# rename each component by stripping away the 'linkerd-' prefix
workload_to_resource_function(resource_name)

k8s_resource("controller",
  port_forwards=["8085","9995","8086","9996","8088","9998"],
  extra_pod_selectors=[{"linkerd.io/control-plane-component": "controller"}],
)

k8s_resource("proxy-injector",
  port_forwards=["8443"],
  extra_pod_selectors=[{"linkerd.io/control-plane-component": "proxy-injector"}],
)

k8s_resource("identity",
  port_forwards=["8080","9990"],
  extra_pod_selectors=[{"linkerd.io/control-plane-component": "identity"}],
)

k8s_resource("web",
  port_forwards=["8084","9994"],
  extra_pod_selectors=[{"linkerd.io/control-plane-component": "web"}],
)

k8s_resource("sp-validator",
  port_forwards=["8443"],
  extra_pod_selectors=[{"linkerd.io/control-plane-component": "sp-validator"}],
)

k8s_resource("grafana",
  port_forwards=["3000"],
  extra_pod_selectors=[{"linkerd.io/control-plane-component": "grafana"}],
)

k8s_resource("prometheus",
  port_forwards=["9090"],
  extra_pod_selectors=[{"linkerd.io/control-plane-component": "prometheus"}],
)

# Tilt expects the custom_build function to produce an image with the tag
# $EXPECTED_REF, which is set by Tilt to `image_name:tag`.
# See the https://docs.tilt.dev/api.html#api.custom_build doc.
#
# The tag of each component is set by calling the the `head_root_tag` function
# of the bin/_tag.sh script. Each component's image is built by using the
# bin/docker-build-*.sh script. The image is then tagged with the $EXPECTED_REF
# tag.

custom_build(
  "gcr.io/linkerd-io/controller",
  build_image_cmd("controller"),
  [path("controller"), path("pkg"), path("Tiltfile")],
  tag=image_tag(),
  disable_push=bool(settings.get("disable_push"))
)

custom_build(
  "gcr.io/linkerd-io/proxy-init",
  build_image_cmd("proxy-init"),
  [path("proxy-init"), path("Tiltfile")],
  tag=image_tag(),
  disable_push=bool(settings.get("disable_push"))
)

custom_build(
  "gcr.io/linkerd-io/web",
  build_image_cmd("web"),
  [path("web"), path("Tiltfile")],
  tag=image_tag(),
  disable_push=bool(settings.get("disable_push"))
)

custom_build(
  "gcr.io/linkerd-io/grafana",
  build_image_cmd("grafana"),
  [path("grafana"), path("Tiltfile")],
  tag=image_tag(),
  disable_push=bool(settings.get("disable_push")),
  live_update=[
    sync(path('grafana/dashboards'), '/var/lib/grafana/dashboards'),
    sync(path('grafana/dashboards/top-line.json'), '/usr/share/grafana/public/dashboards/home.json'),
    restart_container(),
  ]
)

custom_build(
  "gcr.io/linkerd-io/proxy",
  build_image_cmd("proxy"),
  [path("proxy-identity"), path("Tiltfile")],
  tag=image_tag(),
  disable_push=bool(settings.get("disable_push"))
)
