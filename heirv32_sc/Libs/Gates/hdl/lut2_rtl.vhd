
ARCHITECTURE rtl OF lut2 IS
BEGIN
  out1 <= std_ulogic(
    g_lut(to_integer(
      unsigned(
        std_ulogic_vector'(in2 & in1)
      )
    ))
  );
END ARCHITECTURE rtl;
