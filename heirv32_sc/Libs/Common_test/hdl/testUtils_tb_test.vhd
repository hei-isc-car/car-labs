LIBRARY std;
  USE std.textio.all;
LIBRARY Common_test;
  USE Common_test.testUtils.all;

ARCHITECTURE test OF testUtils_tb IS
BEGIN

  process
    variable test_line, result_line : LINE;
  begin

    print("Integers, right justified");
    print("  |" & sprintf("%6d", 12) & "|    12|");
    print("  |" & sprintf("%06d", 12) & "|000012|");
    print("  |" & sprintf("%+6d", 12) & "|   +12|");
    print("  |" & sprintf("%+06d", 12) & "|+00012|");
    print("  |" & sprintf("%6d", -12) & "|   -12|");
    print("  |" & sprintf("%06d", -12) & "|-00012|");
    print("Integers, left justified");
    print("  |" & sprintf("%-6d", 12) & "|12    |");
    print("  |" & sprintf("%-06d", 12) & "|12    |");
    print("  |" & sprintf("%-+6d", 12) & "|+12   |");
    print("  |" & sprintf("%-+06d", 12) & "|+12   |");
    print("  |" & sprintf("%-6d", -12) & "|-12   |");
    print("  |" & sprintf("%-06d", -12) & "|-12   |");
    print("Integers, others");
    print("  |" & sprintf("%d", 12) & "|12|");
    print("  |" & sprintf("%6tu", 12) & "|");
    print("  |" & sprintf("%6d", 123456) & "|123456|");
    print("  |" & sprintf("%6d", 12345678) & "|#45678|");
    print("  |" & sprintf("%f", 12) & "|12.000000|");
    print("  |" & sprintf("%10f", 12) & "| 12.000000|");
    print("  |" & sprintf("%8.3f", 12) & "|  12.000|");
    print("  |" & sprintf("%b", 12) & "|00001100|");
    print("  |" & sprintf("%4b", 12) & "|1100|");
    print("  |" & sprintf("%6b", 12) & "|001100|");
    print("  |" & sprintf("%X", 12) & "|0000000C|");
    print("  |" & sprintf("%4x", 12) & "|000c|");
    print("  |" & sprintf("%2X", 12) & "|0C|");

    print(cr & "Reals, integer rounding");
    print("  |" & sprintf("%6d", 1.3) & "|     1|");
    print("  |" & sprintf("%6d", 1.5) & "|     2|");
    print("  |" & sprintf("%6d", 1.7) & "|     2|");
    print("Reals, right justified");
    print("  |" & sprintf("%8.3f", 1.03) & "|   1.030|");
    print("  |" & sprintf("%8.3f", 1.07) & "|   1.070|");
    print("  |" & sprintf("%08.3f", 1.03) & "|0001.030|");
    print("  |" & sprintf("%+08.3f", 1.03) & "|+001.030|");
    print("  |" & sprintf("%8.3f", -1.03) & "|  -1.030|");
    print("  |" & sprintf("%8.3f", -1.07) & "|  -1.070|");
    print("Reals, left justified");
    print("  |" & sprintf("%-8.3f", 1.3) & "|1.300   |");
    print("  |" & sprintf("%-8.3f", 1.7) & "|1.700   |");
    print("  |" & sprintf("%-08.3f", 1.3) & "|1.300   |");
    print("  |" & sprintf("%-+08.3f", 1.3) & "|+1.300  |");
    print("  |" & sprintf("%-8.3f", -1.3) & "|-1.300  |");
    print("  |" & sprintf("%-8.3f", -1.7) & "|-1.700  |");

    print(cr & "Logic values");
    print("  |" & sprintf("%b", '0') & "|0|");
    print("  |" & sprintf("%3b", '1') & "|  1|");
    print("  |" & sprintf("%-3d", '0') & "|0  |");
    print("  |" & sprintf("%3X", '1') & "|  1|");

    print(cr & "Logic vectors, binary");
    print("  |" & sprintf("%b", std_ulogic_vector'("1100")) & "|1100|");
    print("  |" & sprintf("%3b", std_logic_vector'("1100")) & "|#00|");
    print("  |" & sprintf("%4b", unsigned'("1100")) & "|1100|");
    print("  |" & sprintf("%8b", signed'("1100")) & "|    1100|");
    print("  |" & sprintf("%-8b", signed'("1100")) & "|1100    |");
    print("  |" & sprintf("%08b", unsigned'("1100")) & "|00001100|");
    print("  |" & sprintf("%08b", signed'("1100")) & "|11111100|");
    print("Logic vectors, hexadecimal");
    print("  |" & sprintf("%X", std_ulogic_vector'("1100101011111110")) & "|CAFE|");
    print("  |" & sprintf("%3X", std_logic_vector'("1100101011111110")) & "|#FE|");
    print("  |" & sprintf("%4x", unsigned'("1100101011111110")) & "|cafe|");
    print("  |" & sprintf("%8X", signed'("1100101011111110")) & "|    CAFE|");
    print("  |" & sprintf("%02X", unsigned'("1100")) & "|0C|");
    print("  |" & sprintf("%02X", signed'("1100")) & "|FC|");
    print("Logic vectors, decimal");
    print("  |" & sprintf("%d", std_ulogic_vector'("1100")) & "|12|");
    print("  |" & sprintf("%d", unsigned'("1100")) & "|12|");
    print("  |" & sprintf("%d", signed'("1100")) & "|-4|");
    print("Logic vectors, others");
    print("  |" & sprintf("%8tu", std_ulogic_vector'("1100")) & "|");

    print(cr & "Time");
    print("  |" & sprintf("%9tu", 1.3 us) & "|        1 us|");
    print("  |" & sprintf("%9.3tu", 1.3 us) & "|    1.300 us|");
    print("  |" & sprintf("%10tu", 1.3 us) & "|         1 us|");

    print(cr & "Lines");
    test_line := new string'("Hello brave new world!");
    read_first(test_line, result_line);
    print("  |" & result_line.all & "¦"& test_line.all & "|Hello¦brave new world!|");

    wait;
  end process;

END ARCHITECTURE test;
