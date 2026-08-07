# Theory

This exercise focuses on **Word Array Addressing and Alignment** and the associated RISC-V programming patterns.

## Core Concepts

- Word array element index i maps to byte offset i*4.
- lw/sw require word-aligned addresses.
- Byte writes can update subparts of words at arbitrary byte addresses.
