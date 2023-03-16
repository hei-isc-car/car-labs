<h1 align="center">
  <br>
  <img src="./img/CAr_logo.png" alt="CAr Labs Logo" width="200" height="200">
  <br>
  Hevs CAr Laboratories
  <br>
</h1>

<h4 align="center">Labor Files for CAr Laboratories practical sessions <a href="https://cyberlearn.hes-so.ch" target="_blank">Moodle Cyberlearn</a>.</h4>

# Table of contents
<p align="center">
  <a href="#description">Description</a> •
  <a href="#how-to-use">How To Use</a> •
  <a href="#launch">Launch</a> •
  <a href="#credits">Credits</a> •
  <a href="#license">License</a> •
  <a href="#find-us-on">Find us on</a>
</p>

## Description
[(Back to top)](#table-of-contents)

### Documentation
The documentation is available under the [car-docs](https://github.com/hei-isc-car/car-docs) Git repository.

### Moodle
As it changes each year, all you have to do is search on <a href="https://cyberlearn.hes-so.ch" target="_blank">Moodle Cyberlearn</a> for the course and select the one starting with the last two digits of the current year.

Course number:
* YY_HES-SO-VS_Architecture des ordinateurs / Computerarchitektur

### BEM
The objective of the Benchmark (BEM) lab is to compare your own computer to others in the world, as well as those of your classmates. The goal is to get concrete information about the performance of your system.

### ISA
The ISA lab focuses on the RISC-V instruction set architecture:
- Basic assembler (ASM) instructions usage and their opcode translation
- Algorithms and high-level languages constructs translation following established conventions
- Reverse-engineering

### HEIRV32-SC
The HEIRV32-SC (SC standing for Single Cycle) lab is a FPGA implementation of a very simple RISC-V architecture in which the instruction decoder must be completed and timing calculations performed.
A dedicated assembler supporting this reduced architecture is available in the **heirv32-asm** folder.

## How To Use
[(Back to top)](#table-of-contents)

To clone this template, you'll need [Git](https://git-scm.com). You can also opt for the archive version.
[HDL Designer](https://www.mentor.com/products/fpga/hdl_design/hdl_designer_series/), [Modelsim](https://www.mentor.com/products/fv/modelsim/) and [ISE 14.7](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive-ise.html) must be installed on your computer. See the [wiki](https://wiki.hevs.ch/fsi/index.php5/Tools/EDA/Install) for help.

The use of the assembler is explained inside the **heirv32-asm** folder.

Finally, the doc can be found inside the **doc** folder.

### Launch
```bash
# Clone this repository including submodules
git clone <repo_url>

# Go into the repository
cd car-labs

# Run the app
## Linux
./car-labs.bash

## Windows
.\car-labs.bat
```

## Credits
[(Back to top)](#table-of-contents)
* COF
* PRC
* ZAS
* AMA

## License
[(Back to top)](#table-of-contents)

:copyright: [All rights reserved](LICENSE)

---

## Find us on
> [hevs.ch](https://www.hevs.ch) &nbsp;&middot;&nbsp;
> Facebook [@hessovalais](https://www.facebook.com/hessovalais) &nbsp;&middot;&nbsp;
> Twitter [@hessovalais](https://twitter.com/hessovalais) &nbsp;&middot;&nbsp;
> LinkedIn [HES-SO Valais-Wallis](https://www.linkedin.com/groups/104343/) &nbsp;&middot;&nbsp;
> Google+ [HES-SO Valais Wallis](https://plus.google.com/105282401140539059594) &nbsp;&middot;&nbsp;
> Youtube [HES-SO Valais-Wallis](https://www.youtube.com/user/HESSOVS)
