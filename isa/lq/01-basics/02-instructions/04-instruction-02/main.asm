# EXPECT_REG: t0 -1
# EXPECT_REG: t1 2
# EXPECT_REG: t2 -78
# EXPECT_REG: s0 79

_start:
  # b = t0 = -1
  
  # c = t1 = 2

  # d = t3 = -78

  # a = s0 = b + c - d;
