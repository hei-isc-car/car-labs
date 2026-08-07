---
id          = "f-simple"
name        = "Void Function Call"
language    = "riscv"
difficulty  = 1
description = "Practice function call and return mechanics with a minimal leaf function."
topics      = ["functions", "jal", "jalr"]
---

# Void Function Call

## Tasks

1. Call doNothing using jal.
2. Implement doNothing label and immediate return.
3. Keep function free of side effects.
4. Keep operations aligned with C snippet intent:
```c
  doNothing();
  ...
  void doNothing() {
    return;
  }
```
