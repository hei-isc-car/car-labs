---
id          = "extra-for-loop"
name        = "For Loop"
language    = "riscv"
difficulty  = 2
description = "Implement a decreasing for-loop and accumulation."
topics      = ["for-loop", "branching", "memory"]
---

# For Loop

## Tasks

Implement:

```c
int a = 0, i;
for (i = 4; i > mem[0]; i = i - 1) {
  a = a + i;
}
```

Store sum in `s0`.
