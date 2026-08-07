# EXPECT_REG: a0 0xdeadbeef
# EXPECT_REG: t0 0xfffc
# EXPECT_REG: t1 0xfffc
# EXPECT_REG: t2 -4
# EXPECT_REG: t3 -4

_start:
  # Fill memory with some values
  # a0 = address_of(mem[0])
  li a0, 0xdeadbeef
  li t0, 0
  li t1, 10
  mv t2, a0
  fill_mem:
    sw t0, 0(t2)
    addi t0, t0, -1
    addi t1, t1, -1
    addi t2, t2, 4
    blt zero, t1, fill_mem

  # uint16_t a = t0 = mem[4];
  
  # mem[3] = a;
  
  # uint16_t b = t1 = mem[3];
  

  # int16_t c = t2 = mem[4];
  
  # mem[5] = c;
  
  # int16_t d = t3 = mem[5];
  
