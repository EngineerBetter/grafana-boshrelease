#!/usr/bin/env bash

set -e

grafana_tag=$(cat grafana-binary-version/tag)
grafana_version=${grafana_tag:1}

wget "https://dl.grafana.com/oss/release/grafana-${grafana_version}.linux-amd64.tar.gz"

cd grafana-boshrelease

cat >> config/private.yml <<EOF
---
blobstore:
  provider: s3
  options:
    credentials_source: env_or_profile
EOF

bosh add-blob "../grafana-${grafana_version}.linux-amd64.tar.gz" grafana/grafana.tar.gz

bosh upload-blobs

status="$(git status --porcelain)"
if [ -n "$status" ]; then
  git config --global user.email "ci@localhost"
  git config --global user.name "CI Bot"
  git add -A
  git commit -m "Updating grafana blob"
fi
