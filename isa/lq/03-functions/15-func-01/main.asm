j _start
# EXPECT_REG: sp 2000
# EXPECT_REG: ra 20
# EXPECT_REG: s11 1

#void doNothing() {
  #  return;
#}

_start:
  # Initializes stack pointer
  li sp, 2000
  addi s11, s11, 1 # Checker to ensure runs in _start only once
  
  # doNothing();
