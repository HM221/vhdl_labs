----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2019 14:54:25
-- Design Name: 
-- Module Name: halfsubtractor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity halfsubtractor is
    Port (
        hs_i_bit1   : in STD_LOGIC;
        hs_i_bit2   : in STD_LOGIC;
        hs_o_diff   : out STD_LOGIC;
        hs_o_borrow : out STD_LOGIC
     );
end halfsubtractor;

architecture Behavioral of halfsubtractor is

begin

    hs_o_diff <= hs_i_bit1 XOR hs_i_bit2;
    hs_o_borrow <= hs_i_bit1 AND (NOT hs_i_bit2);

end Behavioral;
