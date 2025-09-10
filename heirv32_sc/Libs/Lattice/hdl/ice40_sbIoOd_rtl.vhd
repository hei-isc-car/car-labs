-- Allows to use RGB pins from ice40 FPGAs
--   as user I/Os
library sb_ice40_components_syn;
  use sb_ice40_components_syn.components.all;

ARCHITECTURE rtl OF ice40_sbIoOd IS
BEGIN

  ODInst : SB_IO_OD     
    generic map (
      NEG_TRIGGER => '0',      -- FF's are rising edge
      PIN_TYPE    => "011001"  -- 0110 = PIN_OUT, 01 = PIN_INPUT
    ) 
    port map ( 
      DOUT1 => open,           -- Output on falling edge
      DOUT0 =>  '1',           -- Output on rising edge
      CLOCKENABLE => '1',      -- Clock Enable common to input and output clocks
      LATCHINPUTVALUE => '0',  -- Not latching input value
      INPUTCLK => clk,         -- Clock for the input registers
      DIN1 => open,            -- Input on falling edge
      DIN0 => rgbRd,           -- Input value
      OUTPUTENABLE => rgbWr,   -- Output Pin Tristate/Enable control
      OUTPUTCLK => clk,        -- Clock for the output registers
      PACKAGEPIN  => rgbPin    -- User’s Pin signal name
    );
END ARCHITECTURE rtl;

