library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FSM_WAVELET is
	port(
	RST: in std_logic;
	CLK: in std_logic;
	STP: in std_logic; 
	EDGE: in std_logic;
	IGUAL:  in std_logic;
	OPC: out std_logic_vector(1 downto 0)
	);
end FSM_WAVELET;

--}} End of automatically maintained section

architecture FSM_WAVELET of FSM_WAVELET is
type ESTADOS is (S0,S1,S2);
signal QP,QN : ESTADOS;
begin

	process( QP,IGUAL,STP,EDGE)	
	begin  
	case QP is
		when S0 =>	 OPC <= "11";
			if (STP='1') then
				Qn <= S1;
			else 
				Qn <= S0;
			end if;	 	
		when S1 =>	  OPC <= "00";
			if (EDGE='0' AND IGUAL='0') then
				Qn <= S1;
			ELSIF(EDGE='1')THEN  
				Qn <= S2; 	
			ELSE
				Qn <= S0; 
			end if;				
		when others => 	OPC <= "01";
			IF(IGUAL='1')THEN 
				Qn <= S0;
			ELSE
				Qn <= S1;
			END IF;
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

end FSM_WAVELET;
			