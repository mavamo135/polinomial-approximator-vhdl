
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity REGISTRO_PARALELO_HOLD_CLEAR is
	generic(
	n: integer := 8
	);
	port(
	RST:	in std_logic;
	CLK:	in std_logic;
	OPC:	in std_logic_vector(1 downto 0);	 
	D:		in std_logic_vector(n-1 downto 0);
	Q:		out std_logic_vector(n-1 downto 0)
	);
end REGISTRO_PARALELO_HOLD_CLEAR;

--}} End of automatically maintained section

architecture REGISTRO_PARALELO_HOLD_CLEAR of REGISTRO_PARALELO_HOLD_CLEAR is
signal Qn,Qp: std_logic_vector(n-1 downto 0);
begin

	combinacional: process(OPC,Qp,D)
	begin
		CASE OPC IS
			WHEN "00"=>
			QN<=QP;	
			WHEN "01"=>
			QN<=D;
			WHEN OTHERS=>
			QN<=(others => '0');
		END CASE;
		Q <= Qp;
	end process combinacional;
	
	secuencial: process(RST,CLK)
	begin
		if(RST = '1') then
			Qp <= (others => '0');
		elsif(CLK'event and CLK = '1') then
			Qp <= Qn;
		end if;
	end process secuencial;

end REGISTRO_PARALELO_HOLD_CLEAR;
