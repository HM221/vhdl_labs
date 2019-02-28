library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ram is
	port
	(
		ram_data_in	 : in std_logic_vector(7 downto 0);
		addr	     : in natural range 0 to 8;
		we		     : in std_logic;
		clk		     : in std_logic;
		ram_data_out : out std_logic_vector(7 downto 0)
	);
	
end entity;

architecture rtl of ram is

	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector(7 downto 0);
	type memory_t is array(10 downto 0) of word_t;
	
	-- Declare the RAM signal.
	signal ram : memory_t;
	
	-- Register to hold the address
	signal addr_reg : natural range 0 to 8;

begin

	process(clk)
	begin
		if(rising_edge(clk)) then
			if(we = '1') then
				ram(addr) <= ram_data_in;
			end if;
			
			-- Register the address for reading
			addr_reg <= addr;
		end if;
	
	end process;
	
	ram_data_out <= ram(addr_reg);
	
end rtl;
