j _start

# EXPECT_REG: s0 1
# EXPECT_REG: s1 2
# EXPECT_REG: s2 3
# EXPECT_REG: s3 4
# EXPECT_REG: s4 5
# EXPECT_REG: s5 6
# EXPECT_REG: s6 7
# EXPECT_REG: s7 8
# EXPECT_REG: s8 9
# EXPECT_REG: s9 10
# EXPECT_REG: sp 760
# EXPECT_REG: s11 55

sum:


_start:
  # Setup sp
  li sp, 760

  # Load arguments (s0 = a, s1 = b ... s9 = j)

  # Call sum

  # res = s11 = sum(...)
  
