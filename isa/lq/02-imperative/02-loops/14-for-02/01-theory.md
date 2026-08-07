# Theory

This exercise focuses on **Byte Array Loop Update** and the associated RISC-V programming patterns.

## Core Concepts

- Byte arrays use 1-byte stride, so address = base + index.
- lbu loads a byte as unsigned; sb stores one byte.
- Word stores are incorrect for byte arrays.
