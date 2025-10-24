ARCHITECTURE studentVersion OF aluDecoder IS
BEGIN

    -- We can (and must) react on all input signals
    -- ALUControl MUST be assigned in each possible case
    -- Only ONE process
    op_switch : process(ALUOp, op, funct3, funct7)
    begin
      -- The structure and values are obviously fake ones
      case ALUOp is
        when "00" =>
            ALUControl <= "000";
        when "11" =>
            ALUControl <= "000";
        when others => -- in all cases not specified before
          -- the "others" statement is MANDATORY ! else the circuit will not know what to do.
          -- we can have other switches and if in any "when xxx =>" statement
          case funct3 is
            when "010" =>
                ALUControl <= "000";
            when "101" =>
                ALUControl <= "000";
            when "001" =>
                -- if statement
                if funct7 = '0' then
                  ALUControl <= "000";
                -- elsif, while also using an AND operator
                elsif (op = '1') AND (funct7 = '1') then
                  ALUControl <= "000";
                -- else
                else
                  ALUControl <= "000";
                end if;
            -- the "others" statement is MANDATORY ! else the circuit will not know what to do.
            when others =>
                ALUControl <= "000";
          end case;
      end case;
    end process op_switch;
    
END ARCHITECTURE studentVersion;

