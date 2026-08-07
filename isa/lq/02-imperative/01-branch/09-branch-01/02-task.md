---
id          = "i-branch-if"
name        = "If / Else Branching"
language    = "riscv"
difficulty  = 1
description = "Translate a simple if/else equality test into branch and jump instructions."
topics      = ["branches", "conditionals"]
---

# If / Else Branching

## Tasks

1. Compare a and b with beq.
2. Assign c=1 on equal path and c=0 otherwise.
3. Join both paths at a single end label.
4. Keep operations aligned with C snippet intent:
```c
  int a = 1, b = 2, c;
  if(a == b) {
  } c = 20;
  else {
    c = 30;
  }
```
