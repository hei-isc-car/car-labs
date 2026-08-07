# Theory

This exercise focuses on **Recursive Fibonacci** and the associated RISC-V programming patterns.

## Core Concepts

- Recursive functions need base cases to terminate.
- Non-leaf functions must preserve return address before nested calls.
- Function arguments and return values use a-registers by convention.
- Recursive is nothing different than calling any other function: stack and registers must be preserved across calls. The sole difference is it calls itself and thus must ensure to have an endpoint to avoid stack overflow.
