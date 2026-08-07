# EXPECT_REG: s0 2
# EXPECT_REG: s1 3
# EXPECT_REG: s2 -1
# EXPECT_REG: s3 -78
# EXPECT_REG: s4 2023
# EXPECT_REG: s5 -12
# EXPECT_REG: s0 -1
# EXPECT_REG: s6 
# EXPECT_REG: s
# EXPECT_REG: s
# EXPECT_REG: s

_start:
  # s0 = b = 2
  
  # s1 = c = 3
  
  # s2 = e = -1
  
  # s3 = f = -78
  
  # s4 = g = 2023
  
  # s5 = h = -12
  
  # s0 = a = b - c
  
  # s6 = d = (e + f) - (g + h)
