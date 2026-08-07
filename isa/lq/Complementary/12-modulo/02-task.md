---
id          = "extra-modulo"
name        = "Modulo"
language    = "riscv"
difficulty  = 3
description = "Implement modulo with and without M extension, plus power-of-two optimization."
topics      = ["modulo", "rv32i", "rv32im", "bitwise"]
---

# Modulo
The modulo % is an operation performed on two positive integers and is nothing other than the remainder of the division.
For example, 5 divided by 3 gives 1 (you can pass 3 once in 5), remains 2.
The modulo of a number by 0 is not defined.
The definition for signed numbers differs from language to language. We only deal with the unsigned version.
Modulo has many uses, allowing you to cap values, extract information, calculate an X and Y position from an X*Y value in an array of known size …
- Give a code to perform this operation for any positive integer using the RV32IM set.
- How can the same thing be implemented in RV32I? Describe the concept(s).
The role of the compiler is to optimize the code as much as possible. If the operation detected is a modulo with a constant being a power of 2 (e.g. x % 2, y % 8 …), a variant including no division is possible.
- Give this variant

> **_NOTE:_** The notion of modulo for real numbers arrived with the evolution of computing power, and the result also diverges depending on the language. In C, a specific function from the std libraries is required, fmod(). In Python, this operation is native. In either case, they are more resource-intensive and require the handling of specific cases (NaN, infinity).

## Tasks

1. Compute `9 % 7` using RV32IM.
2. Compute `29 % 7` using RV32I-only repeated subtraction.
3. Compute `9 % 8` using bit masking.
