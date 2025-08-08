FROM taylorabarnes/devenv

ENV DEBIAN_FRONTEND=noninteractive

# This suppresses some harmless errors when running mpich
ENV HWLOC_HIDE_ERRORS=2

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
               g++ \
	       libmpich-dev \
               make \
               mpich \
               python3 \
               python3-dev \
               python3-pip && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/*

# Symlink python3 to python
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN pip3 install "pybind11[global]"



RUN apt-get clean && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
                       bzip2 && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/*

ENV MAMBA_ROOT_PREFIX=/opt/conda
ENV PATH=$MAMBA_ROOT_PREFIX/bin:$PATH

# Create target directory and download micromamba
RUN mkdir -p $MAMBA_ROOT_PREFIX/bin && \
    curl -L https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj -C $MAMBA_ROOT_PREFIX/bin/ --strip-components=1 bin/micromamba

# Initialize micromamba and create default environment
RUN micromamba shell init -s bash && \
    micromamba create -y -p $MAMBA_ROOT_PREFIX/base python=3.11


