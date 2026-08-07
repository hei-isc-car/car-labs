j _start
# EXPECT_REG: sp 2000
# EXPECT_REG: s11 1
# EXPECT_REG: s0 1
# EXPECT_REG: s1 14
# EXPECT_REG: a0 14


# int callA(int v1) {
#   v1 = v1 * 2;
#   return callB(v1);
# }


# int callB(int v1) {
#   v1 = v1 + 12;
#   return v1;
# }


_start:
  # Initializes stack pointer
  li sp, 2000
  addi s11, s11, 1 # Checker to ensure runs in _start only once
  
  # int a = s0 = 1, int b = s1
  
  # b = callA(a);
