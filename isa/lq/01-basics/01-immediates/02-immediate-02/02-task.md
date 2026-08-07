---
id          = "b-imm-02"
name        = "Loading 32-bit Constants"
language    = "riscv"
difficulty  = 2
description = "Construct full 32-bit constants using lui and addi with sign-extension awareness."
topics      = ["lui", "addi", "immediates", "sign-extension"]
---

# Loading 32-bit Constants

## Tasks

1. Load first 32-bit constant with lui+addi.
2. Load second constant while handling sign-extension edge case.
3. Verify final register values match expected hex constants.
4. Keep operations aligned with C snippet intent:
```c
  int a = 0xABCDE123;
  int b = 0xFEEDA987;
```