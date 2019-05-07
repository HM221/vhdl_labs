----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.01.2019 13:05:12
-- Design Name: 
-- Module Name: multibit_full_adder - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multibit_full_adder is
    generic(NUM_BITS:  INTEGER := 4);
    port(
        mbfa_i_val1  : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
        mbfa_i_val2  : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
        mbfa_i_carry : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
        mbfa_o_sum   : out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
        mbfa_o_carry : out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
        mbfa_overflow     : out STD_LOGIC
    );
end multibit_full_adder;

architecture Behavioral of multibit_full_adder is
    component full_adder
        port(
            fa_i_bit1  : in std_logic;
            fa_i_bit2  : in std_logic;
            fa_i_carry : in std_logic;
            fa_o_sum   : out std_logic;
            fa_o_carry : out std_logic
        );
    end component;

    signal  tmp_i_bit1  : std_logic_vector (NUM_BITS-1 downto 0);
    signal  tmp_i_bit2  : std_logic_vector (NUM_BITS-1 downto 0);
    signal  tmp_i_carry : std_logic_vector (NUM_BITS-1 downto 0);
    signal  tmp_o_sum   : std_logic_vector (NUM_BITS-1 downto 0);
    signal  tmp_o_carry : std_logic_vector (NUM_BITS-1 downto 0);

begin
    GEN_ADD:
        for I in 0 to NUM_BITS-1 generate
                FIRST_BIT : if I = 0 generate
                        FA0: full_adder port map (
                        fa_i_bit1  => tmp_i_bit1(I) ,
                        fa_i_bit2  => tmp_i_bit2(I) ,
                        fa_i_carry => tmp_i_carry(I) ,
                        fa_o_carry => tmp_o_carry(I) ,
                        fa_o_sum   => tmp_o_sum(I)
                );
                end generate FIRST_BIT;

                OTHER_BITS: if I > 0 generate
                        FAX: full_adder port map (
                        fa_i_bit1  => tmp_i_bit1(I),
                        fa_i_bit2  => tmp_i_bit2(I),
                        fa_i_carry => tmp_o_carry(I-1),
                        fa_o_carry => tmp_o_carry(I),
                        fa_o_sum   => tmp_o_sum(I)
                );
                end generate OTHER_BITS;
        end generate GEN_ADD;
        
    tmp_i_bit1 <= (mbfa_i_val1(0), mbfa_i_val1(1), mbfa_i_val1(2), mbfa_i_val1(3));
    tmp_i_bit2 <= (mbfa_i_val2(0), mbfa_i_val2(1), mbfa_i_val2(2), mbfa_i_val2(3));
    ( mbfa_o_sum(0), mbfa_o_sum(1), mbfa_o_sum(2), mbfa_o_sum(3) ) <= tmp_o_sum;
    ( mbfa_o_carry(0), mbfa_o_carry(1), mbfa_o_carry(2), mbfa_o_carry(3) ) <= tmp_o_carry;
        
    process(mbfa_i_val1, mbfa_i_carry)
        begin
        if mbfa_i_val1(NUM_BITS-1) = '1' AND mbfa_i_carry(NUM_BITS-1) = '1' then
            mbfa_overflow <= '1';
        else
            mbfa_overflow <= '0';
        end if;
    end process;
            
end Behavioral;
