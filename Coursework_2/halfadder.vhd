----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.01.2019 17:56:35
-- Design Name: 
-- Module Name: halfadder - Behavioral
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

entity halfadder is
    port(
        ha_i_bit1  : in STD_LOGIC;
        ha_i_bit2  : in STD_LOGIC;
        ha_o_sum   : out STD_LOGIC;
        ha_o_carry : out STD_LOGIC
    );
end halfadder;

architecture Behavioral of halfadder is

begin
    ha_o_sum   <= ha_i_bit1 XOR ha_i_bit2;
    ha_o_carry <= ha_i_bit1 AND ha_i_bit2;
end Behavioral;
