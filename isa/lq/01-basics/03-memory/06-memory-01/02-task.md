---
id          = "b-mem"
name        = "Word Array Addressing and Alignment"
language    = "riscv"
difficulty  = 3
description = "Practice load/store on word arrays with correct byte offsets and alignment rules."
topics      = ["memory", "alignment", "load-store", "addressing"]
---

# Word Array Addressing and Alignment

## Tasks

1. Read mem[0] and mem[3] with correct offsets.
2. Write 42 to mem[5] and read it back.
3. Understand why lw with offset 3 is misaligned and invalid.
4. Keep operations aligned with C snippet intent:
```c
  # We have an array of int, i.e., multiple ints one after the other in memory such as [int0][int1][int2] ...
  # The notation mem[x] means getting the x th element of that array
  addi a0, x0, 0x88 # Init memory pointer
  addi t0, x0, 10 # Init value
  sb t0, 1(a0) # Write subpart of mem[0]
  sb t0, 10(a0) # Write subpart of mem[3]
  # ...
  int a = mem[0];
  int b = mem[3];
  mem[5] = 42;
  int c = mem[5];
```
