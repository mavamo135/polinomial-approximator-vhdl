library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.std_logic_unsigned.all;

entity registro_hold is	 
	generic(
	n: integer := 8
	);
	port(
	RST:	in std_logic;
	CLK:	in std_logic;
	OPC:	in std_logic;	 
	D:		in std_logic_vector(n-1 downto 0);
	Q:		out std_logic_vector(n-1 downto 0):=(others => '0')
	);
end registro_hold;

--}} End of automatically maintained section

architecture registro_hold of registro_hold is	
signal Qn,Qp: std_logic_vector(n-1 downto 0):=(others => '0');
begin

	combinacional: process(OPC,Qp,D)
	begin
		if OPC='1' then
			Qn <= D;
		else
			Qn <= Qp;
		end if;			   
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

end registro_hold;
