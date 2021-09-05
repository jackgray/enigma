FROM ubuntu:latest 
# TODO: nested builds

ENV ENIGMA_VERSION='1.1.3'
# figure out what this ^ variable is
# ^ ?
ENV XNAT_HOST=https://xnat.nyspi.org

RUN apt-get update && \ 
    apt-get -y upgrade && \
    apt-get -y install \
               wget \
               git \
               python3 \
               python3-pip \
               python3-setuptools \
               python3-wheel && \
    mkdir /output

# Install enigma toolbox 
RUN python3 -m pip install vtk
RUN cd /usr/local/src && \
    git clone https://github.com/MICA-MNI/ENIGMA.git && \
    cd /usr/local/src/ENIGMA && \
    git checkout -f tags/$ENIGMA_VERSION && \
    cd /usr/local/src/ENIGMA && \
    python3 -m pip install . && \
    python3 setup.py install

ENV PATH=/opt/enigma/bin:/usr/local/src:$PATH 
WORKDIR /

# Link cache and added libraries
RUN ldconfig

