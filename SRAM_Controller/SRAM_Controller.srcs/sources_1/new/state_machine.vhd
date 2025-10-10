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
           nOP : in STD_LOGIC;
           CLK : in STD_LOGIC;
           CTRL : out STD_LOGIC_VECTOR (13 downto 0);
           T : out STD_LOGIC);
end state_machine;

architecture Behavioral of state_machine is

-- LSB : T
-- middle bit : R/W#                                    # --> le barre, le conjugué, l'opposé
-- MSB : ADV/LD#
constant ETAT1 : std_logic_vector (2 downto 0) := "011"; --read
constant ETAT2 : std_logic_vector (2 downto 0) := "111"; --read burst
constant ETAT3 : std_logic_vector (2 downto 0) := "000"; --write
constant ETAT4 : std_logic_vector (2 downto 0) := "100"; --write burst
constant ETAT5 : std_logic_vector (2 downto 0) := "001"; --nOP

signal ETATC : std_logic_vector (3 downto 0);

begin

-- set à 0 les signaux de la SRAM non utilisé dans CTRL.

gestion_etat : process (CLK,nOP)
begin
    if(nOP ='1') then (ETATC <= ETAT5);
    elsif (CLK'event and CLK ='1') then
        case ETATC is
-- gérer les états cf: TD2A 
    end if;
end Behavioral;
