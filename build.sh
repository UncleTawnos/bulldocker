#!/usr/bin/env bash
set -ex;
pushd $(dirname "$0") > /dev/null;

source config
HUB="quay.io"
NAMESPACE="bulldocker"
REPO=`basename ${1}`

if [[ -z "${REPO}" ]]; then
    echo "Usage $0 repo"
    exit 1
fi

TAG=${2};
if [[ -z "${TAG}" ]]; then
    TAG="latest";
fi;

image=${HUB}/${NAMESPACE}/${REPO}
cd ${REPO}
docker build -f Dockerfile \
	-t ${image}:${TAG} \
	-t ${image}:latest \
	.;

docker login -u=${DOCKER_USER} -p=${DOCKER_PASS} ${HUB}
docker push ${image}:${TAG}
popd > /dev/null;
exit 0;
