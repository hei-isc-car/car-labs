# Theory

This exercise focuses on **Bigger Immediates** and the associated RISC-V programming patterns.

## Core Concepts

- lui writes upper 20 bits and clears lower 12 bits.
- addi fills lower 12 bits but sign-extends its immediate.
- Some constants require adjusting upper bits before addi.
