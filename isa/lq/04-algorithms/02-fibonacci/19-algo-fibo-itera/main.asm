j _start
# EXPECT_REG: sp 2000
# EXPECT_REG: s11 1
# EXPECT_REG: s0 15
# EXPECT_REG: a0 610


fibo_recurse:
  # unsigned int n = 5; // Fibonacci term to calculate
  # unsigned int fib1 = 0; // First Fibonacci number
  # unsigned int fib2 = 1; // Second Fibonacci number
  # for (unsigned int i = 0; i < n; i++) {
  #   unsigned int res = fib1 + fib2; // Calculate the next Fibonacci number
  #   fib1 = fib2; // Update the first number
  #   fib2 = res; // Update the second number
  # }
  # // The loop will run n times, and at the end, fib1 will hold the nth Fibonacci number



_start:
  # Initializes stack pointer
  li sp, 2000
  addi s11, s11, 1 # Checker to ensure runs in _start only once

  # Save N value = 15 in s0
  
  # Load arguments

  # Call function
