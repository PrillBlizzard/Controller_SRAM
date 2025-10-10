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
           read_write : in STD_LOGIC;
           user_address : in STD_LOGIC_VECTOR (18 downto 0);
           data_SRAM : inout STD_LOGIC_VECTOR (35 downto 0);
           CTRL : out STD_LOGIC_VECTOR (0 downto 0);
           address_out : out STD_LOGIC_VECTOR (18 downto 0));
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

--signals 

signal sTrigger : STD_LOGIC;
signal sData_IN : STD_LOGIC_VECTOR (35 downto 0);
signal sData_OUT : STD_LOGIC_VECTOR (35 downto 0);
signal sRead_write : STD_LOGIC;
signal sData_SRAM : STD_LOGIC_VECTOR (35 downto 0);

begin

sData_IN(31 downto 0) <= data_IN;
sData_IN(35 downto 32) <= (others =>'0');

address_out <= user_address;

IOB_Gen: 
for I in 0 to 35 generate
    buffer_0: if I = 0 generate
        IOB_0:IOBUF_F_16 port map (
            I => sData_IN(0),
            O => sData_OUT(0),
            IO => sData_SRAM(0),
            T => sTrigger);
            
    end generate buffer_0;
    
    buffer_X: if I > 0 generate
        IOB_X:IOBUF_F_16 port map (
            I => sData_IN(I),
            O => sData_OUT(I),
            IO => sData_SRAM(I),
            T => sTrigger);
            
    end generate buffer_X;
end generate IOB_GEN;

end Behavioral;
