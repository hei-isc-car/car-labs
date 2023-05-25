#!/bin/bash

base_directory="$(dirname "$(readlink -f "$0")")"
pushd $base_directory

SEPARATOR='--------------------------------------------------------------------------------'
INDENT='  '

echo "$SEPARATOR"
echo "-- ${0##*/} Started!"
echo ""

echo "$SEPARATOR"
echo ""
echo "-- Uncompression Test..."
time unzip -o 42.zip

echo "$SEPARATOR"
echo "-- Compression Test..."
time zip -o 42.zip 42.txt

echo ""
echo "-- ${0##*/} Finished!"
echo "$SEPARATOR"
popd

exit 0