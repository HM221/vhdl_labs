----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.12.2018 15:16:41
-- Design Name: 
-- Module Name: tb_vending_machine - Behavioral
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

entity tb_vending_machine is
end tb_vending_machine;

architecture Behavioral of tb_vending_machine is

    component vending_machine
        port ( clk         : in STD_LOGIC;
               reset       : in STD_LOGIC;
               coin        : in STD_LOGIC_VECTOR(3 downto 0);
               sensor      : in STD_LOGIC;
               item        : in STD_LOGIC_VECTOR(3 downto 0);
               change      : out STD_LOGIC_VECTOR(3 downto 0);
               change_done : out STD_LOGIC;
               item_done   : out STD_LOGIC
       );
    end component;
    
    --inputs
    signal clk     : std_logic := '0';
    signal reset   : std_logic := '0';
    signal coin    : std_logic_vector := "0000";
    signal sensor  : std_logic := '0';
    signal item    : std_logic_vector := "0000";
    
    --Outputs
    signal change : STD_LOGIC_VECTOR(3 downto 0);
    signal change_done : STD_LOGIC;
    signal item_done : STD_LOGIC;
    
    -- clock period definitions
    constant clk_period : time := 10 ns;
    
begin
    
    -- instantiate the unit under test (uut)
        uut: vending_machine port map (
            clk => clk,
            reset => reset,
            coin => coin,
            sensor => sensor,
            item => item,
            change => change,
            change_done => change_done,
            item_done => item_done
        );

        -- clock process definitions
        clk_process :process
        begin
                clk <= '0';
                wait for clk_period/2;
                clk <= '1';
                wait for clk_period/2;
        end process;


        stim_proc: process
        begin
        wait for 100 ns;
        sensor <= '1';
        wait for 5 ns;
        sensor <= '0';
        wait for 100 ns;
        wait;
        end process;

end Behavioral;
