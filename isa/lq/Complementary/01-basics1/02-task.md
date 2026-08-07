---
id          = "extra-b-imm-01"
name        = "Immediates"
language    = "riscv"
difficulty  = 1
description = "Load and manipulate small signed constants."
topics      = ["immediates", "addi", "signed-values"]
---

## Tasks

1. Initialize variables with small immediate values.
2. Perform addition and subtraction using addi.
3. Represent negative values correctly in registers.
4. Keep operations aligned with C snippet intent:
```c
  int b = 1;
  int c = 2;
  a = b + c;

  int d = -1;
  int e = 2;
  f = d + e;

  int g = -12;
  int h = 2023;
  i = g + h;
```
