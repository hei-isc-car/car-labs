-- Risc-V ed. 2022 page 250 (pdf page 273)

ARCHITECTURE rtl OF ALU IS

    signal lvec_res : std_ulogic_vector(res'range);
	signal lsig_zero : std_ulogic;

BEGIN

    lsig_zero <= '1' when lvec_res = (lvec_res'range => '0') else '0';
	zero <= lsig_zero after g_tALU;
    res <= lvec_res after g_tALU;

    alu : process(srcA, srcB, ctrl)
    begin
        case ctrl is
            when "000" => -- add
                lvec_res <= std_ulogic_vector(resize(
                    unsigned(srcA) + unsigned(srcB), lvec_res'length
                ));
            when "001" => -- substract
                lvec_res <= std_ulogic_vector(resize(
                    unsigned(srcA) - unsigned(srcB), lvec_res'length
                ));
            when "010" => -- AND
                lvec_res <= srcA and srcB;
            when "011" => -- OR
                lvec_res <= srcA or srcB;
            when "101" => -- SLT
                if srcA < srcB then
                    lvec_res <= (lvec_res'high downto 1 => '0') & '1';
                else
                    lvec_res <= (lvec_res'high downto 1 => '0') & '0';
                end if;
            when others => -- unknown
                lvec_res <= (others => '-');
        end case;
    end process alu;

END ARCHITECTURE rtl;
