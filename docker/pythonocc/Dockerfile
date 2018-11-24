# Dockerfile
FROM paulhideaki/oce:0.1
MAINTAINER "paulhideaki"

RUN apt-get update
RUN apt-get update && apt-get update -y

RUN apt-get install -y python3-pyqt5 python3-pyqt5.qtopengl

# build pythonocc
WORKDIR /tmp
RUN git clone git://github.com/tpaviot/pythonocc-core.git
WORKDIR /tmp/pythonocc-core
RUN mkdir cmake-build
WORKDIR /tmp/pythonocc-core/cmake-build
RUN sed -e '/find_package(PythonInterp)/ s/^#*/# /' -i /tmp/pythonocc-core/CMakeLists.txt
RUN sed '/# find_package(PythonInterp)/a\find_package(PythonInterp 3)' -i /tmp/pythonocc-core/CMakeLists.txt
RUN sed -e '/find_package(PythonLibs)/ s/^#*/# /' -i /tmp/pythonocc-core/CMakeLists.txt
RUN sed '/# find_package(PythonLibs)/a\find_package(PythonLibs 3)' -i /tmp/pythonocc-core/CMakeLists.txt
RUN apt-get install -y libfreetype6-dev swig3.0
RUN cmake ..
RUN make -j3
RUN make install

# build pythonocc-utils
WORKDIR /tmp
RUN git clone https://github.com/tpaviot/pythonocc-utils.git
WORKDIR /tmp/pythonocc-utils
RUN python3 setup.py install
