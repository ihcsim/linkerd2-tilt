LINKERD_NAMESPACE ?= linkerd
LINKERD_VERSION ?= edge-19.4.4
SKAFFOLD_YAML ?= skaffold.yaml
SKAFFOLD_WATCH_POLL_INTERVAL ?= 5000
SKAFFOLD_PROFILE ?= proxy-injector
MANIFEST_FOLDER = k8s

.PHONY: linkerd
linkerd:
	linkerd install --proxy-auto-inject --ignore-cluster --linkerd-namespace=${LINKERD_NAMESPACE} | kubectl apply -f -

sync:
	for component in controller proxy-injector identity web grafana ; do \
		kubectl -n ${LINKERD_NAMESPACE} get deploy linkerd-$${component} -o yaml > ${MANIFEST_FOLDER}/$${component}.yaml ; \
		image=$${component} ; \
		if [ $${image} = proxy-injector ] || [ $${image} = identity ] ; then \
			image=controller ; \
		fi ; \
		sed -i "s|gcr.io/linkerd-io/$${image}:${LINKERD_VERSION}|gcr.io/linkerd-io/$${image}|g" ${MANIFEST_FOLDER}/$${component}.yaml ; \
	done

sync-all:
	kubectl -n ${LINKERD_NAMESPACE} get deploy $${resource} -o yaml > ${MANIFEST_FOLDER}/$${component}.yaml
	sed -i \
		-e 's|gcr.io/linkerd-io/controller:${LINKERD_VERSION}|gcr.io/linkerd-io/controller|g' \
		-e 's|gcr.io/linkerd-io/proxy-init:${LINKERD_VERSION}|gcr.io/linkerd-io/proxy-init|g' \
		-e 's|gcr.io/linkerd-io/web:${LINKERD_VERSION}|gcr.io/linkerd-io/web|g' \
		-e 's|gcr.io/linkerd-io/grafana:${LINKERD_VERSION}|gcr.io/linkerd-io/grafana|g' \
		${MANIFEST_FOLDER}/$${component}.yaml

no-push:
	skaffold config set --global local-cluster true

skaffold-build:
	@eval $$(minikube docker-env) ; \
	skaffold build --filename ${SKAFFOLD_YAML} --profile all

skaffold-deploy:
	@eval $$(minikube docker-env) ; \
	skaffold deploy --filename ${SKAFFOLD_YAML} --profile all

skaffold-dev:
	@eval $$(minikube docker-env) ; \
	skaffold dev --filename ${SKAFFOLD_YAML} --profile ${SKAFFOLD_PROFILE} --watch-poll-interval ${SKAFFOLD_WATCH_POLL_INTERVAL}

skaffold-run:
	@eval $$(minikube docker-env) ; \
	skaffold run --filename ${SKAFFOLD_YAML} --profile ${SKAFFOLD_PROFILE}
