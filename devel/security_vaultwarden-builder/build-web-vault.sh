#!/bin/sh
set -eu

VERSION=${1:?}
URL="https://github.com/dani-garcia/bw_web_builds/releases/download/${VERSION}/bw_web_${VERSION}.tar.gz"

fetch -o /tmp/bw_web.tar.gz "$URL"
rm -rf /app/web-vault
tar -xzf /tmp/bw_web.tar.gz -C /app
