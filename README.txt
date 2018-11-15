This is a Dockerfile that sets up an Ubuntu 16.04 AArch64 image, containing
an installed version of Arm Compiler for HPC and Arm Instruction Emulator.

Usage:
- Add a valid license to the licenses directory
- <host> $ make clean
- <host> $ make interactive
- <container> $ module avail
-----------------------------------------------------------------------------------------
/opt/arm/modulefiles
-----------------------------------------------------------------------------------------
Cortex-A72/Ubuntu/16.04/arm-hpc-compiler-19.0/armpl/19.0.0
Generic-AArch64/Ubuntu/16.04/arm-hpc-compiler-19.0/armpl/19.0.0 Generic-AArch64/Ubuntu/16.04/suites/arm-compiler-for-hpc/19.0
Cortex-A72/Ubuntu/16.04/gcc-8.2.0/armpl/19.0.0
Generic-AArch64/Ubuntu/16.04/gcc/8.2.0
ThunderX2CN99/Ubuntu/16.04/arm-hpc-compiler-19.0/armpl/19.0.0
Generic-AArch64/Ubuntu/16.04/arm-hpc-compiler/19.0
Generic-AArch64/Ubuntu/16.04/gcc-8.2.0/armpl/19.0.0
ThunderX2CN99/Ubuntu/16.04/gcc-8.2.0/armpl/19.0.0
- <container> $ module load Generic-AArch64/Ubuntu/16.04/arm-hpc-compiler/19.0

How to access your code
- The docker command envoked by 'make interactive' automatically mounts this
repository as /code , from within the container.
- Further code repositoies on the host can be mounted on the container by adding
'-v /full/native/path':'/container/path'

Feedback
--------
This dockerfile isn't an official Arm product, but I'm interested to know if
it's useful to you, or if you have any issues with it.
Drop me a line at will.lovett@arm.com
Thanks! (Will Lovett)
