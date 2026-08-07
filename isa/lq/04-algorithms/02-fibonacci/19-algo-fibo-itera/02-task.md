---
id          = "algo-fibo-iter"
name        = "Iterative Fibonacci Function"
language    = "riscv"
difficulty  = 3
description = "Implement Fibonacci iteratively using loop variables and a function call interface."
topics      = ["loops", "functions", "fibonacci"]
---

# Iterative Fibonacci Function

## Tasks

1. Initialize fib1, fib2, and i.
2. Loop until i reaches n.
3. Update state in the right order each iteration.
4. Return the computed Fibonacci value in a0.
5. Test with `n = 0, 1, 2, 3, 5, 15`.
6. Note the cycles count for `n = 15`.
7. Keep operations aligned with C snippet intent:
```c
  unsigned int n = 5; // Fibonacci term to calculate
  unsigned int fib1 = 0; // First Fibonacci number
  unsigned int fib2 = 1; // Second Fibonacci number
  for (unsigned int i = 0; i < n; i++) {
    unsigned int res = fib1 + fib2; // Calculate the next Fibonacci number
    fib1 = fib2; // Update the first number
    fib2 = res; // Update the second number
  }
  // The loop will run n times, and at the end, fib1 will hold the nth Fibonacci number
```
