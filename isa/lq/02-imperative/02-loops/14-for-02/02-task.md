---
id          = "i-loop-for-02"
name        = "Byte Array Loop Update"
language    = "riscv"
difficulty  = 3
description = "Iterate over a byte array and update each element in place."
topics      = ["arrays", "bytes", "loops", "load-store"]
---

# Byte Array Loop Update

## Tasks

1. Loop i from 0 to 9.
2. Compute each element address from base and index.
3. Read byte, subtract 5, store byte back.
4. Preserve loop structure and stop at 10 elements.
4. Keep operations aligned with C snippet intent:
```c
  // An array of 10 bytes
  uint8_t myArray[10] = ...
  // ...
  // Let say myArray[0] is at the address saved in register a0.
  // Arrays are contiguous in memory: myArray = [el0][el1][el2]...[elN]
  int i;
  for(i = 0; i < 10; i = i + 1) {
    myArray[i] = myArray[i] - 5;
  }
```
