LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------

ENTITY latch40 IS
PORT ( d    : in  std_logic_vector(39 downto 0);
       q    : out std_logic_vector(39 downto 0);         
       clk  : IN STD_LOGIC;
       rst  : IN STD_LOGIC    );
END latch40;

-------------------------------
 ARCHITECTURE latch40 OF latch40 IS


BEGIN

 PROCESS (clk, rst)
 BEGIN
	  IF (rst='1') THEN
	   q <= (others => '0');				 -- (others => '0')
	  ELSIF (clk'EVENT AND clk='1') THEN
	   q <= d;
	  END IF;
 END PROCESS;


 END latch40;
------------------------------
