library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity pipeline is
    --generic (L : integer);
	port
	(
		clk		 : in std_logic;
		pipe_data_in	 : in integer;
		pipe_data_out : out std_logic_vector(7 downto 0);
		a        : in integer;
		b        : in integer;
		c        : in integer
	);
	
end entity;

architecture rtl of pipeline is

	component multiplier
	   --generic (N : integer);
	   port
	   (
	       input1 : in integer;
	       input2 : in integer;
	       output : out integer
	   );
	end component;
	
	signal input_buffer1  : integer;
	signal input_buffer2  : integer;
	signal input_buffer3  : integer;
	signal output_buffer1 : integer;
	signal output_buffer2 : integer;
	signal output_buffer3 : integer;

begin

	MP1 : multiplier
	   --generic map (N => 4);
	   port map
	   (
	       input1 => pipe_data_in,
	       input2 => a,
	       output => input_buffer1
	   );
	
	MP2 : multiplier
	   --generic map (N => 8)
	   port map
	   (
	       input1 => output_buffer1,
	       input2 => b,
	       output => input_buffer2
	   );
	
	MP3 : multiplier
	   port map
	   (
	       input1 => output_buffer2,
	       input2 => c,
	       output => input_buffer3
	   );
	   
	process(clk)
	begin
	   if (rising_edge(clk)) then
	       output_buffer1 <= input_buffer1;
	       output_buffer2 <= input_buffer2;
	       output_buffer3 <= input_buffer3;
	   end if;
	end process;
	
	pipe_data_out <= std_logic_vector(to_unsigned(output_buffer3, 8));
	
end rtl;
