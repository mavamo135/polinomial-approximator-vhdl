
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity BCD_7SEGMENTOS is
	 port(
		 M : in STD_LOGIC_VECTOR(3 downto 0);
		 S : out STD_LOGIC_VECTOR(6 downto 0)
	     );
end BCD_7SEGMENTOS;

--}} End of automatically maintained section

architecture BCD_7SEGMENTOS of BCD_7SEGMENTOS is
begin

	PROCESS(M)
	BEGIN
		CASE M IS
			WHEN "0000"=>S<="0000001"; 
			WHEN "0001"=>S<="1001111";
			WHEN "0010"=>S<="0010010";
			WHEN "0011"=>S<="0000110";
			WHEN "0100"=>S<="1001100";
			WHEN "0101"=>S<="0100100";
			WHEN "0110"=>S<="0100000";
			WHEN "0111"=>S<="0001111";
			WHEN "1000"=>S<="0000000";
			WHEN "1001"=>S<="0000100";
			WHEN OTHERS=>S<="1111111";
		END CASE;
	END PROCESS;
end BCD_7SEGMENTOS;
