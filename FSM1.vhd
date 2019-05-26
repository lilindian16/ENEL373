-- Students: JAIME SEQUEIRA, ZOREN DELA CRUZ, ELLIS LAWRENCE
-- ID: 42408823,98672643,82612826 
--
-- Module Name: FSM1
--
-- Project Name: ENEL373 ALU Project
-- Target Devices: NEXUS4DDR FPGA BOARD
--
-- Description: THIS CODE IS USED FOR DETERMINING THE CURRENT STATE AND NEXT STATE.
-- A STATE DIAGRAM IS PROVIDED IN THE REPORT FOR A VISUAL REPRESENTATION.
--
-- Reference: https://www.allaboutcircuits.com/technical-articles/implementing-a-finite-state-machine-in-vhdl/
--
-- Revision: FINAL
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM1 is
 Port ( P : in STD_LOGIC;
        Z : out STD_LOGIC_VECTOR (1 downto 0);
        reset : in STD_LOGIC;
        clock : in STD_LOGIC);
end FSM1;

-- Architecture definition for the SimpleFSM entity
Architecture RTL of FSM1 is
TYPE State_type IS (A, B, C, D);  -- Define the states
	SIGNAL State : State_Type;    -- Create a signal that uses 
							      -- the different states
BEGIN 
  PROCESS (clock, reset) 
  BEGIN 
    If (reset = '1') THEN            -- Upon reset, set the state to A
	State <= A;
 
    ELSIF rising_edge(clock) THEN    -- if there is a rising edge of the
			 -- clock, then do the stuff below
 
	-- The CASE statement checks the value of the State variable,
	-- and based on the value and any other control signals, changes
	-- to a new state.
	CASE State IS
 
		-- If the current state is A and P is set to 1, then the
		-- next state is B
		WHEN A => 
		    Z <= "00";  
			IF P='1' THEN 
			    Z <= "01";  
				State <= B; 
			END IF; 
 
		-- If the current state is B and P is set to 1, then the
		-- next state is C
		WHEN B => 
		    Z <= "01";  
			IF P='1' THEN 
			    Z <= "10";  
				State <= C; 
			END IF; 
 
		-- If the current state is C and P is set to 1, then the
		-- next state is D
		WHEN C => 
		    Z <= "10";  
			IF P='1' THEN 
			    Z <= "11";  
				State <= D; 
			END IF; 
 
		-- If the current state is D and P is set to 1, then the
		-- next state is B.
		-- If the current state is D and P is set to 0, then the
		-- next state is A.
		WHEN D=> 
	        Z <= "11"; 	
			IF P='1' THEN    
			    Z <= "00"; 
				State <= A; 
			ELSE 
				State <= D; 
			END IF; 
			
		WHEN others =>
		    Z <= "00"; 
			State <= A;
	END CASE; 
    END IF; 
  END PROCESS;

END RTL;