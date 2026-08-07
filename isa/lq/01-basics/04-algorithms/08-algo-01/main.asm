# EXPECT_REG: s0 0
# EXPECT_REG: s1 1
# EXPECT_REG: s2 1
# EXPECT_REG: s3 2
# EXPECT_REG: s4 3
# EXPECT_REG: s5 5
# EXPECT_REG: s6 8
# EXPECT_REG: s7 13
# EXPECT_REG: s8 21
# EXPECT_REG: s9 34

_start:
  # 10 fibonacci numbers
  # calculate the first 10 Fibonacci numbers
  # without loops or conditionals

  # set up initial values of fib(0) = s0 and fib(1) = s1

  # calculate fib(2) = s2 =  fib(1) + fib(0)

  # calculate fib(3) = s3 = fib(2) + fib(1)

  # calculate fib(4) = s4 = fib(3) + fib(2)

  # calculate fib(5) = s5 = fib(4) + fib(3)

  # calculate fib(6) = s6 = fib(5) + fib(4)

  # calculate fib(7) = s7 = fib(6) + fib(5)

  # calculate fib(8) = s8 = fib(7) + fib(6)

  # calculate fib(9) = s9 = fib(8) + fib(7)
