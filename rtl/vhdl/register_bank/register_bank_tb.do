-------------------------------------------------------------------------------
-- Title         : Single Instruction, Multiple Data - SUM operation 
-- Project       : Avalia��o II
-------------------------------------------------------------------------------
-- File          : simd_sum_tb.do
-- Author        : Pedro Messias Jose da Cunha Bastos
-- Created       : 2018-11-12
-------------------------------------------------------------------------------

#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom register_n.vhd
vcom register_bank.vhd
vcom register_bank_tb.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.testbench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary /dut/sysclk
add wave -radix binary /dut/reset_n
add wave -radix binary /dut/wrt_en_i
add wave -radix hex /dut/wrt_addr_i
add wave -radix hex /dut/wrt_data_i
add wave -radix hex /dut/registers
add wave -radix hex /dut/reg_sel_int
add wave -radix hex /dut/rd_a_addr_i
add wave -radix hex /dut/a_data_o
add wave -radix hex /dut/rd_b_addr_i
add wave -radix hex /dut/b_data_o

#Como mostrar sinais internos do processo

#Simula até um 500ns
run 500us

wave zoomfull
write wave wave.ps
