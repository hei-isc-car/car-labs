---
id          = "i-branch-sw"
name        = "Switch / Case with Branches"
language    = "riscv"
difficulty  = 2
description = "Implement switch/case behavior using conditional branches and explicit default handling."
topics      = ["switch", "branches", "control-flow"]
---

# Switch / Case with Branches

## Tasks

1. Compare b with each case value.
2. Assign a for case 0 and case 7.
3. Implement default assignment for other values.
4. Ensure control flow exits each case cleanly.
5. Keep operations aligned with C snippet intent:
```c
  int a, b = 4;
  switch(b) {
    case 0:
      a = 17;
      break;
    case 7:
      a = 42;
      break;
    default:
      a = 99;
  }
```
