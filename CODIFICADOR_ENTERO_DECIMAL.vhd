library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CODIFICADOR_ENTERO_DECIMAL is 
	PORT(
	RST: IN STd_logic;	
	CLK: IN STd_logic;	
	ENTERO: IN STd_logic_VEctor(18 downto 0);
	FORMATO: IN STd_logic_VEctor(11 downto 0);
	ESCALADOR: IN STd_logic_VEctor(9 downto 0);
	D5E: out std_logic_vector(3 downto 0); 
	D4E: out std_logic_vector(3 downto 0);
	D3E: out std_logic_vector(3 downto 0);
	D2E: out std_logic_vector(3 downto 0);
	D1E: out std_logic_vector(3 downto 0);
	D0E: out std_logic_vector(3 downto 0);
	D5D: out std_logic_vector(3 downto 0); 
	D4D: out std_logic_vector(3 downto 0);
	D3D: out std_logic_vector(3 downto 0);
	D2D: out std_logic_vector(3 downto 0);
	D1D: out std_logic_vector(3 downto 0);
	D0D: out std_logic_vector(3 downto 0)
	);
end CODIFICADOR_ENTERO_DECIMAL;

--}} End of automatically maintained section

architecture CODIFICADOR_ENTERO_DECIMAL of CODIFICADOR_ENTERO_DECIMAL is  
signal DATO: std_logic_vector(29 downto 0);
begin
	
	DATO<="00000000000"&ENTERO;
	A0: entity work.BLOQUE_DECIMAL port map (RST,CLK,FORMATO,ESCALADOR,D5D,D4D,D3D,D2D,D1D,D0D);
	A1: entity work.ContadorBCD_6digitos port map (RST,CLK,DATO,D5E,D4E,D3E,D2E,D1E,D0E);

end CODIFICADOR_ENTERO_DECIMAL;
