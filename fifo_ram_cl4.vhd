-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : fifo_ram_cl4

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity fifo_ram_cl4 is 
	port (
		clk: in STD_LOGIC;
		indata: in STD_LOGIC_VECTOR (39 downto 0);
		rd: in STD_LOGIC;
		rst: in STD_LOGIC;
		wr: in STD_LOGIC;
		addcw: out INTEGER range 3 downto 0;
		exclk: out STD_LOGIC;
		fifoemty: out STD_LOGIC;
		fifofull: out STD_LOGIC;
		outdataclk: out STD_LOGIC;
		ready: out STD_LOGIC;
		wdata: out STD_LOGIC_VECTOR (39 downto 0));
end fifo_ram_cl4;

architecture fifo_ram_cl4_arch of fifo_ram_cl4 is

-- SYMBOLIC ENCODED state machine: Sreg0
type Sreg0_type is (
    S1, S4, S3, S2, S7, S6, S5, S9, S8, S10, S11, S12, S13
);
-- attribute enum_encoding of Sreg0_type: type is ... -- enum_encoding attribute is not supported for symbolic encoding

signal Sreg0: Sreg0_type;

begin

-- concurrent signals assignments

-- Diagram ACTION

----------------------------------------------------------------------
-- Machine: Sreg0
----------------------------------------------------------------------
Sreg0_machine: process (clk)
-- machine variables declarations
variable cr: INTEGER range 4 downto 0;
variable cw: INTEGER range 4 downto 0;
variable vfe: STD_LOGIC;
variable vff: STD_LOGIC;

begin
	if clk'event and clk = '1' then
		if rst='1' then
			Sreg0 <= S1;
			-- Set default values for outputs, signals and variables
			-- ...
			outdataclk <= '0';
			fifofull <= '0';
			fifoemty <= '1';
			cw := 0;
			cr := 0;
			vff := '0';
			vfe := '1';
			ready <= '0';
		else
			-- Set default values for outputs, signals and variables
			-- ...
			case Sreg0 is
				when S1 =>
					outdataclk <= '0';
					fifofull <= '0';
					fifoemty <= '1';
					cw := 0;
					cr := 0;
					vff := '0';
					vfe := '1';
					ready <= '0';
					if rst = '0' then
						Sreg0 <= S2;
					end if;
				when S4 =>
					ready <= '0';
					if rd = '1' then
						Sreg0 <= S4;
					elsif rd = '0' then
						Sreg0 <= S6;
					end if;
				when S3 =>
					ready <= '0';
					if wr = '1' then
						Sreg0 <= S3;
					elsif wr = '0' then
						Sreg0 <= S5;
					end if;
				when S2 =>
					ready <= '1';
					if wr = '1' then
						Sreg0 <= S3;
					elsif rd = '1' then
						Sreg0 <= S4;
					end if;
				when S7 =>
					wdata <= indata;
					addcw <= cw;
					exclk <= '0';
					ready <= '0';
					Sreg0 <= S10;
				when S6 =>
					ready <= '0';
					addcw <= cr;
					if vfe = '0' then
						Sreg0 <= S8;
					elsif vfe = '1' then
						Sreg0 <= S2;
					end if;
				when S5 =>
					ready <= '0';
					if vff = '0' then
						Sreg0 <= S7;
					elsif vff = '1' then
						Sreg0 <= S2;
					end if;
				when S9 =>
					if (cw=cr) then
					vfe := '1';
					vff := '0';
					fifoemty <= '1';
					fifofull <= '0';
					cw := 0;
					cr := 0;
					elsif (cw = 4 )	  then
					vfe := '0';
					vff := '1';
					fifoemty <= '0';
					fifofull <= '1';
					elsif (cw > cr and cw < 4 ) then
					vfe := '0';
					vff := '0';
					fifoemty <= '0';
					fifofull <= '0';
					end if ;
					ready <= '0';
					Sreg0 <= S2;
				when S8 =>
					ready <= '0';
					addcw <= cr;
					outdataclk <= '1';
					Sreg0 <= S13;
				when S10 =>
					wdata <= indata;
					addcw <= cw;
					exclk <= '1';
					ready <= '0';
					Sreg0 <= S11;
				when S11 =>
					wdata <= indata;
					addcw <= cw;
					exclk <= '0';
					cw := cw + 1;
					ready <= '0';
					Sreg0 <= S9;
				when S12 =>
					cr := cr + 1;
					Sreg0 <= S9;
				when S13 =>
					ready <= '0';
					addcw <= cr;
					outdataclk <= '0';
					Sreg0 <= S12;
--vhdl_cover_off
				when others =>
					null;
--vhdl_cover_on
			end case;
		end if;
	end if;
end process;

end fifo_ram_cl4_arch;
