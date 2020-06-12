FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y \
        git \
        vim \
        gnuplot \
        curl \
        build-essential \
        gcc \
        gfortran \
        openmpi-doc \
        openmpi-bin \
        libopenmpi-dev \
        libopenblas-dev \
        liblapack-dev \
        xsltproc \
        perl \
        openssl \
        libssl-dev \
        libreadline-dev \
        ncurses-dev \
        bzip2 \
        zlib1g-dev \
        libbz2-dev \
        libffi-dev \
        libsqlite3-dev \
        liblzma-dev \
        libpng-dev \
        libfreetype6-dev

WORKDIR /usr/local/src

## exciting installation
RUN curl http://exciting.wdfiles.com/local--files/nitrogen/exciting.nitrogen.tar.gz -O -L
RUN tar xvf exciting.nitrogen.tar.gz \
    && rm -rf exciting.nitrogen.tar.gz
COPY res/make.inc ./exciting/build
RUN cd exciting/ && make
ENV EXCITINGROOT /usr/local/src/exciting
ENV PATH $PATH:$EXCITINGROOT/bin

## Python installation
RUN curl https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz -O -L \
    && tar zxf Python-3.8.0.tgz \
    && rm -rf Python-3.8.0.tgz \
    && cd Python-3.8.0 \
    && ./configure \
    && make \
    && make altinstall \
    && ln -s /usr/local/bin/python3.8 /usr/bin/python \
    && ln -s /usr/local/bin/pip3.8 /usr/bin/pip
ENV PYTHONIOENCODING "utf-8"
RUN pip install pip -U \
    && pip install \
        numpy \
        scipy \
        matplotlib \
        sympy \
        pandas \
        tqdm \
        Pillow \
        ase \
        joblib \
        Cython

WORKDIR /root
