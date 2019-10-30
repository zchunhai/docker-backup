#!/usr/bin/env bash
set -e

if [ "$#" -gt 0 ]; then
    base_dir=$1
else
    base_dir=$(pwd)/images
fi

length=${#base_dir}
last_char=${base_dir:length-1:1}
[[ $length > 0 ]] && [[ $last_char != "/" ]] && base_dir="$base_dir/"; :

backup_image ()
{
    image=$1
    image_partials=($(echo $image | tr ":" "\n"))
    image_dir=$base_dir$(dirname "${image_partials[0]}")
    image_name=$(basename "${image_partials[0]}")
    dest_file=$image_dir/${image_name}_${image_partials[1]}
    mkdir -p $image_dir

    if [ ! -f $dest_file ]; then
        set -o xtrace
        docker save -o $dest_file $image
        set +o xtrace
    fi
}

for image in `docker images --format {{.Repository}}:{{.Tag}}`
do
    backup_image $image
done
