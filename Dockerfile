FROM ubuntu:22.04

# Limit interactivity during build
ENV DEBIAN_FRONTEND=noninteractive

# Prepare system
RUN apt-get update \
    && apt-get install -y \
      git \
      iputils-ping \
      jq  \
      python3 \
      python3-pip \
      yasm \
    && pip install gdb-tools \
    && git clone https://github.com/sleirsgoevy/ps4jb-payloads.git --recursive --recurse-submodules -b bd-jb /kstuff/tool


# Copy source files
COPY src /kstuff/src

# Route image execution to the entrypoint reponsible for executing the command
RUN chmod +x /kstuff/src/entrypoint.sh
ENTRYPOINT ["/kstuff/src/entrypoint.sh"]
