---
id          = "algo-fibo-memo"
name        = "Memoized Fibonacci"
language    = "riscv"
difficulty  = 4
description = "Use memoization and recursion together to avoid recomputing Fibonacci subproblems."
topics      = ["memoization", "recursion", "stack", "memory"]
---

# Memoized Fibonacci

## Tasks

1. Normally a vector is used to expand at will following values being registered bit by bit. Since no dynamic memory is available here, a place is reserved on the stack, at a known address, with a known number of elements. Both those informations are simulated by using `s10` as the base address of the reserved space, and `s9` as the number of known values. The first two values are already known: fibo(0) = 0 and fibo(1) = 1. The rest of the values will be computed and stored in the reserved space.
2. Follow the following recipe:
  - Pre-reserve place on the stack, e.g. 50 * 4 bytes for fib(0) to fib(49). The address and current number of elements is known (vector) and simulated by s10 and s9 values (avoid touching them in your code).
  - Save fibo(0) and fibo(1) in the reserved space.
  - Call the recursive function with the desired `n` value.
  - In the function, first check if `n` is already known (i.e. `n < s9`). If so, return the value from the reserved space. If not, compute fibo(n-1) and fibo(n-2) through recursive calls.
  - At the end of the function, if `n` was not known, store the computed value in the reserved memory (`s10 + n*4`) and increment the number of known values (`s9 += 1`).
  - The function will calculate unknown values once and then quickly return known values for subsequent calls.
2. Test with `n = 0, 1, 2, 3, 5, 15`. Note the cycles count for `n = 15`.
3. Test to call the fibo function multiple times (do not forget to reload `a0` !) with the same `n = 15` value. In a "standard" method applying the same algorithm, the cycles count should nearly double. There, a second call should add only a few cycles.
