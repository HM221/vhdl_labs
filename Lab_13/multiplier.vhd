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
			clk : in std_logic
		)