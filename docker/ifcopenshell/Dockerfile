# Dockerfile
FROM  paulhideaki/pythonocc:0.1
MAINTAINER "paulhideaki"

RUN apt-get update
RUN apt-get update && apt-get update -y

# build opencollada
WORKDIR /tmp
RUN apt-get install -y libpcre3-dev libxml2-dev
RUN git clone https://github.com/KhronosGroup/OpenCOLLADA.git
WORKDIR  /tmp/OpenCOLLADA
RUN git checkout 064a60b65c2c31b94f013820856bc84fb1937cc6
RUN mkdir build
WORKDIR /tmp/OpenCOLLADA/build
RUN cmake ..
RUN make -j3
RUN make install

# build IfcOpenShell
WORKDIR /tmp
RUN apt-get install -y git cmake gcc g++ libboost-all-dev libicu-dev
RUN git clone https://github.com/IfcOpenShell/IfcOpenShell.git
WORKDIR /tmp/IfcOpenShell
RUN mkdir build
WORKDIR /tmp/IfcOpenShell/build
RUN cmake ../cmake -DOCC_LIBRARY_DIR=/usr/local/lib -DOCC_INCLUDE_DIR=/usr/local/include/oce \
      -DOPENCOLLADA_INCLUDE_DIR="/usr/local/include/opencollada" \
      -DOPENCOLLADA_LIBRARY_DIR="/usr/local/lib/opencollada"  \
      -DPCRE_LIBRARY_DIR=/usr/lib/x86_64-linux-gnu/
RUN make install

RUN apt-get install -y xterm
RUN apt-get install -y python3-pip
RUN apt-get install -y sqlite3

RUN pip3 install matplotlib
RUN pip3 install numpy
RUN pip3 install shapely
RUN pip3 install svglib
RUN pip3 install descartes
RUN pip3 install svgpathtools

RUN useradd -ms /bin/bash xterm

USER xterm

WORKDIR /home/xterm
