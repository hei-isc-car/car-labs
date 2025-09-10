ARCHITECTURE studentVersion OF mainDecoder IS
BEGIN

	type_switch : process(op) -- we react on changes of op - purely combinatorial
    begin
      -- We switch on op with "case op is". The C equivalent:
      -- switch(op){
      -- case 0:
      --  ...
      -- case 1:
      --  ...
      -- default:
      -- ...
      -- }
      case op is
          when "0000000" => -- when op corresponds to "0000000", do something (fake values)
              -- when assigning a std_ulogic (i.e. 1 bit), use only on tick as "myUlogic <= '0';"
              regwrite  <= '0';
              -- when assigning vectors, use double quotation marks as "myVector <= "0101000101110";"
              -- most left bit is the MSB - here 0b0101000101110 = 2606
              immSrc    <= "00";
              ALUSrc    <= '0';
              memWrite  <= '0';
              resultSrc <= "00";
              branch    <= '0';
              ALUOp     <= "00";
              jump      <= '0';
          when "0000001" => -- when op corresponds to "0000001", do something (fake values)
              regwrite  <= '0';
              immSrc    <= "00";
              ALUSrc    <= '0';
              memWrite  <= '0';
              resultSrc <= "00";
              branch    <= '0';
              ALUOp     <= "00";
              jump      <= '0';
          when others => -- in all cases not specified before, we let the synthesis pick 0 or 1 FOR NON-ESSENTIAL signals only
            -- the "others" statement is MANDATORY ! else the circuit will not know what to do.
              regwrite  <= '0';
              immSrc    <= "--";
              ALUSrc    <= '-';
              memWrite  <= '0';
              resultSrc <= "--";
              branch    <= '0';
              ALUOp     <= "--";
              jump      <= '0';
      end case;
    end process type_switch;

END ARCHITECTURE studentVersion;
