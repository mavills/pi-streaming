#!/bin/bash

set -e
set -o pipefail

echo "Updating system packages..."
sudo apt-get update && sudo apt-get upgrade -y

echo "Installing dependencies..."
sudo apt-get install -y git cmake gstreamer1.0-tools libgstreamer1.0-dev \
  libgstreamer-plugins-base1.0-dev gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
  gstreamer1.0-libav libssl-dev libcurl4-openssl-dev liblog4cplus-dev

echo "Cloning Kinesis Video Streams Producer SDK..."
git clone https://github.com/awslabs/amazon-kinesis-video-streams-producer-sdk-cpp.git
cd amazon-kinesis-video-streams-producer-sdk-cpp

echo "Building the SDK..."
mkdir build
cd build
cmake ..
make

echo "SDK build complete."
