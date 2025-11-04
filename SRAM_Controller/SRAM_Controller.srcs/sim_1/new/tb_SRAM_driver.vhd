----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.11.2025 11:19:15
-- Design Name: 
-- Module Name: tb_SRAM_driver - Behavioral
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

entity tb_SRAM_driver is
--  Port ( );
end tb_SRAM_driver;

architecture Behavioral of tb_SRAM_driver is


component mt55l512y36f IS
    GENERIC (
        -- Constant parameters
        addr_bits : INTEGER := 19;
        data_bits : INTEGER := 36;

        -- Timing parameters for -10 (100 Mhz)
        tKHKH    : TIME    := 10.0 ns;
        tKHKL    : TIME    :=  2.5 ns;
        tKLKH    : TIME    :=  2.5 ns;
        tKHQV    : TIME    :=  5.0 ns;
        tAVKH    : TIME    :=  2.0 ns;
        tEVKH    : TIME    :=  2.0 ns;
        tCVKH    : TIME    :=  2.0 ns;
        tDVKH    : TIME    :=  2.0 ns;
        tKHAX    : TIME    :=  0.5 ns;
        tKHEX    : TIME    :=  0.5 ns;
        tKHCX    : TIME    :=  0.5 ns;
        tKHDX    : TIME    :=  0.5 ns
    );

    -- Port Declarations
    PORT (
        Dq        : INOUT STD_LOGIC_VECTOR (data_bits - 1 DOWNTO 0);   -- Data I/O
        Addr      : IN    STD_LOGIC_VECTOR (addr_bits - 1 DOWNTO 0);   -- Address
        Lbo_n     : IN    STD_LOGIC;                                   -- Burst Mode
        Clk       : IN    STD_LOGIC;                                   -- Clk
        Cke_n     : IN    STD_LOGIC;                                   -- Cke#
        Ld_n      : IN    STD_LOGIC;                                   -- Adv/Ld#
        Bwa_n     : IN    STD_LOGIC;                                   -- Bwa#
        Bwb_n     : IN    STD_LOGIC;                                   -- BWb#
        Bwc_n     : IN    STD_LOGIC;                                   -- Bwc#
        Bwd_n     : IN    STD_LOGIC;                                   -- BWd#
        Rw_n      : IN    STD_LOGIC;                                   -- RW#
        Oe_n      : IN    STD_LOGIC;                                   -- OE#
        Ce_n      : IN    STD_LOGIC;                                   -- CE#
        Ce2_n     : IN    STD_LOGIC;                                   -- CE2#
        Ce2       : IN    STD_LOGIC;                                   -- CE2
        Zz        : IN    STD_LOGIC                                    -- Snooze Mode
    );
END component mt55l512y36f;



component SRAM_driver is
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
           
           d_CLK : in STD_LOGIC
           );
end component;


	SIGNAL s_CLK :  std_logic := '0';
	
	
	signal s_data_IN :  STD_LOGIC_VECTOR (31 downto 0);
    signal s_data_OUT :  STD_LOGIC_VECTOR (31 downto 0);
   
    signal s_user_address :  STD_LOGIC_VECTOR (18 downto 0);
    signal s_address_out :  STD_LOGIC_VECTOR (18 downto 0);
   
    signal s_read_write :  STD_LOGIC;
    signal s_burst :  STD_LOGIC;
    signal s_idle :  STD_LOGIC;

    signal s_data_SRAM : STD_LOGIC_VECTOR (35 downto 0);
	
	signal s_lbo_n     :     STD_LOGIC;                                   -- Burst Mode
    signal s_Cke_n     :     STD_LOGIC;                                   -- Cke#
    signal s_Ld_n      :     STD_LOGIC;                                   -- Adv/Ld#
    signal s_Bwa_n     :     STD_LOGIC;                                   -- Bwa#
    signal s_Bwb_n     :     STD_LOGIC;                                   -- BWb#
    signal s_Bwc_n     :     STD_LOGIC;                                   -- Bwc#
    signal s_Bwd_n     :     STD_LOGIC;                                   -- BWd#
    signal s_Rw_n      :     STD_LOGIC;                                   -- RW#
    signal s_Oe_n      :     STD_LOGIC;                                   -- OE#
    signal s_Ce_n      :     STD_LOGIC;                                   -- CE#
    signal s_Ce2_n     :     STD_LOGIC;                                   -- CE2#
    signal s_Ce2       :     STD_LOGIC;                                   -- CE2
    signal s_zz : STD_LOGIC;


    signal clock_period: time := 20ns;

begin

mem : mt55l512y36f PORT MAP (
        Dq    =>  s_data_SRAM,   
        Addr  =>  s_address_out,   
        Lbo_n => s_Lbo_n, 
        Clk   => s_CLK,    
        Cke_n => s_Cke_n,    
        Ld_n  => s_Ld_n,    
        Bwa_n => s_Bwa_n,
        Bwb_n => s_Bwb_n,    
        Bwc_n => s_Bwc_n,    
        Bwd_n => s_Bwd_n,    
        Rw_n  => s_Rw_n,   
        Oe_n  => s_Oe_n,    
        Ce_n  => s_Ce_n,    
        Ce2_n => s_Ce2_n,    
        Ce2   => s_Ce2,    
        Zz    => s_Zz    
    );
  
dvr : SRAM_driver Port map
                 ( data_IN      => s_data_IN,
                   data_OUT     => s_data_OUT,
                   
                   user_address => s_user_address,
                   
                   read_write   => s_read_write,
                   burst        => s_burst,
                   idle         => s_idle,
                   
                   data_SRAM    => s_data_SRAM,
                   address_out  => s_address_out,
          
                   -- sorties de contôle de la SRAM          
                   d_Lbo_n      => s_Lbo_n,
                   d_Cke_n      => s_Cke_n,
                   d_Ld_n       => s_Ld_n,
                   d_Bwa_n      => s_Bwa_n,
                   d_Bwb_n      => s_Bwb_n,
                   d_Bwc_n      => s_Bwc_n,
                   d_Bwd_n      => s_Bwd_n,
                   d_Rw_n       => s_Rw_n ,
                   d_Oe_n       => s_Oe_n,
                   d_Ce_n       => s_Ce_n,
                   d_Ce2_n      => s_Ce2_n,
                   d_Ce2        => s_Ce2,
                   d_Zz         => s_zz,
               
                   d_CLK        => s_CLK
           );




clokcing: process
begin
     s_CLK <= '1';
     wait for 20ns;
     s_CLK <= '0';
     wait for 20ns;
end process; 


stimulus: process
begin
    s_data_IN <=(others => '0');
    s_user_address <=(others => '0');
    s_read_write <= '0';
    s_burst <= '0';
    s_idle <='1';
    
    wait for 10*clock_period;
    
    s_data_IN <=(others => '1');    -- écrire que des 1 à l'addresse 0
    s_read_write <= '1';
    s_user_address <=(others => '0');
    s_idle <='0';
    
    wait for 2*clock_period;
    
    s_data_IN <= "10101010101010101010101010101010";    -- écrire que des 10 à l'addresse 1
    s_read_write <= '1';
    s_user_address <="0000000000000000001";
    s_idle <='0';
    
    wait for 5*clock_period;
       
    s_read_write <= '0';                                -- lire à l'addresse 0
    s_user_address <=(others => '0');
    s_idle <='0';
    
    wait for 3*clock_period;
    
    s_read_write <= '0';                                -- lire à l'addresse 1
    s_user_address <="0000000000000000001";
    s_idle <='0';
    
    wait for 3*clock_period;
    
    wait;

end process stimulus;


end Behavioral;
