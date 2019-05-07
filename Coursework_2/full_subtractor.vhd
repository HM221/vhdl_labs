----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2019 14:54:25
-- Design Name: 
-- Module Name: full_subtractor - Behavioral
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

entity full_subtractor is
    port(
        fs_i_bit1   : in STD_LOGIC;
        fs_i_bit2   : in STD_LOGIC;
        fs_i_borrow : in STD_LOGIC;
        fs_o_diff   : out STD_LOGIC;
        fs_o_borrow : out STD_LOGIC
    );
end full_subtractor;

architecture Behavioral of full_subtractor is

    component halfsubtractor
        port(
            hs_i_bit1  : in std_logic;
            hs_i_bit2  : in std_logic;
            hs_o_diff   : out std_logic;
            hs_o_borrow : out std_logic
        );
    end component;
    
    signal hs1_diff   : std_logic := '0';
    signal hs1_borrow : std_logic := '0';
    signal hs2_borrow : std_logic := '0';

begin
    
    HS1 : halfsubtractor
        port map(
            hs_i_bit1   => fs_i_bit1,
            hs_i_bit2   => fs_i_bit2,
            hs_o_diff   => hs1_diff,
            hs_o_borrow => hs1_borrow
        );

    HS2 : halfsubtractor
        port map(
            hs_i_bit1   => hs1_diff,
            hs_i_bit2   => fs_i_borrow,
            hs_o_diff   => fs_o_diff,
            hs_o_borrow => hs2_borrow
        );
    
    fs_o_borrow <= hs1_borrow or hs2_borrow;
    
end Behavioral;
