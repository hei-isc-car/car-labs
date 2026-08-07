---
id          = "extra-switch-case"
name        = "Switch Case"
language    = "riscv"
difficulty  = 2
description = "Implement a switch/case/default branch structure."
topics      = ["branching", "switch", "memory"]
---

# Switch Case

## Tasks

Implement:

```c
switch (mem[0]) {
  case 0:  a = 17; break;
  case 3:  a = 33; break;
  case 8:
  case 12: a = 10; break;
  default: a = 99;
}
```

Load `mem[2]` and store result in `s0`.
