-- Students: JAIME SEQUEIRA, ZOREN DELA CRUZ, ELLIS LAWRENCE
-- ID: 42408823,98672643,82612826 
--
-- Module Name: DEBOUNCE - Behavioural 
--
-- Project Name: ENEL373 ALU PROJECT
-- Target Devices: NEXUS4DDR FPGA BOARD
--
-- Description: THIS CODE DEBOUNCES THE BUTTONS ON THE NEXUSDDR4. THERE IS NO HARDWARE
-- DEBOUNCING ON THE BUTTONS AND THEREFORE THIS CODE IS VITAL TO BE ABLE TO USE THE BUTTONS
-- FOR OPERATIONS FLAWLESSLY.
--
-- Revision: FINAL
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity DeBounce is
    Port ( Clock : in STD_LOGIC;
           but_in : in STD_LOGIC;
           pulse_out : out STD_LOGIC);
end DeBounce;

architecture Behavioral of DeBounce is
signal a, b, c ,d, e, f, g : std_logic;


begin
process (Clock)
begin
    if ((but_in = '1') AND (Clock'Event) and Clock = '1') THEN					-- To achieve debouncing, multiple flipflops are used. 
    a <= but_in;																-- To increase the accuracy of the debouncer, feel free 
    b <= a;																		-- to increase the number of flipflops used.
    c <= b;
    d <= c;
    e <= d;
    f <= e;
    g <= f;
    end if;
     
end process;
             pulse_out <= a and b and c and d and e and f and g and but_in;                                                   
end architecture Behavioral;

