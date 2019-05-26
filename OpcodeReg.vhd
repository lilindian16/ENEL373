----------------------------------------------------------------------------------
-- Students: JAIME SEQUIERA, ZOREN DELA CRUZ, ELLIS LAWRENCE
-- ID: 42408823,98672643,82612826 
-- 
-- Module Name: OpcodeReg - Behavioral
-- Project Name: ENEL373 ALU Project
-- Target Devices: NEXUS4DDR FGPA BOARD
--
-- Description: This is the 4 bit opcode register. It is constructed of 4 flip-flops
-- in a one-hot configuration to signal which operation is to be carried out.
-- 
-- Reference: Steve's lecture
--
-- Revision: FINAL
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OpcodeReg is
Port ( CLK : in STD_LOGIC;                      -- Clock input from the FPGA board
       RESET : in STD_LOGIC;			        -- Reset input for the flip-flops
       ENABLE: in STD_LOGIC;			        -- The activation for the flip-flops
       D : in STD_LOGIC_VECTOR (3 downto 0);	-- input array of the operand
       Q : out STD_LOGIC_VECTOR (3 downto 0));	-- stored output array of the operand
end OpcodeReg;

architecture Behavioral of OpcodeReg is

begin
    process(CLK, ENABLE, RESET)
        begin
            if (RESET = '1') then
                Q <= "0000";                                -- Resets the value stored in the register to 0
            elsif (rising_edge(CLK) AND ENABLE = '1') then
                Q <= D;                                     -- Store the input value in the register
            end if;
    end process;
    
end Behavioral;
