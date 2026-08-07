j _start

# EXPECT_REG: s0 212
# EXPECT_REG: s1 54
# EXPECT_REG: s2 7282
# EXPECT_REG: s3 16
# EXPECT_REG: s9 100
# EXPECT_REG: s10 12

fmulFunct:

  jr ra

f_to_c:
  # a0 = farenheit value
  # a1 = magic number
  # a2 = n

  # Prologue (f_to_c calls another function)

  # 1. c = f - 32
  
  # 2. c = c * 5

  # 3. c = c * 2^n / 9

  # 4. c >>= n

  # Done
  
  jr ra

_start:
  # Load farenheit 1 in s0 = 212
  li s0, 212
  # Load farenheit 2 in s1 = 54
  li s1, 54
  # Load magic in s2 = 7282
  li s2, 7282
  # Load n in s3
  li s3, 16

  # Call f_to_c for farenheit 1
  mv a0, s0
  mv a1, s2
  mv a2, s3
  jal ra, f_to_c
  # Save result in s9
  mv s9, a0
  
  # Call f_to_c for farenheit 2
  mv a0, s1
  mv a1, s2
  mv a2, s3
  jal ra, f_to_c
  # Save result in s10
  mv s10, a0
