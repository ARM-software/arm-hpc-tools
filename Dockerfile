FROM aarch64/ubuntu:16.04 as builder

USER root

# Install pre reqs
RUN apt-get update && apt-get install -y \
      environment-modules \
      nano \
      vim \
      unzip \
      less \
      wget \
      python \
      python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN bash -c "wget https://armkeil.blob.core.windows.net/developer/Files/downloads/hpc/arm-allinea-studio/19-0/Ubuntu16.04/arm-forge-18.3-Ubuntu-16.04-aarch64.tar && tar xf arm-forge-18.3-Ubuntu-16.04-aarch64.tar && arm-forge-18.3-Ubuntu-16.04-aarch64/textinstall.sh --accept-licence /opt/arm/Forge-18.3"

RUN bash -c "wget https://armkeil.blob.core.windows.net/developer/Files/downloads/hpc/arm-allinea-studio/19-0/Ubuntu16.04/arm-reports-18.3-Ubuntu-16.04-aarch64.tar && tar xf arm-reports-18.3-Ubuntu-16.04-aarch64.tar && ./arm-reports-18.3-Ubuntu-16.04-aarch64/textinstall.sh --accept-licence /opt/arm/Reports-18.3"

RUN bash -c "wget https://armkeil.blob.core.windows.net/developer/Files/downloads/hpc/arm-instruction-emulator/18-4/ARM-Instruction-Emulator_18.4_AArch64_Ubuntu_16.04_aarch64.tar.gz && tar xf ARM-Instruction-Emulator_18.4_AArch64_Ubuntu_16.04_aarch64.tar.gz && ./ARM-Instruction-Emulator_18.4_AArch64_Ubuntu_16.04_aarch64/arm-instruction-emulator-18.4_Generic-AArch64_Ubuntu-16.04_aarch64-linux-deb.sh --accept"

RUN bash -c "wget https://developer.arm.com/-/media/Files/downloads/hpc/arm-allinea-studio/19-0/Ubuntu16.04/Arm-Compiler-for-HPC.19.0_Ubuntu_16.04_aarch64.tar && tar xf Arm-Compiler-for-HPC.19.0_Ubuntu_16.04_aarch64.tar && ./ARM-Compiler-for-HPC*/*.sh --accept; rm -rf /tmp/*"

# By rebuilding the image from scratch,  and copying in the result
# we save image size
FROM aarch64/ubuntu:16.04
COPY --from=builder / /

RUN useradd -ms /bin/bash test_user
USER test_user
#ENV PATH="/opt/arm/licenceserver/bin/:${PATH}"
ENV MODULEPATH /opt/arm/modulefiles
WORKDIR /home/test_user

CMD ["bash", "-l"]

