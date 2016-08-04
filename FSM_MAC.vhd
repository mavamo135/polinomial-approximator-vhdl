library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FSM_MAC is  
	port(
	RST: in std_logic;
	CLK: in std_logic;
	STP: in std_logic;
	IGUAL:  in std_logic;
	OPC: out std_logic_vector(1 downto 0);
	H1: out std_logic_vector(1 downto 0);
	H2: out std_logic;
	EOP: out std_logic	
	);
end FSM_MAC;

--}} End of automatically maintained section

architecture FSM_MAC of FSM_MAC is	
type ESTADOS is (S0,S1,S2,S3);
signal QP,QN : ESTADOS;
begin

	process( QP,IGUAL,STP)	
	begin  
	case QP is
		when S0 =>	 OPC <= "11";H1 <= "11";	H2 <= '0';EOP <= '1';
			if (STP='1') then
				Qn <= S1;
			else 
				Qn <= S0;
			end if;	 
			
		when S1 =>	  OPC <= "00";H1 <= "01";	H2 <= '0';EOP <= '0';
				Qn <= S2;
		
		when S2 =>	 OPC <= "01";H1 <= "00";	H2 <= '0';EOP <= '0';
			if (IGUAL='1') then
				Qn <= S3;
			else 
				Qn <= S1;
			end if;	
		when others => OPC <= "11";H1 <= "00";	H2 <= '1';EOP <= '0';
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

end FSM_MAC;
