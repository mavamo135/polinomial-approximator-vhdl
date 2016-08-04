
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FSM_APROXIMADOR is 
	port(
	RST: in std_logic;
	CLK: in std_logic;
	STP: in std_logic;
	EOP: in std_logic;
	O: out std_logic	
	);
end FSM_APROXIMADOR;

--}} End of automatically maintained section

architecture FSM_APROXIMADOR of FSM_APROXIMADOR is
type ESTADOS is (S0,S1,S2);
signal QP,QN : ESTADOS;
begin

	process( QP,EOP,STP)	
	begin  
	case QP is
		when S0 =>	 O <= '0';
			if (STP='1') then
				Qn <= S1;
			else 
				Qn <= S0;
			end if;	 	
		when S1 =>	  O <= '0';
			if (EOP='1') then
				Qn <= S2;
			else 
				Qn <= S1;
			end if;		
		when others => O <= '1';
				Qn <= S0;
	end case;
	end process ;
			
	process(RST,CLK)
			begin
				if (RST='1') then
					Qp <= S0;
				elsif (CLK'event and CLK='1') then
					Qp <= Qn;
				end if;
	end process ;

end FSM_APROXIMADOR;
