----------------------------------------------------------------------------------
-- Students: JAIME SEQUIERA, ZOREN DELA CRUZ, ELLIS LAWRENCE
-- ID: 42408823,98672643,82612826 
-- 
-- Module Name: CONTROL_UNIT - Behvaioural
-- Project Name: ENEL373 ALU Project
-- Target Devices: NEXUS4DDR FGPA BOARD
--
-- Description: THE PURPOSE OF THE CONTROL UNIT IS TO ENABLE THE REGISTERS AND LINK IT TO THE LED ARRAY. 
-- THE LED ARRAY IS USED TO DISPLAY VALUES THE CURRENT STATE, THE CHOSEN OPERANDS AND THE FINAL RESULT.
-- 
-- Revision: FINAL
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is
  Port ( Z : in STD_LOGIC_VECTOR (1 downto 0);
         regA, regB, result: in STD_LOGIC_VECTOR(7 downto 0);
         opCode : in STD_LOGIC_VECTOR (3 DOWNTO 0);
         s0, s1, s2, s3: out STD_LOGIC;
         lights: out STD_LOGIC_VECTOR(7 downto 0)); 
end Control_Unit;

architecture Behavioral of Control_Unit is

begin
process (Z)
    begin
    case Z is 
    when "00" =>                    -- When the current state is "00" = state 0
        s0 <= '1';
        s1 <= '0';
        s2 <= '0';
        s3 <= '0';
        lights <= result;           -- Display the result value store in the ALU
    when "01" =>                    -- When the current state is "01" = state 1
        s0 <= '0';
        s1 <= '1';
        s2 <= '0';
        s3 <= '0';
        lights <= regA;             -- Display the operand A stored in the first 8-bit register
    when "10" =>                    -- When the current state is "10" = state 2
        s0 <= '0';
        s1 <= '0';
        s2 <= '1';
        s3 <= '0';
        lights <= regB;             -- Display the operand B stored in the second 8-bit register
    when "11" =>                    -- When the current state is "11" = state 3
        s0 <= '0';
        s1 <= '0';
        s2 <= '0';
        s3 <= '1';
        lights <= "0000" & opCode;  -- Display the operation code stored in the 4-bit register
   when others =>                   -- For compiler to synthesise
       s0 <= '0';
       s1 <= '0';
       s2 <= '0';
       s3 <= '0';
       lights <= "00000000";        -- No LED lights to be displayed
    end case;
end process;
end Behavioral;
