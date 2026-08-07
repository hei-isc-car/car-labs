# Theory

This exercise focuses on argument passing when a function takes more than 8 parameters.

## Core Concepts

- `a0..a7` carry the first 8 arguments.
- Additional arguments are passed on the stack by the caller.
- Callee reads those extra arguments at known stack offsets. It does not free that part of the stack, it is the caller's responsibility to clean up the stack after the function call.
