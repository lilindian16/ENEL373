----------------------------------------------------------------------------------
-- Students: JAIME SEQUIERA, ZOREN DELA CRUZ, ELLIS LAWRENCE
-- ID: 42408823,98672643,82612826 
-- 
-- Module Name: ALU_CODE_TB - Testbench
-- Project Name: ENEL373 ALU Project
-- Target Devices: NEXUS4DDR FGPA BOARD
--
-- Description: THIS IS THE ALU CODE USED FOR RUNNING THROUGH THE TESTBENCH.
-- OPERAND A IS GIVEN THE VALUE 00001111 AND OPERAND B IS GIVEN THE VALUE 00000011.
-- THE TEST BENCH USES THE PROGRAM AND RUNS THROUGH ALL THE OP CODES PRODUCING AN ANSWER.
-- THE RESULTS FROM THE TESTBENCH DETERMINE IF THE ALU AND REGISTERS IS WORKING CORRECTLY.
-- 
-- Revision: FINAL
-- 
----------------------------------------------------------------------------------

-- Library calls
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_code_tb is
--  Port ( );
end ALU_code_tb;

architecture Behavioral of ALU_code_tb is
    
    -- Defining the arithmetic logic unit component
    component ALU_code
        Port ( operation : in STD_LOGIC_VECTOR (3 downto 0);
        A, B : in std_logic_vector (7 downto 0);
        RESET: in std_logic;
        ENABLE, X : IN std_logic;
        result : out std_logic_vector (7 downto 0) );
    end component;
    
    -- Defining all the signals required
    Signal operation: STD_LOGIC_VECTOR (3 downto 0);
    Signal A, B : std_logic_vector (7 downto 0);
    Signal RESET: std_logic;
    Signal ENABLE, X : std_logic;
    Signal result : std_logic_vector (7 downto 0);
    constant ClockPeriod : TIME := 50 ns;

begin

    UUT : ALU_code port map ( operation => operation, A => A, B => B, RESET => RESET, ENABLE => ENABLE, X => X, RESULT => RESULT);
    
    process 
        begin 
        -- Reset state for 100 ns
        wait for 100 ns;
        
        -- Initialise all the input values
        Reset <= '0';               
        Enable <= '1';
        X <= '1';
        A <= "00001111";                        -- A = 15
        B <= "00000011";                        -- B = 3
        
        -- Changing the values of the operations 
        operation <= "0001";            -- AND logic operation
        wait for 100 ns;
        operation <= "0010";            -- OR logic operation
        wait for 100 ns;
        operation <= "0100";            -- Addition arithmetic
        wait for 100 ns;
        operation <= "1000";            -- Subtract arithmetic
        wait for 100 ns;
        operation <= "0000";            -- XOR logic operation
        wait for 100ns;
        Reset <= '1';
        wait;
        
    end process;
end Behavioral;

