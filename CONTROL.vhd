
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CONTROL is  
	PORT(  	
	C: in std_logic_vector(1 downto 0);	 
	D0: IN std_logic_vector(3 downto 0);
	D1: IN std_logic_vector(3 downto 0);
	D2: IN std_logic_vector(3 downto 0);
	D3: IN std_logic_vector(3 downto 0);
	CONTROL: OUT std_logic_vector(3 downto 0);
	DIS: OUT std_logic_vector(3 downto 0);
	DP: out std_logic 
	);
end CONTROL;

--}} End of automatically maintained section

architecture CONTROL of CONTROL is
begin

	PROCESS(C,D0,D1,D2,D3)
	BEGIN
		CASE C IS
			WHEN "00"=>	 
			DIS<= D0;
			DP<='0';
			CONTROL<="0111"; 
			WHEN "01"=>	
			DIS<= D1;
			DP<='1';
			CONTROL<="1011"; 
			WHEN "10"=>	
			DIS<= D2;
			DP<='1';
			CONTROL<="1101"; 
			WHEN "11"=> 
			DIS<= D3;
			DP<='1';
			CONTROL<="1110"; 
			WHEN OTHERS=> 
			DIS<= D0;
			DP<='1';
			CONTROL<="1111"; 
		END CASE;
	END PROCESS;

end CONTROL;
