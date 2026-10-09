#!/bin/sh
set -eu

VERSION=${1:?}
REPO=/root/vw_web_builds

if [ ! -d "$REPO/.git" ]; then
    git clone --depth 1 --branch "$VERSION" https://github.com/vaultwarden/vw_web_builds.git "$REPO"
else
    git -C "$REPO" fetch --depth 1 origin tag "$VERSION"
    git -C "$REPO" checkout --detach FETCH_HEAD
fi

npm ci --prefix "$REPO" --cache /root/npm
npm run dist:oss:selfhost --prefix "$REPO/apps/web"
cp -a "$REPO/apps/web/build" /app/web-vault
