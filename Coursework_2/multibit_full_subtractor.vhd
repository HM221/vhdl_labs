----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2019 14:54:25
-- Design Name: 
-- Module Name: multibit_full_subtractor - Behavioral
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

entity multibit_full_subtractor is
    generic(NUM_BITS:  INTEGER := 4);
    port(
        mbfs_i_val1    : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
        mbfs_i_val2    : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
        mbfs_i_borrow  : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
        mbfs_o_diff    : out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
        mbfs_o_borrow  : out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
        mbfs_underflow : out STD_LOGIC
    );
end multibit_full_subtractor;

architecture Behavioral of multibit_full_subtractor is

    component full_subtractor
        port(
            fs_i_bit1   : in std_logic;
            fs_i_bit2   : in std_logic;
            fs_i_borrow : in std_logic;
            fs_o_diff   : out std_logic;
            fs_o_borrow : out std_logic
        );
    end component;

    signal  tmp_i_bit1  : std_logic_vector (NUM_BITS-1 downto 0);
    signal  tmp_i_bit2  : std_logic_vector (NUM_BITS-1 downto 0);
    signal  tmp_i_borrow : std_logic_vector (NUM_BITS-1 downto 0);
    signal  tmp_o_diff   : std_logic_vector (NUM_BITS-1 downto 0);
    signal  tmp_o_borrow : std_logic_vector (NUM_BITS-1 downto 0);

begin
    GEN_SUB:
    for I in 0 to NUM_BITS-1 generate

            FIRST_BIT : if I = 0 generate
                    FS0: full_subtractor port map (
                    fs_i_bit1   => tmp_i_bit1(I) ,
                    fs_i_bit2   => tmp_i_bit2(I) ,
                    fs_i_borrow => '0' ,
                    fs_o_borrow => tmp_o_borrow(I) ,
                    fs_o_diff   => tmp_o_diff(I)
            );
            end generate FIRST_BIT;

            OTHER_BITS: if I > 0 generate
                    FSX: full_subtractor port map (
                    fs_i_bit1   => tmp_i_bit1(I),
                    fs_i_bit2   => tmp_i_bit2(I),
                    fs_i_borrow => tmp_o_borrow(I-1),
                    fs_o_borrow => tmp_o_borrow(I),
                    fs_o_diff   => tmp_o_diff(I)
            );
            end generate OTHER_BITS;
    end generate GEN_SUB;

    tmp_i_bit1 <= (mbfs_i_val1(0), mbfs_i_val1(1), mbfs_i_val1(2), mbfs_i_val1(3));
    tmp_i_bit2 <= (mbfs_i_val2(0), mbfs_i_val2(1), mbfs_i_val2(2), mbfs_i_val2(3));
    ( mbfs_o_diff(0), mbfs_o_diff(1), mbfs_o_diff(2), mbfs_o_diff(3) )  <= tmp_o_diff;
    ( mbfs_o_borrow(0), mbfs_o_borrow(1), mbfs_o_borrow(2), mbfs_o_borrow(3) ) <= tmp_o_borrow;

    process(mbfs_i_val1, mbfs_i_borrow)
        begin
        if mbfs_i_val1(NUM_BITS-1) = '1' AND mbfs_i_borrow(NUM_BITS-1) = '1' then
            mbfs_underflow <= '1';
        else
            mbfs_underflow <= '0';
        end if;
    end process;
end Behavioral;
