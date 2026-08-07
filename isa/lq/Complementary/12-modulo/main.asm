# EXPECT_REG: s0 9
# EXPECT_REG: s1 7
# EXPECT_REG: s2 2
# EXPECT_REG: s3 29
# EXPECT_REG: s4 7
# EXPECT_REG: s5 1
# EXPECT_REG: s6 9
# EXPECT_REG: s7 8
# EXPECT_REG: s8 1

_start:
  # s2 = 9 (s0) % 7 (s1) with RV32IM

  # s5 = 29 (s3) % 7 (s4)

  # s8 = 9 (s6) % 8 (s7)
