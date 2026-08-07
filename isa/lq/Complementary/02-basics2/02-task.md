---
id          = "extra-b-imm-02"
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
  int b = 2;
  int c = 3;
  int e = -1;
  int f = -78;
  int g = 2023;
  int h = -12;
  a = b - c;
  d = (e + f) - (g + h);
```
