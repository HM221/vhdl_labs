----------------------------------------------------------------------------------
-- Module Name: fsm_counter - Behavioral
-- Project Name: Loughborough University - 18WSB020 Introduction to FPGA Design
-- Target Devices: ZedBoard - Zynq 7000 (xc7z020clg484pkg)
-- Tool Versions: Vivado 2016.4
-- Description: Simple finite state machine counter RTL description. Inputs are
-- board clock, button that acts as reset, and switches and leds
--
-- Dependencies: None
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- uncomment the following library declaration if using
-- arithmetic functions with signed or unsigned values
-- use ieee.numeric_std.all;

-- uncomment the following library declaration if instantiating
-- any xilinx primitives in this code.
-- library unisim;
-- use unisim.vcomponents.all;

entity fsm_counter is
    port ( 
		clk : 
    );
end fsm_counter;

architecture behavioral of fsm_counter is

        type t_state is (s0, s1, s2);

begin

	

end behavioral;
