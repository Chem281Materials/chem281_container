FROM taylorabarnes/devenv

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
                       g++ \
		       make \
		       python3 \
		       python3-dev \
                       python3-pip && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/*

# Symlink python3 to python
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN pip3 install -y "pybind11[global]"
