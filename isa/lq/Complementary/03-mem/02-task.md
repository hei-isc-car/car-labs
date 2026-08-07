---
id          = "extra-mem"
name        = "Memory"
language    = "riscv"
difficulty  = 1
description = "Load and manipulate data in memory."
topics      = ["memory", "lw", "sw", "signed-values"]
---

## Tasks

1. Read and write data to memory using lw and sw.
2. Keep operations aligned with C snippet intent:
```c
  uint16_t a = mem[4];
  mem[3] = a;
  uint16_t b = mem[3];

  int16_t c = mem[4];
  mem[5] = c;
  int16_t d = mem[5];
```
