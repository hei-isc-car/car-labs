# EXPECT_REG: s2 0x00001000
# EXPECT_REG: t0 1

_start:
  # Prepare data
  li s2, 0x00001000
  li t0, 0x0A
  sb t0, 0(s2)
  li s2, 0xFFA
  li t0, 0xBEEF

  # s2 = mem[0x0000′1000]
  
  # Algorithm

  # Check mem[0x0000′1001]
  li t0, 0x00001001
  lbu t0, 0(t0)
  