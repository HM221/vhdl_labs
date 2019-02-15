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

entity tb_fsm_counter is
        end tb_fsm_counter;

architecture behavior of tb_fsm_counter is

        -- component declaration for the unit under test (uut)

        component fsm_counter
                port ( GCLK : in STD_LOGIC;
                       BTNC : in STD_LOGIC; -- centre button 
                       BTNL : in STD_LOGIC; -- left button 
                       SW0  : in STD_LOGIC;
                       LD0 : out STD_LOGIC;
                       LD1 : out STD_LOGIC;
                       LD2 : out STD_LOGIC;
                       LD3 : out STD_LOGIC;
                       LD4 : out STD_LOGIC
               );
        end component;


        --inputs
        signal GCLK : std_logic := '0';
        signal BTNC : std_logic := '0';
        signal BTNL : std_logic := '0';
        signal SW0  : std_logic := '0';

        --Outputs
        signal LD0 : STD_LOGIC;
        signal LD1 : STD_LOGIC;
        signal LD2 : STD_LOGIC;
        signal LD3 : STD_LOGIC;
        signal LD4 : STD_LOGIC;

        -- clock period definitions
        constant clk_period : time := 10 ns;

begin

        -- instantiate the unit under test (uut)
        uut: fsm_counter port map (
                                    GCLK => GCLK,
                                    BTNC => BTNC,
                                    BTNL => BTNL,
                                    SW0  => SW0,
                                    LD0  => LD0,
                                    LD1  => LD1,
                                    LD2  => LD2,
                                    LD3  => LD3,
                                    LD4  => LD4
                                  );

        -- clock process definitions
        clk_process :process
        begin
                GCLK <= '0';
                wait for clk_period/2;
                GCLK <= '1';
                wait for clk_period/2;
        end process;


        -- stimulus process
        stim_proc: process
        begin
                -- hold BTNC state for 100 ns.
                wait for 100 ns;
                BTNC <= '1';
                wait for clk_period;
                BTNC <= '0';
                SW0  <= '0';
                wait for clk_period*10;
                SW0  <= '1';  -- press the button 
                wait for clk_period*1;
                SW0  <= '0';  -- release the button
                wait for clk_period*30;
                SW0  <= '1';  -- press the button
                wait for clk_period*5;
                SW0  <= '0';  -- release the button
                wait for clk_period*42;
                SW0  <= '1';  -- press the button
                wait for clk_period*28;
                SW0  <= '0';  -- release the button
                wait for clk_period*10;
                SW0  <= '1';  -- press the button
                wait for clk_period*1;
                SW0  <= '0';  -- release the button
                wait;
        end process;

end;