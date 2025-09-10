--====================================================================--
-- Design units : memory.FIFOwFlags.RTL
--
-- File name : FIFOwFlags.vhd
--
-- Purpose :
--
-- Note : This model can be synthesized by Xilinx Vivado.
--
-- Limitations : 
--
-- Errors : 
--
-- Library : memory
--
-- Dependencies : Common
--
-- Author : Axam
-- HES-SO Valais/Wallis
-- Route de l'Industrie 23
-- 1950 Sion
-- Switzerland
--
-- Design tool : HDL Designer 2019.2 (Build 5)
-- Simulator : ModelSim 20.1.1
------------------------------------------------
-- Revision list
-- Version Author Date           Changes
-- 1.0            15.05.2025
-- 
-- 
------------------------------------------------

Library Common;
  Use Common.CommonLib.all;

ARCHITECTURE RTL OF FIFOwFlags IS
  type ram_t is array (0 to g_DEPTH - 1) of std_ulogic_vector(g_DATA_WIDTH - 1 downto 0);
  signal lvec_ram : ram_t;
  signal lvec_data_out : std_ulogic_vector(g_DATA_WIDTH - 1 downto 0);

  
  attribute syn_ramstyle : string;
  attribute syn_ramstyle of lvec_ram : signal is "block_ram";
  
  subtype index_t is integer range ram_t'range;
  signal lvec_head : index_t;
  signal lvec_tail : index_t;
  
  signal lsig_empty : std_logic;
  signal lsig_full : std_logic;
  signal lvec_data_count : integer range g_DEPTH - 1 downto 0;
  
  -- Increment and wrap
  procedure incr(signal index : inout index_t) is
  begin
    if index = index_t'high then
      index <= index_t'low;
    else
      index <= index + 1;
    end if;
  end procedure;

BEGIN

  -- Copy internal signals to output
  o_empty <= lsig_empty;
  o_full <= lsig_full;
  o_dataCount <= to_unsigned(lvec_data_count, requiredBitNb(g_DEPTH - 1));
  o_nearEmpty <= '1' when lvec_data_count = 1 else '0';
  o_nearFull <= '1' when lvec_data_count = g_DEPTH - 2 else '0';
  o_dataOut <= lvec_data_out;
  
  -- Set the flags
  lsig_empty <= '1' when lvec_data_count = 0 else '0';
  lsig_full <= '1' when lvec_data_count >= g_DEPTH - 1 else '0';
  
  -- Update the lvec_head pointer in write
  proc_head : process(i_clock)
  begin
    if rising_edge(i_clock) then
      if i_reset = '1' then
        lvec_head <= 0;
      else
        if i_clear = '1' then
          lvec_head <= 0;
        else
          if i_writeEn = '1' and lsig_full = '0' then
            incr(lvec_head);
          end if;
        end if;
      end if;
    end if;
  end process proc_head;
  
  -- Update the lvec_tail pointer on read and pulse valid
  proc_tail : process(i_clock)
  begin
    if rising_edge(i_clock) then
      if i_reset = '1' then
        lvec_tail <= 0;
      else
        if i_clear = '1' then
          lvec_tail <= 0;
        else
          if i_readEn = '1' and lsig_empty = '0' then
            incr(lvec_tail);
          end if;
        end if;
      end if;
    end if;
  end process proc_tail;
  
  -- Write to and read from the lvec_ram
  proc_ram : process(i_clock)
  begin
    if rising_edge(i_clock) then
      lvec_ram(lvec_head) <= i_dataIn;
      lvec_data_out <= lvec_ram(lvec_tail);
    end if;
  end process proc_ram;
  
  -- Update the fill count
  proc_count : process(lvec_head, lvec_tail)
  begin
    if lvec_head < lvec_tail then
      lvec_data_count <= lvec_head - lvec_tail + g_DEPTH;
    else
      lvec_data_count <= lvec_head - lvec_tail;
    end if;
  end process proc_count;

END ARCHITECTURE RTL;
