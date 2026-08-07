# Theory

This exercise converts Fahrenheit to Celsius without floating-point instructions.

## Core Concepts

- Use fixed-point arithmetic to approximate division by 9.
- For chosen `n`, set `magic = (2^n)/9 + 1`.
- Compute:
  1. `c = f - 32`
  2. `c = c * 5`
  3. `c = c * magic`
  4. `c = c >> n`
