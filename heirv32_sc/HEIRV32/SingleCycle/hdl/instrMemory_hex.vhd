library ieee;
  use std.textio.all;
  use ieee.std_logic_textio.all;

ARCHITECTURE hex OF instrMemory IS

  -- Instructions type
  type t_instrBank is array (0 to (2**g_memoryNbBits)-1) of
    std_ulogic_vector(g_dataWidth-1 downto 0);

  -- Define function to create initvalue signal
  impure function ReadRamContentFromFile(ramContentFilenAme : in string) return t_instrBank is
    FILE     ramContentFile     : text is in ramContentFilenAme;
    variable ramContentFileLine : line;
    variable ramContent         : t_instrBank;
  begin
    for i in t_instrBank'range loop
      readline(ramContentFile, ramContentFileLine);
      HREAD(ramContentFileLine, ramContent(i));
    end loop;
    return ramContent;
  end function;

  -- Program
  constant larr_instr : t_instrBank := ReadRamContentFromFile(g_programFile);

BEGIN

  -- Comb. read
  process(PC)
  begin
    -- skip the two last bits (since we do only +4)
    instruction <= larr_instr(to_integer(PC(g_memoryNbBits+1 downto 2))) after g_tMemRd;
  end process;
  
END ARCHITECTURE hex;
