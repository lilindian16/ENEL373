----------------------------------------------------------------------------------
-- Students: JAIME SEQUEIRA, ZOREN DELA CRUZ, ELLIS LAWRENCE
-- ID: 42408823,98672643,82612826 
-- 
-- Module Name: not_a_cpu - Structural
-- Project Name: ENEL373 FPGA Project
-- Target Devices: NEXUS4DDR FPGA Board
--
-- Description: This is the top wrapper of the arithmetic logic unit (ALU)
-- program. It connects all the components of each module to implement the ALU.
-- 
-- Revision: Final
-- 
----------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity not_a_cpu is
    Port ( SW : in STD_LOGIC_VECTOR (15 downto 0);
           LED : out STD_LOGIC_VECTOR (15 downto 0);
           CLK100MHZ : in STD_LOGIC;
           BTNC : in STD_LOGIC);        
end not_a_cpu;

architecture Behavioral of not_a_cpu is
signal Debounce_Pulse, Rising_Edge_Pulse : std_logic;               -- Modified button press signals
signal State_0, State_1, State_2, State_3: STD_LOGIC;               -- The different states used for an enable
signal OperandA, OperandB, ans: std_logic_vector (7 downto 0);      -- Data bus for the operands
signal Opcode: std_logic_vector (3 downto 0);                       -- Data bus for the opCode
signal State: std_logic_vector (1 downto 0);                        -- The output state read from the FSM

    component ALU_code
    Port ( operation : in STD_LOGIC_VECTOR (3 downto 0);            -- The operation code in a one-hot configuration
              A, B : in std_logic_vector (7 downto 0);              -- The two operands, consisting of an 8 bit binary integer
              RESET: in std_logic;                                  -- Reset bit
              ENABLE, X: in STD_LOGIC;                              -- State 3 check, rising edge check
              result : out std_logic_vector (7 downto 0) );         -- Result of opcode implemented on operands A and B.
    end component; 
    
    component DeBounce
    Port ( CLK : in STD_LOGIC;                                      -- System clock
               but_in : in STD_LOGIC;                               -- Button input signal
               pulse_out : out STD_LOGIC);                          -- Button push registered as input
    end component;
    
    component EightBitReg   
    Port ( CLK : in STD_LOGIC;                                      -- System clock
               RESET : in STD_LOGIC;                                -- Reset bit    
               ENABLE: in STD_LOGIC;                                -- State check, either 0 or 1
               D : in STD_LOGIC_VECTOR (7 downto 0);                -- Switch inputs confirming operand A input
               Q : out STD_LOGIC_VECTOR (7 downto 0));              -- Stored operand A in register
    end component;
    
    component OpcodeReg
    Port ( CLK : in STD_LOGIC;                                      -- System clock
               RESET : in STD_LOGIC;                                -- Reset bit
               ENABLE : in STD_LOGIC;                               -- State check for state 2
               D : in STD_LOGIC_VECTOR (3 downto 0);                -- one-hot input for operation code
               Q : out STD_LOGIC_VECTOR (3 downto 0));              -- Stored operation in the opcode register
    end component;
     
     component Rising_Edge_Detector
     Port ( CLK  : in  std_logic;                                   -- System clock
               Reset : in  std_logic;                               -- Reset bit
               Input : in  std_logic;                               -- Debounce pulse from button push
               Output_Pulse : out std_logic);                       -- Rising edge 
     end component;
      
      component FSM1 
      Port (P : in STD_LOGIC;                                       -- Rising edge
              reset : in STD_LOGIC;                                 -- Reset bit
              clock : in STD_LOGIC;                                 -- System clock
              Z : out STD_LOGIC_VECTOR (1 downto 0));               -- State of machine
      end component;
      
      component Control_Unit 
      Port (Z : in STD_LOGIC_VECTOR (1 downto 0);                   -- Input of machine state
              regA, regB, result: in STD_LOGIC_VECTOR(7 downto 0);  -- Operands and result stored in the register 
              opCode : in STD_LOGIC_VECTOR (3 DOWNTO 0);            -- Opcode stored in register
              s0, s1, s2, s3: out STD_LOGIC;                        -- Each of the 4 states
              lights: out STD_LOGIC_VECTOR(7 downto 0));            -- LED array to be set to high
      end component;
      
begin
    
    -- Connecting all the components using portmap for structural modelling.
    u1: DeBounce port map(CLK => CLK100MHZ, but_in => BTNC, pulse_out => Debounce_Pulse);
    u2: EightBitReg port map(CLK => CLK100MHZ, RESET => SW(15), ENABLE => State_0, D => SW(7 downto 0), Q => OperandA);
    u3: EightBitReg port map(CLK => CLK100MHZ, RESET => State_0, ENABLE => State_1 , D => SW(7 downto 0), Q => OperandB);
    u4: OpcodeReg port map (CLK => CLK100MHZ, RESET => State_0 , ENABLE => State_2, D => SW(3 downto 0), Q => Opcode);
    u5: ALU_code port map(operation => Opcode, A => OperandA, B => OperandB, ENABLE => State_3, X => Rising_Edge_Pulse , RESET => SW(15) , result => ans);
    u6: Rising_Edge_Detector port map(CLK => CLK100MHZ, Reset => SW(15), Input => Debounce_Pulse, Output_Pulse => Rising_Edge_Pulse );
    u7: FSM1 port map (P => Rising_Edge_Pulse, RESET => SW(15), clock => CLK100MHZ, Z => State);
    u8: Control_Unit port map ( Z => State, s0 => State_0, s1 => State_1, s2 => State_2, s3 => State_3, regA => OperandA, regB => OperandB, opCode => Opcode, result => ans, lights => LED(7 downto 0));
    
    -- Displays the current state through the LED Lights
    LED (15) <= State_0;
    LED (14) <= State_1;
    LED (13) <= State_2;
    LED (12) <= State_3;
    
end Behavioral;