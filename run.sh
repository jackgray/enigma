#!/bin/bash

echo "************* ENTERING CONFIGURATION ****************"
echo ''
echo "Enter input directory to mount: "
read INPUT_DIR 
echo ''
echo "Enter output directory to mount: "
read OUTPUT_DIR 
echo "Do you have any more directories to mount? (y/n): "
read more_mounts

third_mnt_host_dir=/dev/null
third_mnt_cont_dir=/opt/misc_volume_mnt
if [more_mounts=y]
then
    echo "Enter host directory to mount: "
    read third_mnt_host_dir 
    echo "Enter container directory to mount to: "
    read third_mount_cont_dir
fi

# TODO: check if dirs exist and offer to create them 

docker run -it \
    --name enigma_test
    --mount type=bind,source="$INPUT_DIR",target=/opt/input
    --mount type=bind,source="$OUTPUT_DIR",target=/opt/output
    --mount type=bind,source="$third_mnt_host_dir",target=$third_mnt_cont_dir
    -rm 
    enigma:latest
    