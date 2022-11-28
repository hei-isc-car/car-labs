PACKAGE BODY testUtils IS

  --============================================================================
  -- console output
  --

  procedure print(value : string) is
    variable my_line : line;
  begin
    write(my_line, value);
    writeLine(output, my_line);
    deallocate(my_line);
  end print;


  --============================================================================
  -- string manipulation
  --

  ------------------------------------------------------------------------------
  -- change to lowercase
  ------------------------------------------------------------------------------
  procedure lc(value: inout line) is
    variable out_line: line;
  begin
    for index in value'range loop
      if (value(index) >= 'A') and (value(index) <= 'Z') then
        value(index) := character'val(character'pos(value(index))
                                    - character'pos('A')
                                    + character'pos('a')
                                      );
      end if;
    end loop;
  end lc;

  function lc(value: string) return string is
    variable out_line: line;
  begin
    write(out_line, value);
    lc(out_line);
    return(out_line.all);
  end lc;

  ------------------------------------------------------------------------------
  -- change to uppercase
  ------------------------------------------------------------------------------
  procedure uc(value: inout line) is
    variable out_line: line;
  begin
    for index in value'range loop
      if (value(index) >= 'a') and (value(index) <= 'z') then
        value(index) := character'val(character'pos(value(index))
                                    - character'pos('a')
                                    + character'pos('A')
                                      );
      end if;
    end loop;
  end uc;

  function uc(value: string) return string is
    variable out_line: line;
  begin
    write(out_line, value);
    uc(out_line);
    return(out_line.all);
  end uc;

  ------------------------------------------------------------------------------
  -- formatted string output: padding and justifying
  ------------------------------------------------------------------------------
  function pad(
    value           : string;
    string_length   : natural;
    fill_char       : character := ' ';
    right_justify   : boolean := false
  ) return string is
    variable value_line : line;
    variable out_line : line;
    variable value_length : natural;
    variable shift_sign : boolean;
  begin
    write(value_line, value);
    value_length := value_line.all'length;
    if string_length = 0 then
      write(out_line, value_line.all);
    elsif string_length > value_length then
      if right_justify then
        if (value_line.all(value_line.all'left) <= '-') and not(fill_char = ' ') then
          shift_sign := true;
          write(out_line, value_line.all(value_line.all'left));
        end if;
        for index in 1 to string_length-value_length loop
          write(out_line, fill_char);
        end loop;
      end if;
      if shift_sign then
        write(out_line, value_line.all(value_line.all'left+1 to value_line.all'right));
      else
        write(out_line, value_line.all);
      end if;
      if not right_justify then
        for index in 1 to string_length-value_length loop
          write(out_line, fill_char);
        end loop;
      end if;
    elsif string_length < value_length then
      write(out_line, '#');
      write(out_line, value_line.all(value_length-string_length+2 to value_length));
    else
      write(out_line, value_line.all);
    end if;
    deallocate(value_line);
    return(out_line.all);
  end pad;

  ------------------------------------------------------------------------------
  -- remove separator characters at beginning and end of line
  ------------------------------------------------------------------------------
  procedure rm_side_separators(
    value : inout line;
    separators : in string
  ) is
    variable input_line : line    := value;
    variable found      : boolean := false;
    variable position   : integer := 0;
  begin
    -- remove all separators in the beginning
    position := -1;
    for character_index in input_line'range loop
      found := false;
      for separator_index in separators'range loop
        if input_line(character_index) = separators(separator_index) then
          found := true;
        end if;
      end loop;
      if found then
          position := character_index;
      else
          exit;
      end if;
   end loop;
   if position > -1 then
     input_line := new string'( input_line(position+1 to input_line'right) );
   end if;

   -- remove all separators in the end
    position := -1;
    for character_index in input_line'reverse_range loop
      found := false;
      for separator_index in separators'range loop
        if input_line(character_index) = separators(separator_index) then
          found := true;
        end if;
      end loop;
      if found then
          position := character_index;
      else
          exit;
      end if;
   end loop;
   if position > -1 then
     input_line := new string'( input_line(input_line'left to position-1) );
   end if;

   value := input_line;
  end;

  procedure rm_side_separators(value : inout line) is
  begin
    rm_side_separators(value, " :" & ht);
  end;

  ------------------------------------------------------------------------------
  -- remove multiple occurences of separator characters, keeping one single
  ------------------------------------------------------------------------------
  procedure trim_line(
    value : inout line;
    separators : in string
  ) is
    variable input_line: line := value;
    variable output_line: line := new string'("");
    variable is_separator, was_separator : boolean := false;
  begin
    rm_side_separators(input_line);
    for character_index in input_line'range loop
      is_separator := false;
      for separator_index in separators'range loop
        if input_line.all(character_index) = separators(separator_index) then
          is_separator := true;
        end if;
      end loop;
      if not (is_separator and was_separator) then
        write(output_line, input_line.all(character_index));
      end if;
      was_separator := is_separator;
    end loop;

    value := output_line;
  end;

  procedure trim_line(value : inout line) is
  begin
    trim_line(value, " :" & ht);
  end;

  ------------------------------------------------------------------------------
  -- remove all occurences of separator characters
  ------------------------------------------------------------------------------
  procedure rm_all_separators(
    value : inout line;
    separators : in string
  ) is
    variable input_line   : line    := value;
    variable is_separator : boolean := false;
  begin

    -- remove separators from beginn and end of the line
    -- rm_separator_be(value, separators);

    -- empty output line
    value := new string'("");

    -- find all separator symbols
    for character_index in input_line'range loop
      is_separator := false;
      for separator_index in separators'range loop
        if input_line(character_index) = separators(separator_index) then
          is_separator := true;
        end if;
      end loop;
      if not is_separator then
        write(value, input_line.all(character_index));
      end if;
    end loop;

  end;

  procedure rm_all_separators(value : inout line) is
  begin
    rm_all_separators(value, " _." & ht);
  end;

  ------------------------------------------------------------------------------
  -- read first "word" out of a line
  ------------------------------------------------------------------------------
  procedure read_first(
    value : inout line;
    separators : in string;
    first : out line
  ) is
    variable input_line: line;
    variable position: natural := 0;
  begin
    input_line := value;
    for character_index in input_line.all'reverse_range loop
      for separator_index in separators'range loop
        if input_line.all(character_index) = separators(separator_index) then
          position := character_index;
        end if;
      end loop;
    end loop;
    if position > 1 then
      first := new string'(input_line.all(input_line'left to position-1));
	    value := new string'(input_line(position+1 to input_line'right));
    else
      first := new string'(input_line.all);
	    value := new string'("");
    end if;
  end;

  procedure read_first(value : inout line; first : out line) is
  begin
    read_first(value, " :" & ht, first);
  end;

  ------------------------------------------------------------------------------
  -- read last "word" out of a line
  ------------------------------------------------------------------------------
  procedure read_last(
    value : inout line;
    separators : in string;
    last : out line
  ) is
    variable input_line: line := value;
    variable position: natural := 0;
  begin
    for character_index in input_line'range loop
      for separator_index in separators'range loop
        if input_line(character_index) = separators(separator_index) then
          position := character_index;
        end if;
      end loop;
    end loop;
    if position <= input_line'right and
       position >  0                then
      value := new string'(input_line(input_line'left to position-1));
      last  := new string'(input_line(position+1 to input_line'right));
    else
      last := new string'(input_line.all);
    end if;
  end;

  procedure read_last(value : inout line; last : out line) is
  begin
    read_last(value, " :" & ht, last);
  end;


  --============================================================================
  -- formatted string output, internal functions
  --

  ------------------------------------------------------------------------------
  -- get format specification
  ------------------------------------------------------------------------------
  procedure get_format_items(
    format          : string;
    right_justify   : out boolean;
    add_sign        : out boolean;
    fill_char       : out character;
    total_length    : out natural;
    point_precision : out natural;
    format_type     : inout line
  ) is
    variable find_sign : boolean := false;
    variable find_padding : boolean := false;
    variable find_length : boolean := false;
    variable find_precision : boolean := false;
    variable find_type : boolean := false;
    variable right_justify_int : boolean := true;
    variable total_length_int : natural := 0;
    variable point_precision_int : natural := 0;
  begin
    add_sign := false;
    fill_char := ' ';
    for index in 1 to format'length loop
      if find_type then
        write(format_type, format(index));
      end if;
      if find_precision then
        if (format(index) >= '0') and (format(index) <= '9') then
          point_precision_int := 10*point_precision_int + character'pos(format(index)) - character'pos('0');
          if format(index+1) >= 'A' then
            find_precision := false;
            find_type := true;
          end if;
        end if;
      end if;
      if find_length then
        if (format(index) >= '0') and (format(index) <= '9') then
          total_length_int := 10*total_length_int + character'pos(format(index)) - character'pos('0');
        end if;
        if format(index) = '.' then
          find_length := false;
          find_precision := true;
        elsif format(index+1) >= 'A' then
          find_length := false;
          find_type := true;
        end if;
      end if;
      if find_padding then
        if format(index) = '0' then
          if right_justify_int then
            fill_char := '0';
          end if;
        end if;
        find_padding := false;
        if format(index+1) >= 'A' then
          find_type := true;
        else
          find_length := true;
        end if;
      end if;
      if find_sign then
        if format(index) = '-' then
          right_justify_int := false;
        end if;
        if format(index) = '+' then
          add_sign := true;
        end if;
        find_sign := false;
        if format(index+1) <= '-' then
          find_sign := true;
        elsif format(index+1) = '0' then
          find_padding := true;
        elsif format(index+1) >= 'A' then
          find_type := true;
        else
          find_length := true;
        end if;
      end if;
      if format(index) = '%' then
        if format(index+1) <= '-' then
          find_sign := true;
        elsif format(index+1) = '0' then
          find_padding := true;
        elsif format(index+1) >= 'A' then
          find_type := true;
        else
          find_length := true;
        end if;
      end if;
    end loop;
    right_justify := right_justify_int;
    total_length := total_length_int;
    point_precision := point_precision_int;
  end get_format_items;


  ------------------------------------------------------------------------------
  -- formatted string output: converting std_ulogic to character
  ------------------------------------------------------------------------------
  function to_character(value: std_ulogic) return character is
    variable out_value: character;
  begin
    case value is
      when 'U' => out_value := 'U';
      when 'X' => out_value := 'X';
      when '0' => out_value := '0';
      when '1' => out_value := '1';
      when 'Z' => out_value := 'Z';
      when 'W' => out_value := 'W';
      when 'L' => out_value := 'L';
      when 'H' => out_value := 'H';
      when '-' => out_value := '-';
    end case;
    return(out_value);
  end to_character;

  ------------------------------------------------------------------------------
  -- formatted string output: binary integer
  ------------------------------------------------------------------------------
  function sprintf_b(value: std_ulogic_vector) return string is
    variable out_line : line;
  begin
    for index in value'range loop
      write(out_line, to_character(value(index)));
    end loop;
    return(out_line.all);
  end sprintf_b;

  ------------------------------------------------------------------------------
  -- formatted string output: decimal integer
  ------------------------------------------------------------------------------
  function sprintf_d(
    right_justify   : boolean;
    add_sign        : boolean;
    fill_char       : character;
    string_length   : natural;
    value           : integer
  ) return string is
    variable value_line : line;
  begin
    if add_sign and (value >= 0) then
      write(value_line, '+');
    end if;
    write(value_line, value);
    if string_length = 0 then
      return(value_line.all);
    else
      return(pad(value_line.all, string_length, fill_char, right_justify));
    end if;
  end sprintf_d;

  ------------------------------------------------------------------------------
  -- formatted string output: fixed point real
  ------------------------------------------------------------------------------
  function sprintf_f(
    right_justify   : boolean;
    add_sign        : boolean;
    fill_char       : character;
    string_length   : natural;
    point_precision : natural;
    value           : real
  ) return string is
    variable point_precision_int : natural;
    variable integer_part : integer;
    variable decimal_part : natural;
    variable value_line : line;
  begin
    if point_precision = 0 then
      point_precision_int := 6;
    else
      point_precision_int := point_precision;
    end if;
    if value >= 0.0 then
      integer_part := integer(value-0.5);
    else
      integer_part := - integer(-value-0.5);
    end if;
    decimal_part := abs(integer((value-real(integer_part))*(10.0**point_precision_int)));
    if add_sign and (value >= 0.0) then
      write(value_line, '+');
    end if;
    write(value_line, integer_part);
    write(value_line, '.');
    write(value_line, sprintf_d(true, false, '0', point_precision_int, decimal_part));
    if string_length = 0 then
      return(value_line.all);
    else
      return(pad(value_line.all, string_length, fill_char, right_justify));
    end if;
  end sprintf_f;

  ------------------------------------------------------------------------------
  -- formatted string output: hexadecimal integer
  ------------------------------------------------------------------------------
  function sprintf_X(
    extend_unsigned : boolean;
    value           : std_ulogic_vector
  ) return string is
    variable bit_count : positive;
    variable value_line : line;
    variable out_line : line;
    variable nibble: string(1 to 4);
  begin
    bit_count := value'length;
    while (bit_count mod 4) /= 0 loop
      if extend_unsigned then
        write(value_line, to_character('0'));
      else
        write(value_line, to_character(value(value'high)));
      end if;
      bit_count := bit_count + 1;
    end loop;
    write(value_line, sprintf_b(value));
    for index in value_line.all'range loop
      if (index mod 4) = 0 then
        nibble := value_line.all(index-3 to index);
        case nibble is
          when "0000" => write(out_line, 0);
          when "0001" => write(out_line, 1);
          when "0010" => write(out_line, 2);
          when "0011" => write(out_line, 3);
          when "0100" => write(out_line, 4);
          when "0101" => write(out_line, 5);
          when "0110" => write(out_line, 6);
          when "0111" => write(out_line, 7);
          when "1000" => write(out_line, 8);
          when "1001" => write(out_line, 9);
          when "1010" => write(out_line, 'A');
          when "1011" => write(out_line, 'B');
          when "1100" => write(out_line, 'C');
          when "1101" => write(out_line, 'D');
          when "1110" => write(out_line, 'E');
          when "1111" => write(out_line, 'F');
          when others => write(out_line, 'X');
        end case;
      end if;
    end loop;
    return(out_line.all);
  end sprintf_X;


  --============================================================================
  -- formatted string output, interface functions
  --

  ------------------------------------------------------------------------------
  -- integer
  ------------------------------------------------------------------------------
  function sprintf(format : string; value : integer) return string is
    variable right_justify : boolean;
    variable add_sign : boolean;
    variable fill_char : character;
    variable string_length : natural;
    variable point_precision : natural;
    variable format_type : line;
  begin
    get_format_items(format, right_justify, add_sign, fill_char,
                     string_length, point_precision, format_type);
    if format_type.all = "b" then
      if string_length = 0 then
        string_length := 8;
      end if;
      return(sprintf_b(std_ulogic_vector(to_signed(value, string_length+1)(string_length-1 downto 0))));
    elsif format_type.all = "d" then
      return(sprintf_d(right_justify, add_sign, fill_char, string_length, value));
    elsif format_type.all = "f" then
      return(sprintf_f(right_justify, add_sign, fill_char,
                       string_length, point_precision, real(value)));
    elsif (format_type.all = "X") or (format_type.all = "x") then
      if string_length = 0 then
        string_length := 8;
      end if;
      string_length := 4*string_length;
      if format_type.all = "X" then
        return(sprintf_X(false, std_ulogic_vector(to_signed(value, string_length+1)(string_length-1 downto 0))));
      else
        return(lc(sprintf_X(false, std_ulogic_vector(to_signed(value, string_length+1)(string_length-1 downto 0)))));
      end if;
    else
      return("Unhandled format type: '" & format_type.all & "'");
    end if;
  end sprintf;

  ------------------------------------------------------------------------------
  -- real
  ------------------------------------------------------------------------------
  function sprintf(format : string; value : real) return string is
    variable right_justify : boolean;
    variable add_sign : boolean;
    variable fill_char : character;
    variable string_length : natural;
    variable point_precision : natural;
    variable format_type : line;
  begin
    get_format_items(format, right_justify, add_sign, fill_char,
                     string_length, point_precision, format_type);
    if (format_type.all = "d") or (point_precision = 0) then
      return(sprintf_d(right_justify, add_sign, fill_char,
                       string_length, integer(value)));
    elsif format_type.all = "f" then
      return(sprintf_f(right_justify, add_sign, fill_char,
                       string_length, point_precision, value));
    else
      return("Unhandled format type: '" & format_type.all & "'");
    end if;
  end sprintf;

  ------------------------------------------------------------------------------
  -- std_logic
  ------------------------------------------------------------------------------
  function sprintf(format : string; value : std_logic) return string is
    variable right_justify : boolean;
    variable add_sign : boolean;
    variable fill_char : character;
    variable string_length : natural;
    variable point_precision : natural;
    variable format_type : line;
    variable logic_vector: std_logic_vector(1 to 1);
  begin
    get_format_items(format, right_justify, add_sign, fill_char,
                     string_length, point_precision, format_type);
    if (format_type.all = "b") or (format_type.all = "d") or
       (format_type.all = "X") or (format_type.all = "x") then
      logic_vector(1) := value;
      return(sprintf(format, std_ulogic_vector(logic_vector)));
    else
      return("Not a std_logic format: '" & format_type.all & "'");
    end if;
  end sprintf;

  ------------------------------------------------------------------------------
  -- std_ulogic_vector
  ------------------------------------------------------------------------------
  function sprintf(format : string; value : std_ulogic_vector) return string is
    variable right_justify : boolean;
    variable add_sign : boolean;
    variable fill_char : character;
    variable bit_string_length : natural;
    variable point_precision : natural;
    variable format_type : line;
  begin
    get_format_items(format, right_justify, add_sign, fill_char,
                     bit_string_length, point_precision, format_type);
    if format_type.all = "b" then
      return(pad(sprintf_b(value), bit_string_length, fill_char, right_justify));
    elsif format_type.all = "d" then
      return(sprintf_d(right_justify, add_sign, fill_char, bit_string_length, to_integer(unsigned(value))));
    elsif (format_type.all = "X") or (format_type.all = "x") then
      if format_type.all = "X" then
        return(pad(sprintf_X(true, value), bit_string_length, fill_char, right_justify));
      else
        return(lc(pad(sprintf_X(true, value), bit_string_length, fill_char, right_justify)));
      end if;
    else
      return("Not a std_ulogic_vector format: '" & format_type.all & "'");
    end if;
  end sprintf;

  ------------------------------------------------------------------------------
  -- std_logic_vector
  ------------------------------------------------------------------------------
  function sprintf(format : string; value : std_logic_vector) return string is
    variable right_justify : boolean;
    variable add_sign : boolean;
    variable fill_char : character;
    variable string_length : natural;
    variable point_precision : natural;
    variable format_type : line;
  begin
    get_format_items(format, right_justify, add_sign, fill_char,
                     string_length, point_precision, format_type);
    if (format_type.all = "b") or (format_type.all = "d") or
       (format_type.all = "X") or (format_type.all = "x") then
      return(sprintf(format, std_ulogic_vector(value)));
    else
      return("Not a std_logic_vector format: '" & format_type.all & "'");
    end if;
  end sprintf;

  ------------------------------------------------------------------------------
  -- unsigned
  ------------------------------------------------------------------------------
  function sprintf(format : string; value : unsigned) return string is
    variable right_justify : boolean;
    variable add_sign : boolean;
    variable fill_char : character;
    variable string_length : natural;
    variable point_precision : natural;
    variable format_type : line;
  begin
    get_format_items(format, right_justify, add_sign, fill_char,
                     string_length, point_precision, format_type);
    if (format_type.all = "b") or (format_type.all = "d") or
       (format_type.all = "X") or (format_type.all = "x") then
      return(sprintf(format, std_ulogic_vector(value)));
    else
      return("Not an unsigned format: '" & format_type.all & "'");
    end if;
  end sprintf;

  ------------------------------------------------------------------------------
  -- signed
  ------------------------------------------------------------------------------
  function sprintf(format : string; value : signed) return string is
    variable right_justify : boolean;
    variable add_sign : boolean;
    variable fill_char : character;
    variable bit_string_length : natural;
    variable point_precision : natural;
    variable format_type : line;
  begin
    get_format_items(format, right_justify, add_sign, fill_char,
                     bit_string_length, point_precision, format_type);
    if (fill_char = '0') and (value(value'left) = '1') then
      fill_char := '1';
    end if;
    if format_type.all = "b" then
      return(pad(sprintf_b(std_ulogic_vector(value)), bit_string_length, fill_char, right_justify));
    elsif format_type.all = "d" then
      return(sprintf_d(right_justify, add_sign, fill_char, bit_string_length, to_integer(signed(value))));
    elsif (format_type.all = "X") or (format_type.all = "x") then
      if fill_char = '1' then
        fill_char := 'F';
      end if;
      if format_type.all = "X" then
        return(pad(sprintf_X(true, std_ulogic_vector(value)), bit_string_length, fill_char, right_justify));
      else
        return(lc(pad(sprintf_X(true, std_ulogic_vector(value)), bit_string_length, fill_char, right_justify)));
      end if;
    else
      return("Not a signed format: '" & format_type.all & "'");
    end if;
  end sprintf;

  ------------------------------------------------------------------------------
  -- time
  ------------------------------------------------------------------------------
  function sprintf(format : string; value : time) return string is
    variable right_justify : boolean;
    variable add_sign : boolean;
    variable fill_char : character;
    variable string_length : natural;
    variable point_precision : natural;
    variable format_type : line;
    variable scaling : real;
    variable base_time : time;
    variable unit : string(1 to 3);
  begin
    get_format_items(format, right_justify, add_sign, fill_char,
                     string_length, point_precision, format_type);
    if format_type.all(format_type.all'left) = 't' then
      scaling := 10.0**point_precision;
      if format_type.all = "tp" then
        base_time := 1 ps;
        unit := " ps";
      elsif format_type.all = "tn" then
        base_time := 1 ns;
        unit := " ns";
      elsif format_type.all = "tu" then
        base_time := 1 us;
        unit := " us";
      elsif format_type.all = "tm" then
        base_time := 1 ms;
        unit := " ms";
      elsif format_type.all = "ts" then
        base_time := 1 sec;
        unit := " s.";
      else
        return("Undefined time format: '" & format_type.all & "'");
      end if;
      if point_precision = 0 then
        return(sprintf_d(right_justify, add_sign, fill_char,
                         string_length, value/base_time) & unit);
      else
        return(sprintf_f(right_justify, add_sign, fill_char, string_length,
                         point_precision, real(scaling*value/base_time)/scaling) & unit);
      end if;
    else
      return("Not a time format: '" & format_type.all & "'");
    end if;
  end sprintf;


  --============================================================================
  -- formatted string input
  ------------------------------------------------------------------------------

  ------------------------------------------------------------------------------
  -- read a nibble out of a character
  ------------------------------------------------------------------------------
  function sscanf(value : character) return natural is
  begin
    if (value >= '0') and (value <= '9') then
      return(character'pos(value) - character'pos('0'));
    elsif (value >= 'a') and (value <= 'f') then
      return(character'pos(value) - character'pos('a') + 10);
    elsif (value >= 'A') and (value <= 'F') then
      return(character'pos(value) - character'pos('A') + 10);
    else
      return(0);
    end if;
  end sscanf;

  function sscanf(value : character) return nibbleUnsignedType is
  begin
    return(to_unsigned(sscanf(value), nibbleUnsignedType'length));
  end sscanf;

  function sscanf(value : character) return nibbleUlogicType is
    variable unsigned_value : nibbleUnsignedType;
  begin
    unsigned_value := sscanf(value);
    return(std_ulogic_vector(unsigned_value));
  end sscanf;

  ------------------------------------------------------------------------------
  -- read an binary word out of a string
  ------------------------------------------------------------------------------
  function sscanf(value : string) return natural is
    variable integer_value : natural;
  begin
    integer_value := 0;
    for index in value'left to value'right loop
      integer_value := integer_value*16 + sscanf(value(index));
    end loop;
    return(integer_value);
  end;

  function sscanf(value : string) return unsigned is
    variable unsigned_value : unsigned(4*value'length-1 downto 0);
  begin
    unsigned_value := to_unsigned(0,unsigned_value'length);
    for index in value'left to value'right loop
      unsigned_value := shift_left(unsigned_value,4) + to_unsigned(sscanf(value(index)),4);
    end loop;
    return(unsigned_value);
  end;

  function sscanf(value : string) return std_ulogic_vector is
    variable unsigned_value : unsigned(4*value'length-1 downto 0);
  begin
    unsigned_value := sscanf(value);
    return(std_ulogic_vector(unsigned_value));
  end;

  ------------------------------------------------------------------------------
  -- read time from a string
  -- time can be formated as follows:
  --   "1ps" or "1 ps" or " 1 ps " or " 1ps"
  -- possible time units are: hr, min, sec, ms, us, ns, ps, fs
  ------------------------------------------------------------------------------
  procedure sscanf(
     value    : inout line;
     time_val : out time
  ) is
      variable time_line  : line := value;
      variable time_base  : string(1 to 3);
      variable time_value : integer;
      variable time_int   : time;
  begin
    -- remove all spaces and tabs
    rm_all_separators(time_line);

    -- strip time base (3 last characters)
    time_base := time_line(time_line'right-2 to time_line'right);

    -- separate time value and base
    if time_base(2 to 3) = "hr" then
        time_int   := 1 hr;
        time_value := integer'value(time_line(time_line'left to time_line'right -2));
    elsif time_base = "min" then
        time_int   := 1 min;
        time_value := integer'value(time_line(time_line'left to time_line'right -3));
    elsif time_base = "sec" then
        time_int   := 1 sec;
        time_value := integer'value(time_line(time_line'left to time_line'right -3));
    elsif time_base(2 to 3) = "ms" then
        time_int   := 1 ms;
        time_value := integer'value(time_line(time_line'left to time_line'right -2));
    elsif time_base(2 to 3) = "us" then
        time_int   := 1 us;
        time_value := integer'value(time_line(time_line'left to time_line'right -2));
    elsif time_base(2 to 3) = "ns" then
        time_int   := 1 ns;
        time_value := integer'value(time_line(time_line'left to time_line'right -2));
    elsif time_base(2 to 3) = "ps" then
        time_int   := 1 ps;
        time_value := integer'value(time_line(time_line'left to time_line'right -2));
    elsif time_base(2 to 3) = "fs" then
        time_int   := 1 fs;
        time_value := integer'value(time_line(time_line'left to time_line'right -2));
    else
        time_int   := 0 ps;
        time_value := 1;
    end if;

    -- build time from value and base
    time_val := time_int * time_value;

  end;

  function sscanf(value : string) return time is
    variable value_line : line;
    variable time_val   : time;
  begin
    value_line := new string'(value);
    sscanf(value_line, time_val);
    return(time_val);
  end;

END testUtils;
