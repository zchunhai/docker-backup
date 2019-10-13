#!/usr/bin/env bash
set -e

if [ "$#" -gt 0 ]; then
    base_dir=$1
else
    base_dir=$(pwd)/images
fi

for image in `find $base_dir -type f`
do
    set -o xtrace
    docker load -i $image
    set +o xtrace
done
