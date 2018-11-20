# Dockerfile
FROM debian:latest
MAINTAINER "paulhideaki"
RUN apt-get update
RUN apt-get update && apt-get update -y
RUN apt-get install -y vim zsh python-pip python3-pip curl htop screen sharutils git python-numpy python-termcolor build-essential cmake

# build oce
WORKDIR /tmp
RUN git clone git://github.com/tpaviot/oce.git
WORKDIR /tmp/oce
RUN git pull
RUN mkdir build
WORKDIR /tmp/oce/build
RUN apt-get install -y libftgl-dev
RUN cmake ..
RUN make -j3
RUN make install/strip
