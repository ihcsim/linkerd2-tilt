# -*- mode: Python -*-

trigger_mode(TRIGGER_MODE_MANUAL)
load("./bin/_tilt", "images", "linkerd_yaml", "settings")

if settings.get("default_registry"):
  default_registry(settings.get("default_registry"))

if settings.get("allow_k8s_context"):
  allow_k8s_contexts(settings.get("allow_k8s_contexts"))

k8s_yaml(linkerd_yaml())

for image in images:
  if "live_update" in image:
    sync_from = image["live_update"]["sync"]["from"]
    sync_to = image["live_update"]["sync"]["to"]

    custom_build(
      image["image"],
      "ACTUAL_REF=$(./bin/docker-build-%s) && docker tag $ACTUAL_REF $EXPECTED_REF" % image["name"],
      image["deps"],
      live_update=[
        sync(sync_from, sync_to),
      ],
    )
  else:
    custom_build(
      image["image"],
      "ACTUAL_REF=$(./bin/docker-build-%s) && docker tag $ACTUAL_REF $EXPECTED_REF" % image["name"],
      image["deps"],
    )
