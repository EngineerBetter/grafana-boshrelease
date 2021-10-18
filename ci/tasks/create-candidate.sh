#!/usr/bin/env bash

set -e

export ROOT_PATH=$PWD

cd grafana-boshrelease

bosh create-release --tarball="${ROOT_PATH}/release/grafana-dev-release.tgz" --timestamp-version --force
