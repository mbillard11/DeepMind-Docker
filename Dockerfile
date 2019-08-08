# DeepMind Labs Dockerfile

#
# Start with Ubuntu
#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:18.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

# Create and set the working directory
WORKDIR /mylab

#
# Install Bazel
#

# Install packages required by Bazel
RUN apt-get install pkg-config zip g++ zlib1g-dev python3

# Get binary installer
COPY /bazel-0.28.1-installer-linux-x86_64.sh /mylab/ 

# Run Bazel installer
RUN chmod +x bazel-0.28.1-installer-linux-x86_64.sh
RUN ./bazel-0.28.1-installer-linux-x86_64.sh --user
RUN echo 'export PATH="$PATH:$HOME/bin"' >> ~/.bashrc

# Install JDK
RUN apt-get install openjdk-11-jdk

#
# Getting DeepMind Lab
#

# Start with dependancies
RUN apt-get update && apt-get install -y \
  lua5.1 \
  liblua5.1-0-dev \
  libffi-dev \
  gettext \
  freeglut3-dev \
  libsdl2-dev \
  libosmesa6-dev \
  python3-dev \
  python3-numpy \
  realpath \
  build-essential

# Clone Deepmind Lab
RUN git clone https://github.com/deepmind/lab
WORKDIR lab
