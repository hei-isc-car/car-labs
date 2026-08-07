# Theory

This exercise focuses on **Void Function Call** and the associated RISC-V programming patterns.

## Core Concepts

- jal stores return address in ra and jumps to target.
- Leaf functions that do no extra calls can return directly with jr ra.
- A do-nothing function still obeys call/return protocol.
- Arguments are passed in a0-a7, return value in a0.
- The caller registers the return address (PC + 4) in ra.
- The callee must not rewrite ra, stack or sXX registers. If used, their values must be saved and restored before returning from the function.
