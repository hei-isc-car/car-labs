
ARCHITECTURE rtl OF bramAddrReducer IS
BEGIN
	-- +2 to srr(2) the address (as it makes +4)
	addrOut <= std_ulogic_vector(addrIn(addrOut'high+2 downto addrOut'low+2));
END ARCHITECTURE rtl;
