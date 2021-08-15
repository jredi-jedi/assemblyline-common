PROJECT:=cccs
REPOSRC:=https://github.com/CybercentreCanada
REPOTAG:=master
REPODOCKER:=eu.gcr.io
CONTAINERS=assemblyline assemblyline-core assemblyline-socketio assemblyline-ui assemblyline-ui-frontend assemblyline-service-server
.PHONY: ${CONTAINERS}
containers: ${CONTAINERS}
	for f in $^; do docker build --build-arg PROJECT="${PROJECT}" --build-arg REPOSRC="${REPOSRC}" --build-arg REPOTAG="${REPOTAG}" -t "${PROJECT}/$$f" -t "${REPODOCKER}/${PROJECT}/$$f" -f deployments/$$f .; done
deploy: ${CONTAINERS}
	for f in $^; do docker push "${REPODOCKER}/${PROJECT}/$$f" ; done
