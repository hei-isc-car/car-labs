# EXPECT_REG: s0 50
# EXPECT_REG: t0 25
# EXPECT_REG: t1 25

_start:
  # unsigned int a = s0 = 0

  # unsigned int i = t0 = 0

  # 25 = t1

  # for(i = 0; i < 25; i = i + 1) {
  #   a = a + 2;
  # }
