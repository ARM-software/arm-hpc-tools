FROM arm64v8/ubuntu:18.04 as builder

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
RUN bash -c "wget -q -O- https://developer.arm.com/-/media/Files/downloads/hpc/arm-allinea-studio/19-1/Ubuntu16.04/arm-forge-19.0.3-Ubuntu-16.04-aarch64.tar | tar x && arm-forge-*-Ubuntu-16.04-aarch64/textinstall.sh --accept-licence /opt/arm/forge/19.0.3"

# Performance Reports
RUN bash -c "wget -q -O- https://developer.arm.com/-/media/Files/downloads/hpc/arm-allinea-studio/19-1/Ubuntu16.04/arm-reports-19.0.3-Ubuntu-16.04-aarch64.tar | tar x && ./arm-reports-*-Ubuntu-16.04-aarch64/textinstall.sh --accept-licence /opt/arm/perf-reports/19.0.3"

# Instruction Emulator
RUN bash -c "wget -q -O- https://armkeil.blob.core.windows.net/developer/Files/downloads/hpc/arm-instruction-emulator/18-4/ARM-Instruction-Emulator_18.4_AArch64_Ubuntu_16.04_aarch64.tar.gz | tar zx && ./ARM-Instruction-Emulator_18.4_AArch64_Ubuntu_16.04_aarch64/arm-instruction-emulator-18.4_Generic-AArch64_Ubuntu-16.04_aarch64-linux-deb.sh --accept"

# Compiler (and cleanup)
RUN bash -c "wget -q -O- https://developer.arm.com/-/media/Files/downloads/hpc/arm-allinea-studio/19-1/Ubuntu16.04/Arm-Compiler-for-HPC_19.1_Ubuntu_16.04_aarch64.tar | tar x && ./ARM-Compiler-for-HPC*/*.sh --accept; rm -rf /tmp/*"

# Setup modules
RUN echo "/opt/arm/modulefiles" >> /usr/share/modules/init/.modulespath
COPY modulefiles /opt/arm/modulefiles/

# By rebuilding the image from scratch, and copying in the result
# we save image size
FROM arm64v8/ubuntu:18.04
COPY --from=builder / /

RUN useradd -ms /bin/bash user
USER user
WORKDIR /home/user

CMD ["bash", "-l"]

