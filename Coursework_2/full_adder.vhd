----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.01.2019 16:53:55
-- Design Name: 
-- Module Name: full_adder - Behavioral
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

entity full_adder is
    port(
        fa_i_bit1  : in STD_LOGIC;
        fa_i_bit2  : in STD_LOGIC;
        fa_i_carry : in STD_LOGIC;
        fa_o_sum   : out STD_LOGIC;
        fa_o_carry : out STD_LOGIC
    );
end full_adder;

architecture Behavioral of full_adder is

    component halfadder
        port(
            ha_i_bit1  : in std_logic;
            ha_i_bit2  : in std_logic;
            ha_o_sum   : out std_logic;
            ha_o_carry : out std_logic
        );
    end component;
    
    signal ha1_sum   : std_logic;
    signal ha1_carry : std_logic;
    signal ha2_carry : std_logic;
    
begin

    HA1 : halfadder
        port map(
            ha_i_bit1  => fa_i_bit1,
            ha_i_bit2  => fa_i_bit2,
            ha_o_sum   => ha1_sum,
            ha_o_carry => ha1_carry
        );

    HA2 : halfadder
        port map(
            ha_i_bit1  => ha1_sum,
            ha_i_bit2  => fa_i_carry,
            ha_o_sum   => fa_o_sum,
            ha_o_carry => ha2_carry
        );
    
    fa_o_carry <= ha1_carry OR ha2_carry;
    
end Behavioral;
