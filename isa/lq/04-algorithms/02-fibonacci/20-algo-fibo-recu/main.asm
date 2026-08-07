j _start
# EXPECT_REG: sp 2000
# EXPECT_REG: s11 1
# EXPECT_REG: s0 15
# EXPECT_REG: a0 610


fibo_recurse:
  # unsigned int fibonacci(unsigned int n){
  #   if(n == 0){return 0;}
  #   else if(n == 1) {return 1;}
  #   else {
  #     unsigned int a1 = fibonacci(n-1);
  #     unsigned int a2 = fibonacci(n-2);
  #     unsigned int a3 = a1 + a2;
  #     return a3;
  #   }
  # }
  
  

_start:
  # Initializes stack pointer
  li sp, 2000
  addi s11, s11, 1 # Checker to ensure runs in _start only once

  # Save N value = 15 in s0
  
  # Load arguments

  # Call function
