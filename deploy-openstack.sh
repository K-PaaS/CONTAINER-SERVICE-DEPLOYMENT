#!/bin/bash

# SET VARIABLES
export CAAS_DEPLOYMENT_NAME='paasta-container-service'
export CAAS_BOSH2_NAME='micro-bosh'
export CAAS_BOSH2_UUID=`bosh int <(bosh -e ${CAAS_BOSH2_NAME} environment --json) --path=/Tables/0/Rows/0/uuid`

# DEPLOY
bosh -e ${CAAS_BOSH2_NAME} -n -d ${CAAS_DEPLOYMENT_NAME} deploy --no-redact manifests/paasta-container-service-deployment.yml \
    -l manifests/paasta-container-service-openstack-vars.yml \
    -o manifests/ops-files/paasta-container-service/openstack-network.yml \
    -o manifests/ops-files/paasta-container-service/use-compiled-releases.yml \
    -o manifests/ops-files/paasta-container-service/add-private-image-repository-openstack.yml \
    -o manifests/ops-files/iaas/openstack/cloud-provider.yml \
    -o manifests/ops-files/iaas/openstack/master-static-ip.yml \
    -o manifests/ops-files/rename.yml \
    -o manifests/ops-files/misc/single-master.yml \
    -o manifests/ops-files/misc/first-time-deploy.yml \
    -v deployment_name=${CAAS_DEPLOYMENT_NAME} \
    -v director_name=${CAAS_BOSH2_NAME} \
    -v director_uuid=${CAAS_BOSH2_UUID}
