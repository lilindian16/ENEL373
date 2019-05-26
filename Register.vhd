----------------------------------------------------------------------------------
-- Students: JAIME SEQUEIRA, ZOREN DELA CRUZ, ELLIS LAWRENCE
-- ID: 42408823,98672643,82612826 
--
-- Module Name: Register - Behavioral
-- Project Name: ENEL373 FPGA Project
-- Target Devices: NEXUS4DDR FGPA Board
--
-- Description: This is the 8 bit operand register. It is constructed of 8 flip-flops
-- which each store one of the 8 bit binary input.
-- 
-- Reference: Steve's lectures
--
-- Revision: FINAL
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EightBitReg is
    Port ( CLK : in STD_LOGIC;				-- Clock input from the FPGA board
           RESET : in STD_LOGIC;			-- Reset input for the flip-flops
           ENABLE: in STD_LOGIC;			-- The activation for the flip-flops
           D : in STD_LOGIC_VECTOR (7 downto 0);	-- input array of the operand
           Q : out STD_LOGIC_VECTOR (7 downto 0));	-- stored output array of the operand
end EightBitReg;

architecture Behavioral of EightBitReg is
begin
    process(CLK, ENABLE, RESET)
        begin
            if (RESET = '1') then
                Q <= "00000000";                            -- Resets the value stored in the register to 0
            elsif (rising_edge(CLK) AND ENABLE = '1') then
                Q <= D;                                     -- Store the input value in the register
            end if;
    end process;
end Behavioral;

