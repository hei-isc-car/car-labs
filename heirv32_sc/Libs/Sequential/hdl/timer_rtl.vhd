--====================================================================--
-- Design units : sequential.timer.rtl
--
-- File name : timer.vhd
--
-- Purpose : This component is a timer. It is used to count down a
--           value from a given request timing. When the timer reaches 0, the
--           elapsed signal is set to '1'. 
--           The timer is restarted by setting the i_restart signal to '1'.
--           The timer is enabled by setting the i_enable signal to '1'.
--
-- Note : This model can be synthesized by Xilinx Vivado.
--
-- Limitations : 
--
-- Errors : 
--
-- Library : sequential
--
-- Dependencies : Common.CommonLib
--
-- Author : remy.borgeat
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
-- 1.0     BOY    03.12.2024
-- 
-- 
------------------------------------------------
library Common;
  use Common.CommonLib.all;

ARCHITECTURE rtl OF timer IS

  constant c_TIMER_BIT_NB: positive := requiredBitNb(g_REQUESTED_TIMING); 
  signal lvec_timer: unsigned(c_TIMER_BIT_NB-1 downto 0);

BEGIN

  ------------------------------------------------------------------
  -- timer_handler: 
  -- This process is the timer handler. It is used to count down the
  -- timer value. When the timer reaches 0, the elapsed signal is set
  -- to '1'.
  -- The timer is restarted by setting the i_restart signal to '1'.
  -- The timer is enabled by setting the i_enable signal to '1'.
  ------------------------------------------------------------------
  timer_handler: process(reset, clock)
  begin
    if reset = '1' then
      lvec_timer <= to_unsigned(g_REQUESTED_TIMING, lvec_timer'length);
    elsif rising_edge(clock) then      
      if i_restart = '1' then
        lvec_timer <= to_unsigned(g_REQUESTED_TIMING, lvec_timer'length);
      else
        if i_enable = '1' then
          if lvec_timer > 0 then
            lvec_timer <= lvec_timer-1;
          end if;
        end if;
      end if;
    end if;
  end process;

  ------------------------------------------------------------------
  -- elpased: 
  -- This process is used to set the elapsed signal to '1' when the
  -- timer reaches 0.
  ------------------------------------------------------------------
  elpased : process(lvec_timer)
  begin
    if lvec_timer = 0 then
      o_elapsed <= '1';
    else
      o_elapsed <= '0';
    end if;
  end process;

END ARCHITECTURE rtl;

