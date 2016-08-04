
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity BLOQUE_DECIMAL is 
	port(
	RST: IN STd_logic;	
	CLK: IN STd_logic;
	FORMATO: IN STd_logic_VEctor(11 downto 0);
	ESCALADOR: IN STd_logic_VEctor(9 downto 0);
	D5: out std_logic_vector(3 downto 0); 
	D4: out std_logic_vector(3 downto 0);
	D3: out std_logic_vector(3 downto 0);
	D2: out std_logic_vector(3 downto 0);
	D1: out std_logic_vector(3 downto 0);
	D0: out std_logic_vector(3 downto 0) 
	);
end BLOQUE_DECIMAL;

--}} End of automatically maintained section

architecture BLOQUE_DECIMAL of BLOQUE_DECIMAL is  
signal DATO1: std_logic_vector(21 downto 0);
signal DATO2: std_logic_vector(29 downto 0);
begin	 
	
	DATO2<="00000000"&DATO1;

	A0: entity work.MULTIPLICADOR_UNSIGNED generic map(12,10) port map (FORMATO,ESCALADOR,DATO1);
	A1: entity work.ContadorBCD_6digitos port map (RST,CLK,DATO2,D5,D4,D3,D2,D1,D0);

end BLOQUE_DECIMAL;
