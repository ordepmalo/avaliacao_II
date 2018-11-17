-------------------------------------------------------------------------------
-- Title         : Single Instruction, Multiple Data - SUM operation 
-- Project       : Avaliação II
-------------------------------------------------------------------------------
-- File          : register_bank_tb.vhd
-- Author        : Pedro Messias Jose da Cunha Bastos
-- Created       : 2018-11-12
-------------------------------------------------------------------------------

-- Libraries and packages
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-------------------------------------
entity testbench is
end entity testbench;
-------------------------------------

architecture stimulus of testbench is
	
	-- Constants declarations
	constant WIDTH : natural := 32;
	
    -- Component declarations
	component register_bank is
		port(
			sysclk      : in  std_logic;
			reset_n     : in  std_logic;
			rd_a_addr_i : in  std_logic_vector(integer(ceil(log2(real(WIDTH))))-1 downto 0);
			rd_b_addr_i : in  std_logic_vector(integer(ceil(log2(real(WIDTH))))-1 downto 0);
			a_data_o    : out std_logic_vector(WIDTH-1 downto 0);
			b_data_o    : out std_logic_vector(WIDTH-1 downto 0);
			wrt_en_i    : in  std_logic;
			wrt_addr_i  : in  std_logic_vector(integer(ceil(log2(real(WIDTH))))-1 downto 0);
			wrt_data_i  : in  std_logic_vector(WIDTH-1 downto 0)
		);
	end component register_bank;

    -- Signals declarations
    signal sysclk      : std_logic := '0';
	signal reset_n 	   : std_logic := '0';
	signal rd_a_addr_i : std_logic_vector(integer(ceil(log2(real(WIDTH))))-1 downto 0) := (others => '0');
	signal rd_b_addr_i : std_logic_vector(integer(ceil(log2(real(WIDTH))))-1 downto 0) := (others => '0');
	signal a_data_o	   : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
	signal b_data_o	   : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
	signal wrt_en_i	   : std_logic := '0';
	signal wrt_addr_i  : std_logic_vector(integer(ceil(log2(real(WIDTH))))-1 downto 0) := (others => '0');
	signal wrt_data_i  : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
	  
begin  
-- inicio do corpo da arquitetura

    -- Instancia de divisor_clock com nome dut, pode haver 
    -- quantas mais do que uma
    dut: register_bank 
    	generic map (
    		WIDTH => WIDTH
    	)
    	port map (
    		sysclk      => sysclk,
    		reset_n     => reset_n,
    		rd_a_addr_i => rd_a_addr_i,
        	rd_b_addr_i => rd_b_addr_i,
        	a_data_o    => a_data_o,
        	b_data_o    => b_data_o,
        	wrt_en_i    => wrt_en_i,
        	wrt_addr_i  => wrt_addr_i,
        	wrt_data_i  => wrt_data_i
	   );
	   
	-- Clock generation
  	sysclk <= not sysclk after 5 us;
  	
  	-- Reset generation
  	reset_proc: process
 	begin
    	reset_n <= '0';
    	wait for 50 us; 
    	reset_n <= '1';
    	wait;
  	end process reset_proc;
  	
    -- Stimulus generation
  	stimulus_proc_01 : process
  		variable counter : unsigned(integer(ceil(log2(real(WIDTH))))-1 downto 0) := (others => '0');
  		variable counter_2 : unsigned(WIDTH-1 downto 0) := (others => '0');
  	begin
  		wait for 50 US;
  		wrt_en_i <= '1';
  		wait for 20 US;
   		loop 
   			wrt_data_i <= std_logic_vector(counter_2);
      		wrt_addr_i <= std_logic_vector(counter);
      		wait for 10 US;
      		if counter = WIDTH-1 then
      			wrt_en_i <= '0';
        		wait;
      		end if;
      		counter := counter + 1;
      		counter_2 := counter_2 + 1;
    	end loop;
    	wait;
  	end process stimulus_proc_01;
  	
  	stimulus_proc_02 : process
  		variable counter : unsigned(integer(ceil(log2(real(WIDTH))))-1 downto 0) := (others => '0');
  	begin
  		wait for 100 US;
   		loop 
      		rd_a_addr_i <= std_logic_vector(counter);
      		rd_b_addr_i <= std_logic_vector(counter);
      		wait for 10 US;
      		if counter = WIDTH-1 then
        		wait;
      		end if;
      		counter := counter + 1;
    	end loop;
    	wait;
  	end process stimulus_proc_02;

END ARCHITECTURE stimulus;