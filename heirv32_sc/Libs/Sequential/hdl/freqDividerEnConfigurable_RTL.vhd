--====================================================================--
-- Design units : sequential.freqDividerEnConfigurable.RTL
--
-- File name : freqDividerEnConfigurable.vhd
--
-- Purpose : a frequency divider block which pulses the output
--
-- Library : sequential
--
-- Dependencies : None
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
-- 1.0            20.05.2025
-- 
-- 
------------------------------------------------

Library Common;
  Use Common.CommonLib.all;

ARCHITECTURE RTL OF freqDividerEnConfigurable IS

  signal lsig_pulse : std_ulogic;
  signal lvec_cnt : unsigned(g_DIVIDER_BIT_NB - 1 downto 0);

BEGIN

  proc_pulse : process (i_rst, i_clk)
  begin
    if i_rst = '1' then
      lvec_cnt <= (others => '0');
      lsig_pulse <= '0';
    elsif rising_edge(i_clk) then
      lsig_pulse <= '0';

      if i_en = '0' then
        lvec_cnt <= i_divider;
      else
        if lvec_cnt = 0 then
          lvec_cnt <= i_divider;
          lsig_pulse <= '1';
        else
          lvec_cnt <= lvec_cnt - 1;
        end if; -- lvec_cnt = 0
      end if; -- i_en = '0'

    end if;
  end process proc_pulse;

  -- Output pulse
  o_pulse <= lsig_pulse;

END ARCHITECTURE RTL;
