#!/bin/sh

BIN=/app/angel-banner
ARTWORKS=/app/artworks_filtered
CONF_DIR=/conf
ENV_FILE="$CONF_DIR/env"
ARGS_FILE="$CONF_DIR/args"

if [ ! -e "$BIN" ]; then
    echo "error: $BIN not found (has the app been built and /app mounted?)" >&2
    exit 1
fi

if [ ! -x "$BIN" ]; then
    echo "error: $BIN is not executable" >&2
    exit 1
fi

if [ ! -d "$ARTWORKS" ]; then
    echo "error: $ARTWORKS not found (have the artworks been copied and /app mounted?)" >&2
    exit 1
fi

if [ ! -d "$CONF_DIR" ]; then
    echo "error: $CONF_DIR not found (is the config directory mounted?)" >&2
    exit 1
fi

ARTWORKS_DIR="$ARTWORKS"
CACHE_DIR=/data/cache
export ARTWORKS_DIR CACHE_DIR

if [ -f "$ENV_FILE" ]; then
    mode=$(stat -L -f '%Lp' "$ENV_FILE") || exit 1
    if [ $(( 0$mode & 077 )) -ne 0 ]; then
        echo "error: $ENV_FILE has mode $mode; must not be accessible by group or others (chmod 600)" >&2
        exit 1
    fi

    set -a
    . "$ENV_FILE"
    set +a
fi

ARGS=
if [ -f "$ARGS_FILE" ]; then
    ARGS=$(cat "$ARGS_FILE")
fi

set -f
exec "$BIN" $ARGS
