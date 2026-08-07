---
id          = "b-instr-03"
name        = "Arithmetic Expression (Mixed Signs II)"
language    = "riscv"
difficulty  = 2
description = "Apply expression translation on a different value combination, including larger immediate."
topics      = ["arithmetic", "immediates", "signed-values"]
---

# Arithmetic Expression (Mixed Signs II)

## Tasks

1. Load new constants for b, c, and d.
2. Reuse the b+c then combine pattern.
3. Validate final result against expected numeric behavior.
4. Keep operations aligned with C snippet intent:
```c
  int b = -12;
  int c = 2023;
  int d = 22;
  a = b + c - d;
```
