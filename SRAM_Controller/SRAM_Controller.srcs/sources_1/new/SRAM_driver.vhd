----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.10.2025 14:43:14
-- Design Name: 
-- Module Name: SRAM_driver - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library unisim;
use unisim.VComponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SRAM_driver is
    Port ( data_IN : in STD_LOGIC_VECTOR (31 downto 0);
           data_OUT : out STD_LOGIC_VECTOR (31 downto 0);
           
           user_address : in STD_LOGIC_VECTOR (18 downto 0);
           
           read_write : in STD_LOGIC;
           burst : in STD_LOGIC;
           idle : in STD_LOGIC;
           
           data_SRAM : inout STD_LOGIC_VECTOR (35 downto 0);
           address_out : out STD_LOGIC_VECTOR (18 downto 0);
  
           -- sorties de contôle de la SRAM          
           d_Lbo_n     : OUT   STD_LOGIC;                                   -- Burst Mode
           d_Cke_n     : OUT    STD_LOGIC;                                   -- Cke#              
           d_Ld_n      : OUT    STD_LOGIC;                                   -- Adv/Ld#
           d_Bwa_n     : OUT    STD_LOGIC;                                   -- Bwa#
           d_Bwb_n     : OUT    STD_LOGIC;                                   -- BWb#
           d_Bwc_n     : OUT    STD_LOGIC;                                   -- Bwc#
           d_Bwd_n     : OUT    STD_LOGIC;                                   -- BWd#
           d_Rw_n      : OUT    STD_LOGIC;                                   -- RW#
           d_Oe_n      : OUT    STD_LOGIC;                                   -- OE#
           d_Ce_n      : OUT    STD_LOGIC;                                   -- CE#
           d_Ce2_n     : OUT    STD_LOGIC;                                   -- CE2#
           d_Ce2       : OUT    STD_LOGIC;                                   -- CE2
           d_Zz        : OUT    STD_LOGIC;                                   -- Snooze Mode
           
           CLK : in STD_LOGIC
           );
end SRAM_driver;

architecture Behavioral of SRAM_driver is

-- component : IOB & state_machine

component IOBUF_F_16
  port(
    O  : out   std_logic;
    IO : inout std_logic;
    I  : in    std_logic;
    T  : in    std_logic
    );
end component; 

component state_machine is
    Port ( read_write : STD_LOGIC;
           burst : STD_LOGIC;
           idle : STD_LOGIC;
           CLK : STD_LOGIC;
           ST_CTRL : STD_LOGIC_VECTOR (1 downto 0);
           T : STD_LOGIC);
end component;

--signaux de la State Machine 
signal sRead_write : STD_LOGIC;
signal sBurst : STD_LOGIC;
signal sIdle : STD_LOGIC;
signal sST_CTRL : STD_LOGIC_VECTOR(1 downto 0);

--signaux communs
signal sTrigger : STD_LOGIC;

--signaux datas
signal sData_IN : STD_LOGIC_VECTOR (35 downto 0);
signal sData_OUT : STD_LOGIC_VECTOR (35 downto 0);
signal sData_SRAM : STD_LOGIC_VECTOR (35 downto 0);

--clock
signal sCLK : STD_LOGIC;


begin

IOB_Gen: 
for I in 0 to 35 generate
    IOB_X: IOBUF_F_16 port map (
        I => sData_IN(I),
        O => sData_OUT(I),
        IO => sData_SRAM(I),
        T => sTrigger);            

end generate IOB_GEN;

DSM : component state_machine port map ( 
           read_write => sRead_write ,
           burst => sBurst,
           idle => sIdle,
           CLK => sCLK,
           ST_CTRL => sST_CTRL,
           T => sTrigger);


-- signaux de contrôles changeant à envoyer à la SRAM
Ld_n <= sST_CTRL(1);
Rw_n <= sST_CTRL(0);


-- set à 0 les signaux de la SRAM non utilisé dans CTRL.
Lbo_n  <= '0'; 
Cke_n  <= '0';   
         
Bwa_n  <= '0';  
Bwb_n  <= '0';   
Bwc_n  <= '0';   
Bwd_n  <= '0';   

Oe_n   <= '0';   
Ce_n   <= '0';  
Ce2_n  <= '0';   
Ce2    <= '1';  
Zz     <= '0';


--  le signal s_Data_IN à envoyé à l'IO_BUF est l'entrée data côté utilisateur en y ajoutant 4 bit de remplissage)
sData_IN(31 downto 0) <= data_IN;
sData_IN(35 downto 32) <= (others =>'0');

-- la sortie data du driver (côté "user") c'est les 32 premiers bit de sData_OUT (cad : on enlève les 4 bits de remplissage)
data_OUT <= sData_OUT(31 downto 0); 

-- on lie directement l'addresse en entrée du driver à l'addresse en sortie du driver
address_out <= user_address;


end Behavioral;
