# -*- mode: Python -*-

k8s_resource_assembly_version(2)

project_home = "/home/isim/workspace/go/src/github.com/linkerd/linkerd2"

# prepends the provided file name with the project root path
def path(file):
  return "{}/{}".format(project_home, file)

# generates the component name by stripping the 'linkerd-' prefix
def resource_name(id):
  if id.name.startswith("linkerd-"):
    return id.name[8:]

# (re-)install control plane, and watch all the deployments
def linkerd_yaml():
  return local(path("init.sh"))

linkerd_path = path("bin/linkerd")
image_tag = "isim-dev"
identity_issuer_certificate_file = path("tls/identity.linkerd.cluster.local.crt")
identity_issuer_key_file = path("tls/identity.linkerd.cluster.local.key")
identity_trust_anchors_file = path("tls/ca.crt")
identity_trust_domain = "cluster.local"

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

custom_build(
  "gcr.io/linkerd-io/controller",
  "docker build -t $EXPECTED_REF --build-arg LINKERD_VERSION={} -f {} {}". format(image_tag, path("controller/Dockerfile"), project_home),
  [path("controller"), path("pkg"), path("Tiltfile")],
  tag=image_tag,
  disable_push=True,
)

custom_build(
  "gcr.io/linkerd-io/proxy-init",
  "docker build -t $EXPECTED_REF -f {} {}". format(path("proxy-init/Dockerfile"), project_home),
  [path("proxy-init"), path("Tiltfile")],
  tag=image_tag,
  disable_push=True,
)

custom_build(
  "gcr.io/linkerd-io/web",
  "docker build -t $EXPECTED_REF --build-arg LINKERD_VERSION={} -f {} {}". format(image_tag, path("web/Dockerfile"), project_home),
  [path("web"), path("Tiltfile")],
  tag=image_tag,
  disable_push=True,
  live_update=[
    sync(path('web/app'), '/go/src/github.com/linkerd/linkerd2/web/app'),
    run('/go/src/github.com/linkerd/linkerd2/bin/web build'),
  ]
)

custom_build(
  "gcr.io/linkerd-io/grafana",
  "docker build -t $EXPECTED_REF -f {} {}". format(path("grafana/Dockerfile"), project_home),
  [path("grafana"), path("Tiltfile")],
  tag=image_tag,
  disable_push=True,
)