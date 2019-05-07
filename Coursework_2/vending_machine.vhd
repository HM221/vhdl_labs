----------------------------------------------------------------------------------
-- Company: Loughborough University
-- Engineer: Henrikas Matusevicius
-- 
-- Create Date: 23.12.2018 15:17:56
-- Design Name: 
-- Module Name: vending_machine - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

-- uncomment the following library declaration if using
-- arithmetic functions with signed or unsigned values
-- use ieee.numeric_std.all;

-- uncomment the following library declaration if instantiating
-- any xilinx primitives in this code.
-- library unisim;
-- use unisim.vcomponents.all;

entity vending_machine is
    generic(NUM_BITS:  INTEGER := 4);
    port ( clk          : in STD_LOGIC;
           reset        : in STD_LOGIC;
           coin         : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
           sensor       : in STD_LOGIC;
           item         : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
           change       : out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
           change_done  : out STD_LOGIC;
           item_done    : out STD_LOGIC
   );
end vending_machine;

architecture behavioral of vending_machine is

    component multibit_full_adder
        port(
            mbfa_i_val1   : in std_logic_vector;
            mbfa_i_val2   : in std_logic_vector;
            mbfa_i_carry  : in std_logic_vector;
            mbfa_o_sum    : out std_logic_vector;
            mbfa_o_carry  : out std_logic_vector;
            mbfa_overflow : out std_logic
        );
    end component;
    
    component multibit_full_subtractor
        port(
            mbfs_i_val1    : in std_logic_vector;
            mbfs_i_val2    : in std_logic_vector;
            mbfs_i_borrow  : in std_logic_vector;
            mbfs_o_diff    : out std_logic_vector;
            mbfs_o_borrow  : out std_logic_vector;
            mbfs_underflow : out std_logic
        );
    end component;
    
    -- Item Arrays and Signals
    type item_cost is array (NUM_BITS-1 downto 0) of std_logic;
    type item_storage is array (0 to 15) of item_cost;
    signal selected_item : item_storage := ("0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111",
                                            "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111");
    signal selection : INTEGER;
    
    -- Coin Validation Signals
    signal coin_valid : std_logic;
    
    -- Coin Dispenser Status Signals
    signal bank : INTEGER := 100;
    
    -- State signals:
    type t_state is (S0, S1, S2, S3);
    signal state, next_state : t_state;
    
    -- Addition signals:
    signal number_1_add   : std_logic_vector(NUM_BITS-1 downto 0) := "0000";
    signal number_2_add   : std_logic_vector(NUM_BITS-1 downto 0);
    signal sum            : std_logic_vector(NUM_BITS-1 downto 0);
    signal carry_in       : std_logic_vector(NUM_BITS-1 downto 0);
    signal carry_out      : std_logic_vector(NUM_BITS-1 downto 0);
    signal overflow       : std_logic;
    
    -- Subtraction signals:
    signal number_1_sub   : std_logic_vector(NUM_BITS-1 downto 0);
    signal number_2_sub   : std_logic_vector(NUM_BITS-1 downto 0);
    signal diff           : std_logic_vector(NUM_BITS-1 downto 0);
    signal borrow_in      : std_logic_vector(NUM_BITS-1 downto 0);
    signal borrow_out     : std_logic_vector(NUM_BITS-1 downto 0);
    signal underflow      : std_logic;
    
begin
    
    MBFA : multibit_full_adder
        port map(
            mbfa_i_val1   => number_1_add,
            mbfa_i_val2   => number_2_add,
            mbfa_i_carry  => carry_in,
            mbfa_o_sum    => sum,
            mbfa_o_carry  => carry_out,
            mbfa_overflow => overflow
        );
    
    MBFS : multibit_full_subtractor
        port map(
            mbfs_i_val1    => number_1_sub,
            mbfs_i_val2    => number_2_sub,
            mbfs_i_borrow  => borrow_in,
            mbfs_o_diff    => diff,
            mbfs_o_borrow  => borrow_out,
            mbfs_underflow => underflow
        );
    
    -- fsm register, update the actual state with the next state
    process (clk, reset)     
    begin
        if reset = '1' then
            state        <= S1;
            item_done    <= '0';
            change_done  <= '0';
            change       <= "0000";
            carry_in     <= "0000";      
            carry_out    <= "0000"; 
            overflow     <= '0';
            number_1_sub <= "0000"; 
            number_2_sub <= "0000"; 
            diff         <= "0000"; 
            borrow_in    <= "0000"; 
            borrow_out   <= "0000"; 
            underflow    <= '0';
        elsif clk' event and clk = '1' then
            state <= next_state;
        end if;
    end process;
    
    -- Clock divider
    
    -- FSM
    process (state, sensor, coin_valid, sum, coin)
    begin
        case state is
            -- Coin Insertion and Validation State
            when S0 =>
                change <= "0000";
                change_done <= '0';
                item_done <= '0';
                
                if sensor = '1' AND coin_valid = '1' then
                    number_2_add <= coin;
                    next_state <= S0;
                elsif sensor = '1' AND coin_valid = '0' then
                    change <= sum;
                    change_done <= '1';
                    sum <= "0000";             -- Resetting Multibit Full Adder's values
                    number_1_add <= "0000"; -- Resetting Multibit Full Adder's values
                    number_2_add <= "0000"; -- Resetting Multibit Full Adder's values
                    next_state <= S0;
                elsif sensor = '0' then
                    next_state <= S1;
                end if;
                
            -- Item Selection State
            when S1 =>
                if item > "0000" then
                    number_1_sub <= sum;
                    selection <= to_integer(unsigned(item));
                    number_2_sub <= std_logic_vector(selected_item(selection));
                    next_state <= S2;
                else
                    next_state <= S1;
                end if;
            
            -- Coin Dispenser Status State
            when S2 =>
                if bank >= diff then
                    next_state <= S3;
                else
                    change <= sum;
                    change_done <= '1';
                    next_state <= S0;
                end if;
                
            -- Change and Item Dispensing State
            when S3 =>
                change <= diff;
                change_done <= '1';
                item_done <= '1';
                next_state <= S0;
        end case;
    end process;

    -- Overflow handling
    process(overflow)
    begin
        if overflow = '1' then
            change <= sum;
            change_done <= '1';
            number_1_add <= "0000";
            number_2_add <= "0000";  
            sum <= "0000";           
            carry_in <= "0000";      
            carry_out <= "0000"; 
            overflow <= '0';
            next_state <= S0;
        end if;
    end process;
    
    -- Underflow handling
    process(underflow)
    begin
        if underflow = '1' then
            change <= sum;
            change_done <= '1';
            number_1_sub <= "0000"; 
            number_2_sub <= "0000"; 
            diff <= "0000"; 
            borrow_in <= "0000"; 
            borrow_out <= "0000"; 
            underflow <= '0';
            next_state <= S1;
        end if;
    end process;

end behavioral;