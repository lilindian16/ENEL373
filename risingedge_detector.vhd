----------------------------------------------------------------------------------
-- Students: JAIME SEQUIERA, ZOREN DELA CRUZ, ELLIS LAWRENCE
-- ID: 42408823,98672643,82612826 
-- 
-- Module Name: Rising Edge Detector - Behavioural
-- Project Name: ENEL373 ALU Project
-- Target Devices: NEXUS4DDR FGPA BOARD
--
-- Description: USED TO FIND THE RISING EDGE OF AN INPUT EG A BUTTON PUSH.
--
-- Reference: https://surf-vhdl.com/how-to-design-a-good-edge-detector/
--
-- Revision: FINAL
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Rising_Edge_Detector is
 Port ( CLK  : in  std_logic;
        Reset : in  std_logic;
        Input : in  std_logic;
        Output_Pulse : out std_logic);
  
end Rising_Edge_Detector;

architecture rtl of Rising_Edge_Detector is
signal r0_input : std_logic;                   -- Signals defined to determine a transition change
signal r1_input : std_logic;

begin
    p_rising_edge_detector : process(CLK, Reset)
    begin
      if(Reset ='1') then
        r0_input           <= '0';              -- Resets all the values stored in the two registers
        r1_input           <= '0';
      elsif(rising_edge(CLK)) then
        r0_input           <= Input;            -- Stores the current input
        r1_input           <= r0_input;         -- Stores the previous input
      end if;
    end process p_rising_edge_detector;
    
Output_Pulse <= not r1_input and r0_input;      -- Detects the Rising Edge of button presses

end rtl;
