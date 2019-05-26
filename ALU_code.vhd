----------------------------------------------------------------------------------
-- Students: JAIME SEQUIERA, ZOREN DELA CRUZ, ELLIS LAWRENCE
-- ID: 42408823,98672643,82612826 
-- 
-- Module Name: ALU CODE - Behavioural
-- Project Name: ENEL373 ALU Project
-- Target Devices: NEXUS4DDR FGPA BOARD
--
-- Description: THIS CODE CONTAINS THE LOGIC FOR THE ARITHMETIC LOGIC UNIT (ALU).
-- IT TAKES 5 INPUTS AND OUTPUTS A RESULT. THE INPUTS ARE THE TWO 8-BIT OPERANDS, THE OPERATION (OP) CODE
-- AN ENABLE AND A RESET. IT OUTPUTS THE RESULTING 8-BIT ANSWER AFTER APPLYING THE OPCODE TO THE OPERANDS.
--
-- Reference: Steve's Lecture notes
-- 
-- Revision: FINAL
-- 
----------------------------------------------------------------------------------

-- Library declerations
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity ALU_code is
    Port ( operation : in STD_LOGIC_VECTOR (3 downto 0);	-- Op code input by user
    A, B : in std_logic_vector (7 downto 0);				-- Operands chosen by user
    RESET: in std_logic;									-- Active high reset input
    ENABLE, X : in std_logic;
    result : out std_logic_vector (7 downto 0) );
end ALU_code;

architecture Behavioral of ALU_code is

begin
    acc : process (operation,A,B) is
    begin
    if (ENABLE = '1' AND X = '1') then
        case operation is 
            when "0001" => result <= A AND B;               -- The AND logic operation
            when "0010" => result <= A OR B;                -- The OR logic operation
            when "0100" => result <= A + B;                 -- The addition arithmetic operation
            when "1000" => result <= A - B;                 -- The subtraction arithmetic operation
            when others => result <= A XOR B;               -- The XOR logic operation
        end case;
    end if;
    if (RESET = '1') then 
        result <= "00000000";                               -- Sets the result value to 0
    end if;
    end process acc;
end Behavioral;
