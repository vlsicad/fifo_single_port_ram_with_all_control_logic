-------------------------------------------------------------------------------
--
-- Title       : fifo_logic1
-- Design      : fifo_logic1
-- Author      : Windows User
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;


-- other libraries declarations
-- library FIFO_RAM_CL4;
-- library LATCH40;
-- library MEMORYFIFO;

entity fifo_logic1 is
  port(
       clk : in STD_LOGIC;
       rd : in STD_LOGIC;
       rst : in STD_LOGIC;
       wr : in STD_LOGIC;
       indata : in STD_LOGIC_VECTOR(39 downto 0);
       fifoemty : out STD_LOGIC;
       fifofull : out STD_LOGIC;
       ready : out STD_LOGIC;
       outdata : out STD_LOGIC_VECTOR(39 downto 0)
  );
end fifo_logic1;

architecture fifo_logic1 of fifo_logic1 is

---- Component declarations -----

component fifo_ram_cl4
  port (
       clk : in STD_LOGIC;
       indata : in STD_LOGIC_VECTOR(39 downto 0);
       rd : in STD_LOGIC;
       rst : in STD_LOGIC;
       wr : in STD_LOGIC;
       addcw : out INTEGER range 3 downto 0;
       exclk : out STD_LOGIC;
       fifoemty : out STD_LOGIC;
       fifofull : out STD_LOGIC;
       outdataclk : out STD_LOGIC;
       ready : out STD_LOGIC;
       wdata : out STD_LOGIC_VECTOR(39 downto 0)
  );
end component;
component latch40
  port (
       clk : in STD_LOGIC;
       d : in STD_LOGIC_VECTOR(39 downto 0);
       rst : in STD_LOGIC;
       q : out STD_LOGIC_VECTOR(39 downto 0)
  );
end component;
component memoryfifo
  port (
       addr : in INTEGER range 0 to 3;
       clk : in STD_LOGIC;
       data_in : in STD_LOGIC_VECTOR(39 downto 0);
       data_out : out STD_LOGIC_VECTOR(39 downto 0)
  );
end component;

---- Signal declarations used on the diagram ----

signal NET146 : STD_LOGIC;
signal NET25 : INTEGER;
signal NET85 : STD_LOGIC;
signal BUS133 : STD_LOGIC_VECTOR (39 downto 0);
signal BUS29 : STD_LOGIC_VECTOR (39 downto 0);

begin

----  Component instantiations  ----

U1 : fifo_ram_cl4
  port map(
       addcw => NET25,
       clk => clk,
       exclk => NET85,
       fifoemty => fifoemty,
       fifofull => fifofull,
       indata => indata,
       outdataclk => NET146,
       rd => rd,
       ready => ready,
       rst => rst,
       wdata => BUS29,
       wr => wr
  );

U2 : memoryfifo
  port map(
       addr => NET25,
       clk => NET85,
       data_in => BUS29,
       data_out => BUS133
  );

U3 : latch40
  port map(
       clk => NET146,
       d => BUS133,
       q => outdata,
       rst => rst
  );


end fifo_logic1;
