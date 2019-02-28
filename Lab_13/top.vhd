library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity top is
	port
	(
		clk      : in std_logic;
		data_in  : in integer;
		a        : in integer;
		b        : in integer;
		c        : in integer;
		ram_we   : in std_logic;
		ram_addr : natural range 0 to 8;
		data_out : out std_logic_vector(7 downto 0)
	);
	
end entity;

architecture rtl of top is

	component pipeline is
        port
	    (
	        clk           : in std_logic;
	        pipe_data_in  : in integer;
	        a             : in integer;
	        b             : in integer;
	        c             : in integer;
	        pipe_data_out : out std_logic_vector(7 downto 0)
	    );
    end component;

    component ram is
        port
        (
            clk          : in std_logic;
            ram_data_in  : in std_logic_vector(7 downto 0);
            addr         : in natural range 0 to 8;
            we           : in std_logic;
            ram_data_out : out std_logic_vector(7 downto 0)
        );
    end component;
    
    signal pipe_do  : std_logic_vector(7 downto 0);
    signal ram_di   : std_logic_vector(7 downto 0);
    
begin

    PL : pipeline
	    port map
	    (
	        clk           => clk,
	        pipe_data_in  => data_in,
	        a             => a,
	        b             => b,
	        c             => c,
	        pipe_data_out => pipe_do
	    );
        
	 RM : ram
	    port map
	    (
	        clk => clk,
	        ram_data_in => ram_di,
	        addr => ram_addr,
	        we => ram_we,
	        ram_data_out => data_out
	    );
    
    ram_di <= pipe_do;
	
end rtl;
