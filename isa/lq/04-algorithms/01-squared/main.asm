j _start

# EXPECT_REG: sp 2000
# EXPECT_REG: s11 1

mulFunct: # mulFunct(int a, int b)



_start:
  # Initializes stack pointer
  li sp, 2000
  addi s11, s11, 1 # Checker to ensure runs in _start only once
  
  # Load arguments

  # Call function
