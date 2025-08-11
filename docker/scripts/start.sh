#!/bin/bash

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

CONTAINER_NAME="ros-humble-realsense-rtabmap"
SLEEP_DURATION=3

trap "echo -e \"\n${RED}Stop by signal${NC}\"; exit 1" SIGINT SIGTERM

echo -e "${GREEN}Launching RealSense camera...${NC}"
ros2 launch realsense2_camera rs_launch.py \
    align_depth.enable:=true \
    depth_module.profile:=640x480x30 \
    rgb_camera.profile:=640x480x30 &

echo -e "${GREEN}Waiting ${SLEEP_DURATION} seconds for camera to initialize...${NC}"
sleep $SLEEP_DURATION

echo -e "${GREEN}Launching RTAB-Map...${NC}"
ros2 launch rtabmap_launch rtabmap.launch.py \
    rgb_topic:=/camera/camera/color/image_raw \
    depth_topic:=/camera/camera/aligned_depth_to_color/image_raw \
    camera_info_topic:=/camera/camera/color/camera_info \
    approx_sync:=false \
    frame_id:=camera_link &

wait
