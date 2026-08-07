j _start

# EXPECT_REG: s0 5
# EXPECT_REG: a0 10
# EXPECT_REG: s1 10

doubleIt:
  

_start:
  # int a = s0 = 5

  # int b = s1 = doubleIt(a)
  
  nop
