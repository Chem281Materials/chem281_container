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

# Install rust
ENV RUST_VERSION=1.81.0
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain ${RUST_VERSION}
ENV PATH="/root/.cargo/bin:${PATH}"


# Symlink python3 to python
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN pip3 install "pybind11[global]"
