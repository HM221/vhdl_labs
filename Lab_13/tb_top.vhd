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

entity tb_top is
        end tb_top;

architecture behavior of tb_top is

        -- component declaration for the unit under test (uut)

        component top
                port (
                    clk          : in std_logic;
                    data_in      : in integer;
                    a            : in integer;
                    b            : in integer;
                    c            : in integer;
                    ram_addr     : in natural range 0 to 8;
                    ram_we       : in std_logic;
                    data_out     : out std_logic_vector(7 downto 0)
                );
        end component;

        --inputs
        signal clk      : std_logic;
        signal data_in  : integer;
        signal a        : integer;
        signal b        : integer;
        signal c        : integer;
        signal ram_addr : natural range 0 to 8;
        signal ram_we   : std_logic;

        --Outputs
        signal data_out : std_logic_vector(7 downto 0);

        -- clock period definitions
        constant clk_period : time := 10 ns;

begin

        -- instantiate the unit under test (uut)
        uut: top port map (
            clk      => clk,
            data_in  => data_in,
            a        => a,
            b        => b,
            c        => c,
            ram_addr => ram_addr,
            ram_we   => ram_we,
            data_out => data_out
        );

        -- clock process definitions
        clk_process : process
        begin
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end process;
        
        -- stimulus process
        stim_proc : process
        begin
            a <= 2;
            b <= 3;
            c <= 4;
            for i in 0 to 10 loop
                data_in <= i+1;
                ram_addr <= ram_addr + 1;
                if (i = 0) then
                    ram_we <= '1';
                    wait for 3.5*clk_period;
                else
                    wait for 4*clk_period;
                end if;
            end loop;
        end process;

end;