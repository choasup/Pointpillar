# From https://github.com/ufoym/deepo/blob/master/docker/Dockerfile.pytorch-py36-cu90

# ==================================================================
# module list
# ------------------------------------------------------------------
# python        3.6    (apt)
# pytorch       latest (pip)
# ==================================================================

FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

ENV http_proxy=10.0.3.12:8118
ENV https_proxy=10.0.3.12:8118

RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \
    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get -o Acquire::http::proxy="http://10.0.3.12:8118" update
# ==================================================================
# tools
# ------------------------------------------------------------------
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -o Acquire::http::proxy="http://10.0.3.12:8118" \
        build-essential \
        ca-certificates \
        cmake \
        wget \
        git \
        vim \
        fish \
        libsparsehash-dev
# ==================================================================
# python
# ------------------------------------------------------------------
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -o Acquire::http::proxy="http://10.0.3.12:8118" software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get -o Acquire::http::proxy="http://10.0.3.12:8118" update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -o Acquire::http::proxy="http://10.0.3.12:8118" \
        python3.6 \
        python3.6-dev

RUN wget -O ~/get-pip.py \
        https://bootstrap.pypa.io/get-pip.py && \
    python3.6 ~/get-pip.py && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python

RUN pip3 install setuptools

RUN pip3 install \
        numpy \
        scipy \
        matplotlib \
        Cython

# ==================================================================
# pytorch
# ------------------------------------------------------------------
RUN pip3 install torch torchvision
    #$PIP_INSTALL \
    #     https://download.pytorch.org/whl/cu80/torch-1.0.0-cp36-cp36m-linux_x86_64.whl \
    #     && \
    #$PIP_INSTALL \
    #     torchvision \
    #     && \

# ==================================================================
# config & cleanup
# ------------------------------------------------------------------
RUN ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

RUN PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    pip3 install \
        shapely fire pybind11 tensorboardX protobuf \
        scikit-image numba==0.42.0 pillow easydict ipython

#  OPENCV
#RUN apt-get install python-opencv
RUN pip3 install opencv-python
RUN apt-get -o Acquire::http::proxy="http://10.0.3.12:8118" update
RUN apt-get -o Acquire::http::proxy="http://10.0.3.12:8118" install -y libsm6 libxext6 libxrender1 libfontconfig1

WORKDIR /root
RUN wget https://dl.bintray.com/boostorg/release/1.68.0/source/boost_1_68_0.tar.gz
RUN tar xzvf boost_1_68_0.tar.gz
RUN cp -r ./boost_1_68_0/boost /usr/include
RUN rm -rf ./boost_1_68_0
RUN rm -rf ./boost_1_68_0.tar.gz

RUN wget https://github.com/google/protobuf/releases/download/v3.6.1/protobuf-all-3.6.1.tar.gz 
RUN tar zxvf protobuf-all-3.6.1.tar.gz
RUN cd protobuf-3.6.1 && ./configure && make && make install

RUN rm -rf ./protobuf-all-3.6.1.tar.gz
RUN rm -rf ./protobuf-3.6.1

RUN git clone https://github.com/traveller59/SparseConvNet.git --depth 10
RUN cd ./SparseConvNet && python setup.py install && cd .. && rm -rf SparseConvNet
ENV NUMBAPRO_CUDA_DRIVER=/usr/lib/x86_64-linux-gnu/libcuda.so
ENV NUMBAPRO_NVVM=/usr/local/cuda/nvvm/lib64/libnvvm.so
ENV NUMBAPRO_LIBDEVICE=/usr/local/cuda/nvvm/libdevice
ENV LD_LIBRARY_PATH=/usr/local/lib
ENV PYTHONDONTWRITEBYTECODE=x

RUN apt-get -o Acquire::http::proxy="http://10.0.3.12:8118" update
RUN pip3 install llvmlite==0.27.1
