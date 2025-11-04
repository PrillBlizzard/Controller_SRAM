----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.10.2025 14:43:14
-- Design Name: 
-- Module Name: state_machine - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity state_machine is
    Port ( read_write : in STD_LOGIC;
           burst : in STD_LOGIC;
           idle : in STD_LOGIC;
           CLK : in STD_LOGIC;
           ST_CTRL : out STD_LOGIC_VECTOR (1 downto 0);
           T : out STD_LOGIC);
end state_machine;

architecture Behavioral of state_machine is

-- Machine d'état décodé : les bits représenent les entrées de la SRAM et du IO PORT tq :               # --> le barre, le conjugué, l'opposé
-- MSB : ADV/LD#                pour la SRAM     
-- middle bit : R/W#            pour la SRAM                        
-- LSB : T                      pour le port IO

constant READ : std_logic_vector (2 downto 0) := "011"; --read
constant READ_B : std_logic_vector (2 downto 0) := "111"; --read burst
constant WRITE : std_logic_vector (2 downto 0) := "000"; --write
constant WRITE_B : std_logic_vector (2 downto 0) := "100"; --write burst
constant nOP : std_logic_vector (2 downto 0) := "001"; --nOP

signal ETATC : std_logic_vector (2 downto 0);

begin

ST_CTRL <= ETATC(2 downto 1);
T <= ETATC(0);

gestion_etat : process (CLK,idle)
begin
    if (idle ='1') then ETATC <= nOP;
    elsif (CLK'event and CLK ='1') then
        case ETATC is
        
            when nOP =>
                if(read_write ='1' and burst ='0' and idle = '0') then 
                    ETATC <= WRITE;
                elsif(read_write ='0' and burst ='0' and idle = '0') then 
                    ETATC <= READ;
                end if;
                
            when WRITE =>
                if(idle = '1') then 
                    ETATC <= nOP;
                 elsif(read_write ='0' and burst ='0' and idle = '0') then 
                    ETATC <= READ;   
                 elsif(read_write ='1' and burst ='1' and idle = '0') then 
                    ETATC <= WRITE_B; 
                 end if;   
                 
             when WRITE_B =>
                if(idle = '1') then 
                    ETATC <= nOP;
                 elsif(read_write ='0' and burst ='0' and idle = '0') then 
                    ETATC <= READ;   
                 elsif(read_write ='1' and burst ='0' and idle = '0') then 
                    ETATC <= WRITE; 
                 end if;  
             
             when READ =>
                if(idle = '1') then 
                    ETATC <= nOP;
                 elsif(read_write ='1' and burst ='0' and idle = '0') then 
                    ETATC <= WRITE;   
                 elsif(read_write ='0' and burst ='1' and idle = '0') then 
                    ETATC <= READ_B; 
                 end if;
                 
            when READ_B =>
                if(idle = '1') then 
                    ETATC <= nOP;
                elsif(read_write ='1' and burst ='0' and idle = '0') then 
                    ETATC <= WRITE;   
                elsif(read_write ='0' and burst ='0' and idle = '0') then 
                    ETATC <= READ; 
                end if;
                             
            when others =>
                ETATC <= nOP;
        end case;
-- gérer les états cf: TD2A 
    end if;
    
    end process gestion_etat;
    
end Behavioral;
