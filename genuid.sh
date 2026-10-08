#!/bin/sh
# usage: genuid.sh <template path>
#
#   $ ./genuid.sh www/pocket-id-bin
#
# Prints a number between 2000 and 9999 derived from the string for service UID

if [ -z "$1" ]; then
    echo "usage: $0 <string>" >&2
    exit 1
fi

hash=$(printf '%s' "$1" | cksum | cut -d' ' -f1)
echo $(( hash % 8000 + 2000 ))
