This is a Dockerfile that sets up an Ubuntu 20.04 AArch64 image, containing
an installed version of Arm Compiler for HPC and Arm Instruction Emulator.

======
Usage:
======
- Add a valid license to the licenses directory
- <host> $ make clean
- <host> $ make interactive
- <container> $ module avail
-------------------------------------------------------------------------- /usr/share/modules/modulefiles ---------------------------------------------------------------------------
dot  module-git  module-info  modules  null  use.own

------------------------------------------------------------------------------- /opt/arm/modulefiles --------------------------------------------------------------------------------
acfl/22.0.1  binutils/11.2.0  forge/22.0.1  gnu/11.2.0
- <container> $ module load acfl
- <container> $ module load forge

=======================
How to access your code
=======================
- The docker command envoked by 'make interactive' automatically mounts this
repository as /code , from within the container.
- Further code repositoies on the host can be mounted on the container by adding
'-v /full/native/path':'/container/path'


Feedback
--------
This dockerfile isn't an official Arm product, but I'm interested to know if
it's useful to you, or if you have any issues with it.
Drop me a line at will <dot> lovett <at> arm <dot> com

You can find our official documentation at https://developer.arm.com/hpc

Thanks! (Will Lovett)
