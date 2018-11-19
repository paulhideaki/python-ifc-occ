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

# build pythonocc
WORKDIR /tmp
RUN git clone git://github.com/tpaviot/pythonocc-core.git
WORKDIR /tmp/pythonocc-core
RUN mkdir cmake-build
WORKDIR /tmp/pythonocc-core/cmake-build
RUN sed -e '/find_package(PythonInterp)/ s/^#*/# /' -i /tmp/pythonocc-core/CMakeLists.txt
RUN sed '/# find_package(PythonInterp)/a\find_package(PythonInterp 3)' -i /tmp/pythonocc-core/CMakeLists.txt

RUN sed -e '/find_package(PythonInterp)/ s/^#*/# /' -i /tmp/pythonocc-core/CMakeLists.txt
RUN sed '/# find_package(PythonLibs)/a\find_package(PythonLibs 3)' -i /tmp/pythonocc-core/CMakeLists.txt

RUN apt-get install -y libfreetype6-dev swig3.0
RUN cmake ..
RUN make -j
RUN make install

#RUN apt-get install -y python-swiglpk

# build opencollada
WORKDIR /tmp
RUN apt-get install -y libpcre3-dev libxml2-dev
RUN git clone https://github.com/KhronosGroup/OpenCOLLADA.git
WORKDIR  /tmp/OpenCOLLADA
RUN git checkout 064a60b65c2c31b94f013820856bc84fb1937cc6
RUN mkdir build
WORKDIR /tmp/OpenCOLLADA/build
RUN cmake ..
RUN make -j
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
RUN apt-get install -y python3-pyqt5 python3-pyqt5.qtopengl
RUN apt-get install -y python3-numpy python3-shapely sqlite3
RUN apt-get install -y python3-pip
RUN useradd -ms /bin/bash xterm
USER xterm

WORKDIR /home/xterm
