---
id          = "b-instr-02"
name        = "Arithmetic Expression (Mixed Signs I)"
language    = "riscv"
difficulty  = 2
description = "Implement arithmetic expression with both positive and negative operands."
topics      = ["arithmetic", "signed-values", "registers"]
---

# Arithmetic Expression (Mixed Signs I)

## Tasks

1. Load signed values for b, c, and d.
2. Compute expression using the same structure as previous exercise.
3. Confirm final value in a under signed interpretation.
4. Keep operations aligned with C snippet intent:
```c
  int b = -1;
  int c = 2;
  int d = -78;
  a = b + c - d;
```
