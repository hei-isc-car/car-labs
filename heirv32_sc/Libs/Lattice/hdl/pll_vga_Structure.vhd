library IEEE;
use IEEE.std_logic_1164.all;
library ECP5U;
use ECP5U.components.all;

ENTITY pll_vga IS
    PORT( 
        clkIn100M : IN     std_ulogic;
        clk25MHz  : OUT    std_ulogic;
        pllLocked : OUT    std_ulogic
    );

-- Declarations

END pll_vga ;

architecture Structure of pll_vga is

    -- internal signal declarations
    signal REFCLK: std_logic;
    signal CLKOP_t: std_logic;
    signal CLKFB_t: std_logic;
    signal scuba_vhi: std_logic;
    signal scuba_vlo: std_logic;

    attribute FREQUENCY_PIN_CLKOP : string; 
    attribute FREQUENCY_PIN_CLKI : string; 
    attribute ICP_CURRENT : string; 
    attribute LPF_RESISTOR : string; 
    attribute FREQUENCY_PIN_CLKOP of PLLInst_0 : label is "25.000000";
    attribute FREQUENCY_PIN_CLKI of PLLInst_0 : label is "100.000000";
    attribute ICP_CURRENT of PLLInst_0 : label is "6";
    attribute LPF_RESISTOR of PLLInst_0 : label is "16";
    attribute syn_keep : boolean;
    attribute NGD_DRC_MASK : integer;
    attribute NGD_DRC_MASK of Structure : architecture is 1;

begin
    -- component instantiation statements
    scuba_vhi_inst: VHI
        port map (Z=>scuba_vhi);

    scuba_vlo_inst: VLO
        port map (Z=>scuba_vlo);

    PLLInst_0: EHXPLLL
        generic map (PLLRST_ENA=> "DISABLED", INTFB_WAKE=> "DISABLED", 
        STDBY_ENABLE=> "DISABLED", DPHASE_SOURCE=> "DISABLED", 
        CLKOS3_FPHASE=>  0, CLKOS3_CPHASE=>  0, CLKOS2_FPHASE=>  0, 
        CLKOS2_CPHASE=>  0, CLKOS_FPHASE=>  0, CLKOS_CPHASE=>  0, 
        CLKOP_FPHASE=>  0, CLKOP_CPHASE=>  25, PLL_LOCK_MODE=>  0, 
        CLKOS_TRIM_DELAY=>  0, CLKOS_TRIM_POL=> "FALLING", 
        CLKOP_TRIM_DELAY=>  0, CLKOP_TRIM_POL=> "FALLING", 
        OUTDIVIDER_MUXD=> "DIVD", CLKOS3_ENABLE=> "DISABLED", 
        OUTDIVIDER_MUXC=> "DIVC", CLKOS2_ENABLE=> "DISABLED", 
        OUTDIVIDER_MUXB=> "DIVB", CLKOS_ENABLE=> "DISABLED", 
        OUTDIVIDER_MUXA=> "DIVA", CLKOP_ENABLE=> "ENABLED", CLKOS3_DIV=>  1, 
        CLKOS2_DIV=>  1, CLKOS_DIV=>  1, CLKOP_DIV=>  26, CLKFB_DIV=>  1, 
        CLKI_DIV=>  4, FEEDBK_PATH=> "INT_OP")
        port map (CLKI=>clkIn100M, CLKFB=>CLKFB_t, PHASESEL1=>scuba_vlo, 
            PHASESEL0=>scuba_vlo, PHASEDIR=>scuba_vlo, 
            PHASESTEP=>scuba_vlo, PHASELOADREG=>scuba_vlo, 
            STDBY=>scuba_vlo, PLLWAKESYNC=>scuba_vlo, RST=>scuba_vlo, 
            ENCLKOP=>scuba_vlo, ENCLKOS=>scuba_vlo, ENCLKOS2=>scuba_vlo, 
            ENCLKOS3=>scuba_vlo, CLKOP=>CLKOP_t, CLKOS=>open, 
            CLKOS2=>open, CLKOS3=>open, LOCK=>pllLocked, INTLOCK=>open, 
            REFCLK=>REFCLK, CLKINTFB=>CLKFB_t);

    clk25MHz <= CLKOP_t;
end Structure;
