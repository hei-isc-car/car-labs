j _start
# EXPECT_REG: sp 1800
# EXPECT_REG: s11 1
# EXPECT_REG: s10 1800
# EXPECT_REG: s9 16
# EXPECT_REG: s0 15
# EXPECT_REG: a0 610


fibo_memo:
  # Check if value exists (calc > n)
  
  # If exists, return the value from memory
      
  # Else calculate with standard recursive fibo
  calc_new:
    # Calc fibo recursively
    
    # Remember result for next time by saving value and incrementing number of elements
    
    # Restore context and return



_start:
  # Initializes stack pointer
  li sp, 2000
  addi s11, s11, 1 # Checker to ensure runs in _start only once
  # Initialize storage for memoization.
  addi sp, sp, -200 # max fibo nb 50 (*4 bytes)
  mv s10, sp        # s10 is addr. for storage
  sw zero, 0(s10)   # store fibo(0)
  li t0, 1
  sw t0, 4(s10)     # store fibo(1)
  li s9, 2         # s9 tells how many fibo are already evaluated

  # Main
  # Since here, do not modify s9 and s10, they are used to simulate a vector of known values.
  # Call function

  # Call the function again
  
  # Call the function again

  # Call the function again

  # Call the function again
  