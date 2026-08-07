# Theory

This exercise focuses on **NOP (NO Operation)**.

## Core Concepts

It is sometimes required for the processor to simply do "nothing".
This is useful for active waiting, code alignments, pipeline flushing ...

The idea is to lose a clock cycle while not modifying the CPU state, i.e. no register is altered, no memory is touched.
