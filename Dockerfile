FROM arm64v8/ubuntu:20.04 as builder

USER root

# Install pre reqs
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update && apt-get install -y \
      psmisc \
      tcl \
      environment-modules \
      nano \
      vim \
      unzip \
      less \
      wget \
      python \
      python3-pip \
      libxext6-dbg \
      libsm-dev \
      libfreetype6-dev \
      libxrender-dev \
      libxrandr-dev \
      libxfixes-dev \
      libxcursor-dev \
      libxinerama-dev \
      libfontconfig-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# Forge
RUN bash -c "wget -q -O- https://content.allinea.com/downloads/arm-forge-22.0.1-linux-aarch64.tar | tar x && arm-forge-*/textinstall.sh --accept-licence /opt/arm/forge/22.0.1; rm -rf /tmp/*"

# Compiler (and cleanup)
RUN bash -c "wget -q -O- https://developer.arm.com/-/media/Files/downloads/hpc/arm-allinea-studio/22-0-1/arm-compiler-for-linux_22.0.1_Ubuntu-20.04_aarch64.tar | tar x && ./arm-compiler-for-linux*/*.sh --accept; rm -rf /tmp/*"

# Setup modules
RUN echo "/opt/arm/modulefiles" >> /usr/share/modules/init/.modulespath
COPY modulefiles /opt/arm/modulefiles/

RUN useradd -ms /bin/bash user
USER user
WORKDIR /home/user

CMD ["bash", "-l"]

