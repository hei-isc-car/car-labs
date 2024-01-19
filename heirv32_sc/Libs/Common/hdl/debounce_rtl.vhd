-- filename:          debounced.vhd
-- kind:              vhdl file
-- first created:     11.01.2024
-- created by:        boy
--------------------------------------------------------------------------------
-- History:
-- v0.1 : boy 11.01.2024 -- Initial Version

--------------------------------------------------------------------------------
-- Description: 
-- debounceds a button on both edges.
--             _   _   ____________________   _   _
-- input  ____/ \_/ \_/                    \_/ \_/ \______
--                           _____________________________
-- output __________________/                             \____________
--
--------------------------------------------------------------------------------
-- Generics: 
-- g_debounceTime (time) : parameter to fix the debounce time.
-- g_minConsecutiveStateCount (integer) : The number of consecutive readings of the same state required to change the output.
-- g_clockFrequency (real) : Clock frequency of the system
-- g_activeState (std_ulogic) : The output will be reset in "inactive" state. 
--------------------------------------------------------------------------------
-- Input is read each g_debounceTime, and a constant value must appear for
--   g_minConsecutiveStateCount to be forwarded on the output. 
-- To update the output, x consecutive samples needs to have
-- the exact same value. x is given with the "g_minConsecutiveStateCount" parameter
--------------------------------------------------------------------------------
LIBRARY ieee;
  USE ieee.math_real.all;
LIBRARY Common;
	USE Common.CommonLib.all;


ARCHITECTURE rtl OF debounce IS

  -- Creates a vector of alternating 1's and 0's (0b...1010)
	pure function alternating_ones_and_zeros(length : integer) return std_ulogic_vector is
	  variable ret_val : std_ulogic_vector(length - 1 downto 0);
	BEGIN
		for i in 0 to length - 1  loop
			if i mod 2 = 1 then
				ret_val(i) := '1';
			else
				ret_val(i) := '0';
			end if;
		end loop;

  	return ret_val;
	end function alternating_ones_and_zeros;
	
	-- To check if all bits are '1'
	constant c_LOGICAL_HIGH_VALID: std_ulogic_vector((g_minConsecutiveStateCount-1) downto 0) := (others=>'1');
	-- To check if all bits are '0'
	constant c_LOGICAL_LOW_VALID: std_ulogic_vector((g_minConsecutiveStateCount-1) downto 0) := (others=>'0');
	-- Alternating 1's and 0's for reset value
	constant c_INIT_SAMPLE: std_ulogic_vector((g_minConsecutiveStateCount-1) downto 0) := alternating_ones_and_zeros(g_minConsecutiveStateCount);
  -- Delay between two samplings
  -- delay = (g_debounceTime * g_clockFrequency) / g_minConsecutiveStateCount - 1
  constant DELAY: positive := integer(ceil(((real(g_debounceTime / 1 ps) / 1.0e12) * g_clockFrequency) / real(g_minConsecutiveStateCount))) - 1; 

	-- Holds the state of registered consecutive inputs
	signal lvec_sample: std_ulogic_vector((g_minConsecutiveStateCount-1) downto 0);
	-- Defines when we will sample (based on given DELAY)
	signal lsig_samplePulse: std_ulogic := '0';
	-- Counter for the delay
	signal lvec_count : unsigned(requiredBitNb(DELAY)-1 downto 0);

BEGIN

  clockDivider: process(reset, clock) --Clock Divider
	begin
		if reset = '1' then
			lvec_count <= (others => '0');
			lsig_samplePulse <= '0';
		elsif rising_edge(clock) then
			if (lvec_count < DELAY) then
				lvec_count <= lvec_count + 1;
				lsig_samplePulse <= '0';
			else
				lvec_count <= (others => '0');
				lsig_samplePulse <= '1';
			end if;
		end if;
	end process clockDivider;

	sampling: process(reset, clock) --Sampling Process
	begin
		if reset = '1' then		
			lvec_sample <= c_INIT_SAMPLE;
		elsif rising_edge(clock) then
			if lsig_samplePulse = '1' then
				lvec_sample((g_minConsecutiveStateCount - 1) downto 1) <= lvec_sample((g_minConsecutiveStateCount - 2) downto 0); -- Left Shift
				lvec_sample(0) <= input;
			end if;
		end if;
	end process sampling;

	inputDebouncing: process(reset, clock) --Input Debouncing 
	begin
		if reset = '1' then 
			debounced <= not g_activeState; 
		elsif rising_edge(clock) then
			if lvec_sample = c_LOGICAL_HIGH_VALID then --Active High Constant Out
				debounced <= '1';
			elsif lvec_sample = c_LOGICAL_LOW_VALID then
				debounced <= '0';
			end if;
		end if;
	end process inputDebouncing;
END ARCHITECTURE rtl;

