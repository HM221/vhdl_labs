----------------------------------------------------------------------------------
-- Module Name: fsm_counter - Testbench
-- Project Name: Loughborough University - 18WSB020 Introduction to FPGA Design
-- Target Devices: ZedBoard - Zynq 7000 (xc7z020clg484pkg)
-- Tool Versions: Vivado 2016.4
-- Description: Simple finite state machine counter testbench file.
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
--use ieee.numeric_std.all;

entity tb_multiplier is
        end tb_multiplier;

architecture behavior of tb_multiplier is

        -- component declaration for the unit under test (uut)

        component ram
                port ( 
                    data : in std_logic_vector(7 downto 0);
                    addr : in natural range 0 to 4;
                    we   : in std_logic;
                    clk  : in std_logic;
                    q    : out std_logic_vector(7 downto 0)
                );
        end component;

        --inputs
        signal input : std_logic_vector(7 downto 0) := "00000000";
        signal addr  : natural range 0 to 4 := 0;
        signal we    : std_logic := '0';
        signal clk   : std_logic;

        --Outputs
        signal q     : std_logic_vector(7 downto 0);        

        -- clock period definitions
        constant clk_period : time := 10 ns;

begin

        -- instantiate the unit under test (uut)
        uut: ram port map (
            data => input,
            addr => addr,
            we   => we,
            clk  => clk,
            q    => q
        );

        -- clock process definitions
        clk_process :process
        begin
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end process;


        -- stimulus process
        stim_proc: process
        begin
        we   <= '1';
        wait for 15 ns;
        for i in 0 to 4 loop
            addr  <= i;
            input <= input + 1;
            wait for clk_period;
        end loop;
        end process;

end;