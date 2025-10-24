LIBRARY Common;
  USE Common.commonLib.all;
LIBRARY Common_test;
  USE Common_test.testUtils.all;

ARCHITECTURE test OF commonLib_tb IS
  constant maxPowOf2: positive := 10;
  constant indent: string(1 to 2) := (others => ' ');
BEGIN

  process
    variable value, bitNb: positive;
  BEGIN
    print("testing function " & '"' & "requiredBitNb" & '"');
    for index in 1 to maxPowOf2 loop
      for offset in -1 to 1 loop
        value := 2**index + offset;
        bitNb := requiredBitNb(value);
        print(indent & "requiredBitNb(" & sprintf("%d", value) & ") = " & sprintf("%d", bitNb));
      end loop;
      print("");
    end loop;
    wait;
  end process;

END ARCHITECTURE test;
