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

third_src_dir=/dev/null
third_dst_dir=/dev/null
if [more_mounts=y]
then
    echo "Enter host directory to mount: "
    read third_src_dir 
    echo "Enter container directory to mount to: "
    read third_dst_dir
fi

# TODO: check if dirs exist and offer to create them 

docker service create \
    --name enigma-jack-test \
    --replicas 1 \
    --reserve-cpu 8 \
    --reserve-memory 16g \
    --mode replicated \
    --restart-condition none \
    --mount type=bind,source=$INPUT_DIR,destination=/data,readonly=false \
    --mount type=bind,source=$OUTPUT_DIR,destination=/output \
    --mount type=bind,source=$third_src_dir,destination=$third_dst_dir \
    --publish 6377:6377 \
    jackgray/enigma:latest
