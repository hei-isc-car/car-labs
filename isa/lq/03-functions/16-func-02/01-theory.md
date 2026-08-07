# Theory

This exercise focuses on **Nested Function Calls** and the associated RISC-V programming patterns.

## Core Concepts

- Non-leaf functions must preserve ra before calling another function.
- Argument passing and return values use a0 by convention.
- Leaf functions can often avoid stack usage when safe.
