#!/bin/sh
set -eu

VERSION=${1:?}
REPO=/root/vaultwarden

if [ ! -d "$REPO/.git" ]; then
    git clone --depth 1 --branch "$VERSION" https://github.com/dani-garcia/vaultwarden.git "$REPO"
else
    git -C "$REPO" fetch --depth 1 origin tag "$VERSION"
    git -C "$REPO" checkout --detach FETCH_HEAD
fi

PATH="/tmp/makebin:${PATH}"
export PATH MAKE=gmake VW_VERSION="$VERSION"
export CARGO_HOME=/root/cargo
export RUSTUP_HOME=/usr/local/rustup

cargo build --manifest-path "$REPO/Cargo.toml" --locked --release --features sqlite,postgresql,vendored_openssl
cp "$REPO/target/release/vaultwarden" /app/vaultwarden
