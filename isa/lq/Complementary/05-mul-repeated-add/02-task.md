---
id          = "extra-mul-repeated-add"
name        = "Multiplication by Repeated Addition"
language    = "riscv"
difficulty  = 2
description = "Multiply two 4-bit values using a branch-based accumulation loop."
topics      = ["loops", "branching", "arithmetic"]
---

# Multiplication by Repeated Addition
Multiply two 4-bit numbers together using one of the commands bne or bge.
The algorithm works as follows: a multiplication is the same as adding the same number x times.
For example: 2 ∗ 9 = 9 + 9 = 18

## Tasks

1. Set input values in `a0` and `a1`.
2. Compute `a2 = a0 * a1` using repeated addition only.
3. Use either `bne` or `bge` for loop control.
