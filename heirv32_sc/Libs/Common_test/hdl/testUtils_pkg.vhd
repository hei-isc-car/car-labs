LIBRARY std;
  USE std.textio.all;
LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;

PACKAGE testUtils IS

  --============================================================================
  -- console output
  --

  procedure print(value : string);


  --============================================================================
  -- string manipulation
  --

                                                      -- conversion to lowercase
  function lc(value : string) return string;
  procedure lc(value : inout line);
                                                      -- conversion to uppercase
  function uc(value : string) return string;
  procedure uc(value : inout line);
                                            -- expand a string to a given length
  function pad(
    value           : string;
    string_length   : natural;
    fill_char       : character := ' ';
    right_justify   : boolean := false
  ) return string;
                     -- remove separator characters at beginning and end of line
  procedure rm_side_separators(
    value : inout line;
    separators : in string
  );
  procedure rm_side_separators(
    value : inout line
  );
                           -- remove multiple occurences of separator characters
  procedure trim_line(
    value : inout line;
    separators : in string
  );

  procedure trim_line(
    value : inout line
   );
                                -- remove all occurences of separator characters
  procedure rm_all_separators(
    value : inout line;
    separators : in string
  );

  procedure rm_all_separators(
    value : inout line
  );
                                                   -- find and remove first word
  procedure read_first(
    value : inout line;
    separators : in string;
    first : out line
  );

  procedure read_first(
    value : inout line;
    first : out line
   );
                                                    -- find and remove last word
  procedure read_last(
    value : inout line;
    separators : in string;
    last : out line
  );

  procedure read_last(
    value : inout line;
    last : out line
   );


  --============================================================================
  -- formatted string output
  --
  -- format codes:
  --  code  integer real std_logic std_(u)logic_vector (un)signed time
  --    b       v            v               v              v           binary
  --    c                                                               character
  --    d       v     v      v               v              v           decimal
  --    e                                                               real numbers, with power of 10 exponent
  --    f       v     v                                                 fixed point real numbers
  --    s                                                               string
  --    ts                                                          v   time in seconds
  --    tm                                                          v   time in milliseconds
  --    tu                                                          v   time in microseconds
  --    tn                                                          v   time in nanoseconds
  --    tp                                                          v   time in picoseconds
  --    x       v            v               v              v           hexadecimal
  --    X       v            v               v              v           hexadecimal with upper-case letters

  function sprintf(format : string; value : integer          ) return string;
  function sprintf(format : string; value : real             ) return string;
  function sprintf(format : string; value : std_logic        ) return string;
  function sprintf(format : string; value : std_ulogic_vector) return string;
  function sprintf(format : string; value : std_logic_vector ) return string;
  function sprintf(format : string; value : unsigned         ) return string;
  function sprintf(format : string; value : signed           ) return string;
  function sprintf(format : string; value : time             ) return string;

  --============================================================================
  -- formatted string input
  --
  subtype nibbleUlogicType is std_ulogic_vector(3 downto 0);
  subtype nibbleUnsignedType is unsigned(3 downto 0);

  function sscanf(value : character) return natural;
  function sscanf(value : character) return nibbleUlogicType;
  function sscanf(value : character) return nibbleUnsignedType;
  function sscanf(value : string   ) return natural;
  function sscanf(value : string   ) return unsigned;
  function sscanf(value : string   ) return std_ulogic_vector;
  function sscanf(value : string   ) return time;

  procedure sscanf(value : inout line; time_val : out time);

END testUtils;
