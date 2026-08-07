# EXPECT_REG: s1 1
# EXPECT_REG: s2 2
# EXPECT_REG: s0 3

# EXPECT_REG: s4 -1
# EXPECT_REG: s5 2
# EXPECT_REG: s3 1

# EXPECT_REG: t1 -12
# EXPECT_REG: t2 2023
# EXPECT_REG: t0 2011

_start:
  # s1 = b = 1

  # s2 = c = 2

  # s0 = a = b + c


 
  # s4 = d = -1

  # s5 = e = 2

  # s3 = f = d + e



  # t1 = g = -12

  # t2 = h = 2023

  # t0 = i = g + h
