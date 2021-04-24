
LIBRARY ieee;
USE ieee.std_logic_1164.all;
---------------------------------------------------
ENTITY memoryfifo IS
--memory
PORT ( clk    : IN STD_LOGIC;
       addr   : IN INTEGER RANGE 0 TO 3;
       data_in: IN STD_LOGIC_VECTOR (39 DOWNTO 0);
      data_out: OUT STD_LOGIC_VECTOR (39 DOWNTO 0));
END memoryfifo;
---------------------------------------------------
ARCHITECTURE memoryfifo OF memoryfifo IS		

    TYPE vector_array IS ARRAY (0 TO 3) OF STD_LOGIC_VECTOR (39 DOWNTO 0);
    SIGNAL memory: vector_array;	  
	
  BEGIN

	  PROCESS (clk)
       BEGIN
       
          IF (clk'EVENT AND clk='1') THEN
             memory(addr) <= data_in;
          END IF; 
      END PROCESS;		
	  
   data_out <= memory(addr);	
   
 END memoryfifo;