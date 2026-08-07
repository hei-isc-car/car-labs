---
id          = "algo-fibo-recur"
name        = "Recursive Fibonacci"
language    = "riscv"
difficulty  = 3
description = "Implement a recursive Fibonacci function with proper base cases and stack discipline."
topics      = ["recursion", "stack", "calling-convention"]
---

# Recursive Fibonacci

## Tasks

1. Handle base cases n=0 and n=1.
2. Save required context before recursive calls.
3. Compute fib(n-1) and fib(n-2), then combine results.
4. Restore stack and return correctly in all paths.
5. Test with `n = 0, 1, 2, 3, 5, 15`.
6. Note the cycles count for `n = 15`.
6. Keep operations aligned with C snippet intent:
```c
  unsigned int fibonacci(unsigned int n){
    if(n == 0){return 0;}
    else if(n == 1) {return 1;}
    else {
      unsigned int a1 = fibonacci(n-1);
      unsigned int a2 = fibonacci(n-2);
      unsigned int a3 = a1 + a2;
      return a3;
    }
  }
```
