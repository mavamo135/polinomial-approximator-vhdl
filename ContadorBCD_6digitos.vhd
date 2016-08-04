
library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ContadorBCD_6digitos is	
	port(
	RST: IN STd_logic;	
	CLK: IN STd_logic;
	DATO: IN STd_logic_VEctor(29 downto 0);
	D5: out std_logic_vector(3 downto 0); 
	D4: out std_logic_vector(3 downto 0);
	D3: out std_logic_vector(3 downto 0);
	D2: out std_logic_vector(3 downto 0);
	D1: out std_logic_vector(3 downto 0);
	D0: out std_logic_vector(3 downto 0) 
	);
		
end ContadorBCD_6digitos;

--}} End of automatically maintained section

architecture ContadorBCD_6digitos of ContadorBCD_6digitos is 
signal QCM,QDM,QM,QD,QC,QU: std_logic_vector(3 downto 0);  
signal igualCM,igualDM,igualM,igualD,igualC,igualU,igualDATO: std_logic;   
signal OPCCM,OPCDM,OPCM,OPCD,OPCC,OPCU,OPC: std_logic_vector(1 downto 0);  
signal Q: std_logic_vector(29 downto 0);
begin
	
	OPCU(0)<='1';  
	OPCU(1)<=igualDATO or igualU; 
	
	OPCD(0)<=igualDATO or igualU;  
	OPCD(1)<=igualDATO or(igualD and igualU); 
	
	OPCC(0)<=igualDATO or (igualD and igualU);  
	OPCC(1)<=igualDATO or(igualC and igualD and igualU);
	
	OPCM(0)<=igualDATO or (igualC and igualD and igualU);  
	OPCM(1)<=igualDATO or(igualM and igualC and igualD and igualU);
	
	OPCDM(0)<=igualDATO or (igualM and igualC and igualD and igualU);  
	OPCDM(1)<=igualDATO or(igualDM and igualM and igualC and igualD and igualU); 
	
	OPCCM(0)<=igualDATO or (igualDM and igualM and igualC and igualD and igualU);  
	OPCCM(1)<=igualDATO or(igualCM and igualDM and igualM and igualC and igualD and igualU);  
	
	OPC(0)<='1';  
	OPC(1)<=igualDATO;
	
	igualCM<='1' when QCM="1001" else '0'; 
	igualDM<='1' when QDM="1001" else '0'; 
	igualC<='1' when QC="1001" else '0'; 
	igualM<='1' when QM="1001" else '0'; 
	igualD<='1' when QD="1001" else '0'; 
	igualU<='1' when QU="1001" else '0'; 
	igualDATO<='1' when Q=DATO else '0'; 
	
	
	A0: entity work.contador_ascendente_clear_sincrono generic map(4) port map (RST,CLK,OPCCM,QCM);
	A1: entity work.contador_ascendente_clear_sincrono generic map(4) port map (RST,CLK,OPCDM,QDM);
	A2: entity work.contador_ascendente_clear_sincrono generic map(4) port map (RST,CLK,OPCM,QM);
	A3: entity work.contador_ascendente_clear_sincrono generic map(4) port map (RST,CLK,OPCC,QC);
	A4: entity work.contador_ascendente_clear_sincrono generic map(4) port map (RST,CLK,OPCD,QD);
	A5: entity work.contador_ascendente_clear_sincrono generic map(4) port map (RST,CLK,OPCU,QU);
	A6: entity work.contador_ascendente_clear_sincrono generic map(30) port map (RST,CLK,OPC,Q);  
		
	A7: entity work.registro_hold generic map(4) port map (RST,CLK,igualDATO,QCM,D5);
	A8: entity work.registro_hold generic map(4) port map (RST,CLK,igualDATO,QDM,D4);
	A9: entity work.registro_hold generic map(4) port map (RST,CLK,igualDATO,QM,D3);
	A10: entity work.registro_hold generic map(4) port map (RST,CLK,igualDATO,QC,D2);
	A11: entity work.registro_hold generic map(4) port map (RST,CLK,igualDATO,QD,D1);
	A12: entity work.registro_hold generic map(4) port map (RST,CLK,igualDATO,QU,D0);
		

end ContadorBCD_6digitos;
