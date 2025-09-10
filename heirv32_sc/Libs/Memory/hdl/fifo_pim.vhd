library Common;
  use Common.CommonLib.all;

architecture pim of FIFO_bram is

  type mem_t is array (depth-1 downto 0) of std_ulogic_vector(dataIn'range);
  subtype mem_range_r is natural range requiredBitNb(depth)-1 downto 0;
  subtype ptr_range_r is natural range requiredBitNb(depth)+1-1 downto 0;

	signal mem 				: mem_t := (others => (others => '0'));

	signal full_int				: std_logic;
	signal empty_int			: std_logic;
	signal write_error		: std_logic;
	signal read_error		: std_logic;
	signal read_ptr			: unsigned(ptr_range_r);
	signal read_ptr_next	: unsigned(ptr_range_r);
	signal write_ptr		: unsigned(ptr_range_r);
	signal write_ptr_next	: unsigned(ptr_range_r);

	signal used_int 		: unsigned(ptr_range_r);

begin
  -----------------------------------------------------------------------------
  -- Free / used
  -----------------------------------------------------------------------------

  fifo_count_proc: process(reset, clock)
  begin
  	if reset = '1' then
  		used_int <= (others => '0');
  	elsif rising_edge(clock) then
  		if write = '1' and full_int = '0' then
  			used_int <= used_int + 1;
  		end if;
  		if read = '1' and empty_int = '0' then
  			used_int <= used_int - 1;
  		end if;
  
  		-- Simultaneous read/write -> no change
  		-- ignore full_int, since it is valid
  		if write = '1' and read = '1' and empty_int = '0' then
  			used_int <= used_int;
  		end if;  
  	end if;
  end process;


  -----------------------------------------------------------------------------
  -- FIFO status
  -----------------------------------------------------------------------------

  full_int	<= '1' when (write_ptr(write_ptr'left) /= read_ptr(read_ptr'left))
                and ((write_ptr(mem_range_r) = read_ptr(mem_range_r)))
    else '0';
  empty_int	<= '1' when (write_ptr = read_ptr) else '0';

  full <= full_int;
  empty <= empty_int;

  write_ptr_next <= write_ptr + 1;
  read_ptr_next <= read_ptr + 1;


  -----------------------------------------------------------------------------
  -- FIFO pointers
  -----------------------------------------------------------------------------

  fifo_ptr_proc: process(reset, clock)
  begin
  	if reset = '1' then
  		write_ptr <= (others => '0');
  		read_ptr <= (others => '0');
  		write_error <= '0';
  		read_error <= '0';	
  	elsif rising_edge(clock) then
  		write_error <= '0';
  		read_error <= '0';	
  		if write = '1' then
  			if full_int = '0' or read = '1' then
  				write_ptr <= write_ptr_next;
  			else
  				write_error <= '1';
  			end if;
  		end if;
  		if read = '1' then
  			if empty_int = '0' then
  				read_ptr <= read_ptr_next;
  			else
  				read_error <= '1';
  			end if;
  		end if;
  	end if;
  end process;


  -----------------------------------------------------------------------------
  -- FIFO RAM
  -----------------------------------------------------------------------------

  fifo_out_proc : process(clock)
  begin
  	if rising_edge(clock) then
  		dataOut <= mem(to_integer(read_ptr(mem_range_r)));
  	end if;
  end process;

  fifo_in_proc : process(clock)
  begin
  	if rising_edge(clock) then
  		if write = '1' and full_int = '0' then
  			mem(to_integer(write_ptr(mem_range_r))) <= dataIn;
  		end if;
  	end if;
  end process;

end pim;

