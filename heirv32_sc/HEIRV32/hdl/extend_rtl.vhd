
ARCHITECTURE rtl OF extend IS
BEGIN

    extend : process(input, src)
    begin
        case src is
            when "00" => -- I-type
                extended <= (12 to 31 => input(31)) &
                    input(31 downto 20) after g_tExt;
            when "01" => -- S-types (stores)
                extended <= (12 to 31 => input(31)) &
                    input(31 downto 25) & input(11 downto 7) after g_tExt;
            when "10" => -- B-type (branches)
                extended <= (12 to 31 => input(31)) & input(7) &
                    input(30 downto 25) & input(11 downto 8) & '0' after g_tExt;
            when "11" => -- J-type (jal)
                extended <= (20 to 31 => input(31)) &
                    input(19 downto 12) & input(20) &
                    input(30 downto 21) & '0' after g_tExt;
            when others => -- impossible
                extended <= (others => '-') after g_tExt;
        end case;
    end process extend;

END ARCHITECTURE rtl;
