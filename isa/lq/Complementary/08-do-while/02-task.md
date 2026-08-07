---
id          = "extra-do-while"
name        = "Do While"
language    = "riscv"
difficulty  = 2
description = "Implement do-while loop variants and observe control-flow differences."
topics      = ["loops", "branching", "signed-vs-unsigned"]
---

# Do While

## Tasks

- Implement and test:
```c
// A
int a = 10;
do { a = a - 1; }
while (a != 0);
```
```c
// B
int b = 10;
do { b = b - 1; }
while (b >= 0);
```

- What would happen if implemeenting the following ?
```c
// C
unsigned int c = 10;
do { c = c - 1; }
while (c >= 0);
```
