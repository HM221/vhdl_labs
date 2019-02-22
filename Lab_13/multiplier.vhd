library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier is

	port
	(
		rst : std_logic;
		clk : std_logic
	);
	
end multiplier;

architecture behav of multiplier is

	component pipeline is
		port
		(
			clk : in std_logic;
			data_in : in std_logic_vector(7 downto 0);
			data_out : out std_logic_vector(7 downto 0);
			a : in std_logic_vector(7 downto 0);
			b : in std_logic_vector(7 downto 0);
			c : in std_logic_vector(7 downto 0)
		);
	end component;
	
	component ram is
	   port
	   (
	       signal clk : in std_logic;
	       signal di  : in std_logic_vector(7 downto 0);
	       signal a   : in std_logic_vector(4 downto 0);
	       signal we  : in std_logic;
	       signal do  : out std_logic_vector(7 downto 0)
	   );
    end component;

begin

    

end behav;