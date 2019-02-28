library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier is
    
    --generic (N : integer);
    
	port
	(
		input1 : in integer;
		input2 : in integer;
		output : out integer
	);
	
end multiplier;

architecture behav of multiplier is
begin

    output <= input1 * input2;

end behav;