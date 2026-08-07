---
id          = "i-loop-for-01"
name        = "For Loop with Memory Bound"
language    = "riscv"
difficulty  = 2
description = "Implement a for-loop where the upper bound is read from memory."
topics      = ["loops", "memory", "branches"]
---

# For Loop with Memory Bound

## Tasks

1. Initialize i and accumulator a.
2. Apply body operation a = a + 2 each iteration.
3. Increment i after body and re-test condition.
4. Keep operations aligned with C snippet intent:
```c
  unsigned int a = 0, i;
  // mem array is at address saved in
  register a0
  for(i = 0; i < 25; i = i + 1) {
    a = a + 2;
  }
```
