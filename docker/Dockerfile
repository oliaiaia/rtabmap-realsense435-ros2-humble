ARG ROS_DISTRO=humble
FROM osrf/ros:humble-desktop

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    vim nano \
    lsb-release \
    software-properties-common \
    ros-${ROS_DISTRO}-realsense2-camera \
    ros-${ROS_DISTRO}-rtabmap-ros \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /ros_ws/src
WORKDIR /ros_ws
COPY scripts/start.sh /ros_ws/scripts/start.sh

RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc

# GUI 
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    x11-apps \
    mesa-utils \
    && rm -rf /var/lib/apt/lists/*

CMD ["bash"]

