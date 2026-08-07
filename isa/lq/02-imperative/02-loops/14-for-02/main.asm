# EXPECT_REG: a0  0x124
# EXPECT_REG: t0  10
# EXPECT_REG: t1  10
# EXPECT_REG: a1  0x000000fb
# EXPECT_REG: a2  0x000000fb
# EXPECT_REG: a3  0x000000fb
# EXPECT_REG: a4  0x000000fb
# EXPECT_REG: a5  0x000000fb
# EXPECT_REG: a6  0x000000fb
# EXPECT_REG: a7  0x000000fb
# EXPECT_REG: s8  0x000000fb
# EXPECT_REG: s9  0x000000fb
# EXPECT_REG: s10 0x000000fb
# EXPECT_REG: s11 0x000000fb

_start:
  # Array address
  li a0, 0x124


  # 10 = t0

  # int i = t1

  # for(i = 0; i < 10; i = i + 1) {
  #   myArray[i] = myArray[i] - 5;
  # }


  # Reread for auto-tests
  lbu a1, 0(a0)
  lbu a2, 1(a0)
  lbu a3, 2(a0)
  lbu a4, 3(a0)
  lbu a5, 4(a0)
  lbu a6, 5(a0)
  lbu a7, 6(a0)
  lbu s8, 7(a0)
  lbu s9, 8(a0)
  lbu s10, 9(a0)
  lbu s11, 10(a0)
