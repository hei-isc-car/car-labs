---
id          = "f-nested"
name        = "Nested Function Calls"
language    = "riscv"
difficulty  = 3
description = "Implement chained function calls with proper context saving in non-leaf functions."
topics      = ["functions", "stack", "calling-convention"]
---

# Nested Function Calls

## Tasks

1. Set input value and call callA.
2. In callA, transform argument then call callB.
3. In callA, preserve and restore ra correctly.
4. Return final value into caller-visible register.
5. Keep operations aligned with C snippet intent:
```c
  int a = 1, b;
  b = callA(a);

  ...
  
  // Functions can be
  // optimized at will
  int callA(int v1) {
    v1 = v1 * 2;
    return callB(v1);
  }

  int callB(int v1) {
    v1 = v1 + 12;
    return v1;
  }
```
