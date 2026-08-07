---
id          = "b-instr-01"
name        = "Arithmetic Expression (Positive Values)"
language    = "riscv"
difficulty  = 2
description = "Implement a = b + c - d using positive integer inputs."
topics      = ["arithmetic", "registers", "temporaries"]
---

# Arithmetic Expression (Positive Values)

## Tasks

1. Initialize b, c, and d.
2. Compute intermediate sum b+c.
3. Combine with d to produce final a.
4. Keep operations aligned with C snippet intent:
```c
  int b = 1;
  int c = 2;
  int d = 5;
  a = b + c - d;
```
