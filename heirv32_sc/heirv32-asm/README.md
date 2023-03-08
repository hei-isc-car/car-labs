<h1 align="center">
  <br>
  <img src="./img/heirv32.png" alt="HEIRV32 Logo" width="400">
  <br>
  HEIRV32-assembler
  <br>
</h1>
A [fork](https://github.com/kcelebi/riscv-assembler) from riscv-assembler in Python to help with creating [HEIRV32](https://gitlab.hevs.ch/course/car/car-labs/-/tree/master/hdl) code.
Fixed instructions translation, jumps offsets (forward or backward), support for 0x/0b data format, and support for only known instructions by HEIRV32.
Translate from file or string.
It also creates an HEIRV32 BRAM compatible **.txt** file.
See `tests/tassembly.s` for an example code.

# Support
The following instructions are supported :
- R-type (op rd rs1 rs2)
  - add  : rd = rs1 + rs2
  - sub  : rd = rs1 - rs2
  - slt  : rd = (rs1 < rs2) ? 1:0
  - or   : rd = rs1 | rs2
  - and  : rd = rs1 & rs2
- I-type (op rd rs1 imm), imm on 12 bits
  - addi : rd = rs1 + imm
  - slti : rd = (rs1 < imm) ? 1:0
  - ori  : rd = rs1 | imm
  - andi : rd = rs1 & imm
  - lw (op dest imm(rs1)) : dest = Memory\[rs1 + imm\]
- S-type (op rs2 offs(rs1)), offs on 12 bits
  - sw   : Memory\[rs1 + offs\] = rs2
- B-type (op rs1 rs2 imm]), imm given on 12 bits that will be << 1
  - beq  : if(rs1 == rs2) -> PC += imm
    - *imm can be negative, and in ASM a label can be used*
- J-type (op imm || op rd imm), imm given on 20 bits that will be << 1
  - jal  : rd = PC + 4 (if no rd specified, rd = x1); PC += imm
    - *as B types, labels can be used*
- Pseudo instructions
  - nop       -> addi x0 x0 0
  - mv rd rs1 -> addi rd rs1 0
  - li rd imm -> addi rd x0 imm
  - myLabel:  -> label to use with beq as its immediate value (true immediate is automatically calculated)

Comments are lines beginning with `#`.
Empty lines are removed.
Unknown instructions are replaced by a `nop` instruction.
Raw values (decimal, 0b, 0x) can be put directly in the ASM file (no instruction beforehand). Running the ASM on it will tell you the memory location as needed by lw/sw.
`btns` can be used instead of `x31` in instructions.
`leds` can be used instead of `x30` in instructions.

If called with bin file (in text format, not hex), will disassemble and recreate instructions and transform jumps into labels.

# Changelog
## 1.1.2 - 01.03.2023
### Added
- Engaged ISA is shown on launch
- Pseudo-instructions can now insert and modify the code as needed (e.g. with `li` and a big value, modify itself with `lui` and adds an `addi` instruction)
### Changed
- `-i` switch is now case insensitive
- Better error message when an instruction/value could not be translated
- Disassembly now generates `.s` files
### Fixed
- Bad `U` instruction management (register and immediates were mixed, immediates could be too big)
- Bad `li` management for big values (`U` instructions not working, did not insert new instruction correctly, bad sub-instruction immediate)
- Bad `U` disassembly

## 1.1.1 - 27.02.2023
### Added
- Support for comments anywhere in the end of a line (either glued to the instruction or not)
- x0 can be called zero
### Changed
- Examples.ipynb up-to-date
### Fixed
- Faulty ASM/DISSY detection (input string split was incorrect)

## 1.1.0 - 17.02.2023
### Added
- Disassembler to recreate code from (UTF-8) bin files
### Changed
- Splitted errors, ISA and utils in specific files
### Fixed
- Some opcode names were not standard
- Proposed RV32I ISA was not incorrect (contained RV64I, RV32/RV64 Zifencei/Zicsr and RV32M extensions)

## 1.0.2 - 27.01.2023
### Added
- Synthesis file creation
### Changed
- Instruction printing width follows the max asm line width
### Fixed

## 1.0.1 - 23.11.2022
### Added
- Support for raw data in code
- Instruction printing address
- Versioning in build
### Changed
- Instructions printing layout
### Fixed
- Conversion log order

## 1.0 - Initial release

# Run
With the `make conda-create` followed by `make run`, the required libs are downloaded and the file `encode.py` launched (requires conda).
*For Windows environment, run the `install_win_utilities.ps1` first through powershell (non-admin) before being able to run make*.

You can also open the file `encode.py` with python if you have the required libraries.

Along the python script, example code is given under a Jupyter Notebook format (can be opened with VSCode).

Finally, in the `dist/` folder are builded apps for various platforms. You can launch them as-is (will open a GUI to choose an `asm` file and build bin, BRAM and print instructions), or call it through a command line.

# Tutorial
Select one of your assembler file (**.s**) and the script will build a **.bin** file which can be analyzed with [Ghidra](https://ghidra-sre.org/) or through [JBORZAs disassembler](https://jborza.com/emulation/2021/04/18/riscv-disassembler.html).
It will also create a `myfile_bram.txt` compatible with HEIRV32 (max program length being 2\*\*10 for the multi-cycle version, 2\*\*5 for the single-cycle one).

Or launch it through a command prompt and check the documentation it gives.

# Dev
Use `make build` to create an installer for the architecture and OS you are currently working on, which is output in the `/dist` folder.
It is named automatically based on your CPU Arch. and OS.

# Others
The **tests** folder contains test files generated by HEIRV32-ASM.
