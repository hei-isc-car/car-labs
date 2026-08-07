---
id          = "b-imm-01"
name        = "Immediates"
language    = "riscv"
difficulty  = 1
description = "Use addi to load and manipulate small signed constants."
topics      = ["immediates", "addi", "signed-values"]
---

# Signed Immediates with addi

## Tasks

1. Initialize variables with small immediate values.
2. Perform addition and subtraction using addi.
3. Represent negative values correctly in registers.
4. Keep operations aligned with C snippet intent:
```c
  int a = 10;
  int b = 0;
  a = a + 4;
  b = a - 12;
  int i = 0;
  int x = 2032;
  int y = -78;
```
