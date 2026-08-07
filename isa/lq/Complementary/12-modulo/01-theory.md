# Theory

This exercise explores modulo implementations on RV32IM and RV32I.

## Core Concepts

- RV32IM provides `remu` for unsigned remainder.
- RV32I can compute modulo by repeated subtraction.
- For power-of-two divisor `p`, `x % p` equals `x & (p - 1)`.
