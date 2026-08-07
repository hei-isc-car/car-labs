# EXPECT_REG: s0 9
# EXPECT_REG: s1 1

_start:
  # Setup mem[0]
  li t0, 1
  sw t0, 440(zero)

  # Load for limit = mem[0] @ addr 440
  
  # Load i = s1 = 4
  
  # Load a = s0 = 0
  
  # For loop
