#define LED_MATRIX_0_BASE (0xf0000004)
#define SWITCHES_0_BASE (0xf0000000)

setup:
    # led is sw xx, offBy4(x30) with xx loaded as 0x00rrggbb
    li x30, 0xf0000004 # base address for leds
    li x31, 0xf0000000 # base address for buttons, one register

    mv s0, x0 # leds last state

main_loop:
    
    # Your code here
    
    j main_loop
    

     
get_btns: # return buttons value in a0
  lw a0, 0(x31)
  jr ra
    
set_leds: # pass a 8 bits which if bit(n) = '1', led(n) is on
  li t0, 8   # loop the leds
  mv t3, x30 # mem position
  addi t3, t3, 28 # leds display is reversed, so stock reverted
  
  leds_loop:
  beq x0, t0, leds_end
  andi t1, a0, 1
  # if 1, lights corresponding led
  beq t1, x0, isoff
  
  ison:
  li t2, 0x00ffffff
  j leds_loop_end
  
  isoff:
  mv t2, x0 
   
  leds_loop_end:
  sw t2, 0(t3) # save led value
  srli a0, a0, 1  # shift right leds value
  addi t0, t0, -1 # decrement loop
  addi t3, t3, -4  # add memory pos
  j leds_loop
  
  leds_end:
  jr ra
