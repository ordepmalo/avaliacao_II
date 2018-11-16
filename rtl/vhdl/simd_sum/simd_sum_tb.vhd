-------------------------------------------------------------------------------
-- Title         : Single Instruction, Multiple Data - SUM operation 
-- Project       : Avaliação II
-------------------------------------------------------------------------------
-- File          : simd_sum_tb.vhd
-- Author        : Pedro Messias Jose da Cunha Bastos
-- Created       : 2018-11-15
-------------------------------------------------------------------------------

-- Libraries and packages
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------
entity testbench is
end entity testbench;
-------------------------------------

architecture stimulus of testbench is
	
	-- Constants declarations
	constant WIDTH : natural := 4;
	--constant ADDR_WIDTH : natural := ceil(log2(WIDTH));
	
    -- Component declarations
	component simd_sum is
		port(
			sysclk   : in std_logic;
			reset_n  : in std_logic;
			add_op_i : in std_logic;
			data_a_i : in std_logic_vector(WIDTH-1 downto 0);
			data_b_i : in std_logic_vector(WIDTH-1 downto 0);
			done_o   : out std_logic;
			data_c_o : out std_logic_vector(WIDTH-1 downto 0)		
		);
	end component simd_sum;

    -- Signals declarations
    signal sysclk   : std_logic := '0';
	signal reset_n 	: std_logic := '0';
	signal add_op_i : std_logic := '0';
	signal data_a_i : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
	signal data_b_i	: std_logic_vector(WIDTH-1 downto 0) := (others => '0');
	signal done_o	: std_logic := '0';
	signal data_c_o	: std_logic_vector(WIDTH-1 downto 0) := (others => '0');
	    
begin  
-- inicio do corpo da arquitetura

    -- Instancia de divisor_clock com nome dut, pode haver 
    -- quantas mais do que uma
    dut: simd_sum 
    	generic map (
    		WIDTH => WIDTH)
    		--ADDR_WIDTH => ADDR_WIDTH)
    	port map (
    		sysclk   => sysclk,
    		reset_n  => reset_n,
    		add_op_i => add_op_i,
        	data_a_i => data_a_i,
        	data_b_i => data_b_i,
        	done_o   => done_o,
        	data_c_o => data_c_o
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
  		
  	begin
  		-- Add stimulus here
  		data_a_i <= "0001";
  		data_b_i <= "0001";
  		wait for 50 us;
  		add_op_i <= '1';
  		wait for 15 us;
  		data_a_i <= "1010";
  		data_b_i <= "1010";
  		add_op_i <= '0';
  		wait for 10 us;
  		add_op_i <= '1';
  		wait for 20 us;
  		add_op_i <= '0';
    	wait;
  	end process stimulus_proc_01;

END ARCHITECTURE stimulus;