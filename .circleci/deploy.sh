#!/bin/bash

# Exit on any error
set -e

jekyll build
mkdir -p google-cloud-sdk
curl -sSL https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz | tar xz -C google-cloud-sdk --strip-components 1
(
  cd google-cloud-sdk
 ./install.sh --usage-reporting false --path-update true
)
gcloud=google-cloud-sdk/bin/gcloud
gsutil=google-cloud-sdk/bin/gsutil

$gcloud --quiet components update
echo "$GCLOUD_SERVICE_KEY" | base64 --decode -i > "${HOME}"/gcloud-service-key.json
$gcloud config set project "$PROJECT_NAME"
$gcloud config set pass_credentials_to_gsutil True
$gcloud config set compute/zone "${CLOUDSDK_COMPUTE_ZONE}"
$gcloud auth activate-service-account --key-file "${HOME}"/gcloud-service-key.json
$gsutil cp -a public-read -r _site/* "${BUCKET}" 
