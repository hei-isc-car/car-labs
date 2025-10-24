
ARCHITECTURE rtl OF lut5 IS
BEGIN
  out1 <= std_ulogic(
    g_lut(to_integer(
      unsigned(
        std_ulogic_vector'(in5 & in4 & in3 & in2 & in1)
      )
    ))
  );
END ARCHITECTURE rtl;
