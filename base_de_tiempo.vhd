
library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_arith.all;  
use IEEE.STD_LOGIC_unsigned.all;

entity base_de_tiempo is	
	generic(
	n: integer := 16
	);
	port(
	RST: in std_logic;
	CLK:  in std_logic;
	STTB: in std_logic;	
	C: in std_logic_vector(n-1 downto 0);	
	EOBT: out std_logic 
	);
end base_de_tiempo;

--}} End of automatically maintained section

architecture base_de_tiempo of base_de_tiempo is  
signal Qp,Qn:std_logic_vector(n-1 downto 0):=(others=>'0');	
begin

	process(STTB,Qp)
	begin
	if STTB='1' then
		if Qp=C then
			EOBT<='1';	 
			Qn<=(others=>'0');
		else 
			EOBT<='0';
			Qn<=Qp+1;
		end if;	
	else	
		Qn<=(others=>'0');
		EOBT<='0';
	end if;	  
	end process;
	
	process(CLK,RST)
	begin 
		if(RST='1')then 
			Qp<=(others=>'0');
		elsif (CLK'event and CLK='1')then
			Qp<=Qn;
		end if;
	end process;

end base_de_tiempo;


