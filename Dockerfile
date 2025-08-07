FROM taylorabarnes/devenv

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
                       g++ \
                       make && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/*
