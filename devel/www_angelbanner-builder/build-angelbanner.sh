#!/bin/sh
set -eu

REPO=/root/angelbanner

if [ ! -d "$REPO/.git" ]; then
    git clone --depth 1 --branch master https://github.com/lemniskett/angelbanner.git "$REPO"
else
    git -C "$REPO" fetch --depth 1 origin master
    git -C "$REPO" checkout --detach FETCH_HEAD
fi

export CARGO_HOME=/root/cargo
export RUSTUP_HOME=/usr/local/rustup

cargo build --manifest-path "$REPO/Cargo.toml" --locked --release
cp "$REPO/target/release/angel-banner" /app/angel-banner
rm -rf /app/artworks_filtered
cp -a "$REPO/artworks_filtered" /app/artworks_filtered
