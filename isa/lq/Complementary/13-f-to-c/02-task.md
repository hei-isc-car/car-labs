---
id          = "extra-f-to-c"
name        = "Fahrenheit to Celsius"
language    = "riscv"
difficulty  = 4
description = "Convert Fahrenheit to Celsius with fixed-point arithmetic on RV32I."
topics      = ["fixed-point", "algorithms", "multiplication", "shifts"]
---

# Fahrenheit to Celsius
We want to create a function capable of converting degrees Fahrenheit to Celsius. Since Fahrenheit values range from 32 to 1000, accuracy to the nearest degree is sufficient.
The formula is simple: $𝐶 = (𝐹 − 32) ∗ (5/9)$
This would be handy if a Floating Point Unit (FPU) was available, but only the basic RV32I instruction set is used here.
To get around this problem, you can use a few tricks based on the following algorithm:
1. Calculate $𝐶 = 𝐹 − 32$.
2. Multiply by 5
3. Divide by 9
  - $1/9$ can be stored in a special binary representation, in this case 0000_1110_0011_1000_1110_0011_1000_11102.
  +-----+-----+-----+-----+-----+-----+------------+------------+
  | b31 | b30 | b29 | b28 | b27 | ... | b1 | b0 |
  +-----+-----+-----+-----+-----+-----+------------+------------+
  | 2^0 | 2^-1| 2^-2| 2^-3| 2^-4| ... | 2^-30 | 2^-31 |
  +-----+-----+-----+-----+-----+-----+------------+------------+
  | 1 | 1/2 | 1/4 | 1/8 | 1/16| ... |1/1737418240|1/2147483648|
  +-----+-----+-----+-----+-----+-----+------------+------------+
  - The constant can be pre-calculated and is $2^𝑛/9 + 1$. The greater the 𝑛, the greater the precision. The number of bits defines the maximum size of $𝑛$. The $+1$ is a rounding-off for lost precision.
  - Let’s take $𝑛 = 16$. Our magic number is $magic = 2^𝑛/9 + 1 = 65536/9 + 1 = 7282$.
  - Multiply the value by this magic number
4. Then divide by $2^𝑛$. In the case $𝑛 = 16 → 1/65536$.

To simplify the work, several assumptions are made:
  - The magic number and the temperature in Fahrenheit are always positive.
  - The size of the largest multiplication is : $nbBitsmaxfahrenheit + nbBitsmult5 + nbBitsmagicNumber = 10(max. 1000-32) + 3 + (𝑛 − nbBitsdiv9 + 1) = 10 + 3 + (16 − 4 + 1) = 26 bits$
  - It never exceeds 32 bits for 𝑛 < 23.

Test and optimize the function:
  - Write the corresponding code.
  - Test with different Fahrenheit values.

## Tasks

Implement conversion with `n = 16` and `magic = 7282`:

```text
c = f - 32
c = c * 5
c = c * 7282
c = c >> 16
```

Use `f = 212` and store final Celsius value in `s9`.
Use `f = 330` and store final Celsius value in `s10`.
