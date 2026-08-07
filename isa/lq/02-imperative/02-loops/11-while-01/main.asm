# EXPECT_REG: t0 0

_start:
  # int a = t0 = 10
  addi t0, zero, 10 # int a = 10;

  # do{a = a - 1;}
  # while(a != 0);
  
