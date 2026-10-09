#!/bin/sh
set -eu

REPO=/root/angelbanner

if [ ! -f "$REPO/Cargo.toml" ]; then
    echo "error: $REPO not found (place the angelbanner checkout there)" >&2
    exit 1
fi

export CARGO_HOME=/root/cargo
export RUSTUP_HOME=/usr/local/rustup

cargo build --manifest-path "$REPO/Cargo.toml" --release
cp "$REPO/target/release/angelbanner" /app/angelbanner
rm -rf /app/artworks_filtered
cp -a "$REPO/artworks_filtered" /app/artworks_filtered
