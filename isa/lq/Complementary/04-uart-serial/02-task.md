---
id          = "extra-uart-serial"
name        = "UART Serial Transmission"
language    = "riscv"
difficulty  = 2
description = "Transmit one byte bit-by-bit using a UART-like framing pattern."
topics      = ["memory", "bitwise", "algorithms"]
---

# UART Serial Transmission
Transmit the 8-bit memory value at address 0x0000′1000 serially, bit by bit, into the Least Significant Bit (LSB) of memory address 0x0000′1001. The remaining bits of memory address 0x0000′1001 must be ‘0’.
Calculate the baud rate in Instructions Bit for the entire transmission.

## Tasks

1. Load one byte from memory address `0x00001000`.
2. Send a stop bit (`1`) to address `0x00001001`.
3. Send a start bit (`0`) to address `0x00001001`.
4. Send 8 data bits, LSB first.
5. Send a final stop bit (`1`).
6. _This exercise cannot be fully tested through lq._
