onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Gray60 -label rst /heirv32_sc_tb/U_tester/rst
add wave -noupdate -color Gray60 -label clk /heirv32_sc_tb/U_tester/clk
add wave -noupdate -color Gray70 -label info /heirv32_sc_tb/U_tester/testInfo
add wave -noupdate -color {Violet Red} -label en /heirv32_sc_tb/U_tester/en
add wave -noupdate -expand -group PC -color Green -label PCNext /heirv32_sc_tb/U_heirv32/PCNext
add wave -noupdate -expand -group PC -color Green -label PC /heirv32_sc_tb/U_heirv32/PC
add wave -noupdate -expand -group PC -label PCPlus4 /heirv32_sc_tb/U_heirv32/PCPlus4
add wave -noupdate -expand -group {Instruction Memory} -color Gray65 -label MEMORY /heirv32_sc_tb/U_heirv32/U_instrMemory/larr_instr
add wave -noupdate -expand -group {Instruction Memory} -color Green -label PC /heirv32_sc_tb/U_heirv32/PC
add wave -noupdate -expand -group {Instruction Memory} -label instruction /heirv32_sc_tb/U_heirv32/instruction
add wave -noupdate -expand -group {Control Unit} -color Green -label op /heirv32_sc_tb/U_heirv32/U_controlUnit/op
add wave -noupdate -expand -group {Control Unit} -color Green -label funct3 /heirv32_sc_tb/U_heirv32/U_controlUnit/funct3
add wave -noupdate -expand -group {Control Unit} -color Green -label funct7 /heirv32_sc_tb/U_heirv32/U_controlUnit/funct7
add wave -noupdate -expand -group {Control Unit} -color Green -label zero /heirv32_sc_tb/U_heirv32/U_controlUnit/zero
add wave -noupdate -expand -group {Control Unit} -label resultSrc /heirv32_sc_tb/U_heirv32/U_controlUnit/resultSrc
add wave -noupdate -expand -group {Control Unit} -label memWrite /heirv32_sc_tb/U_heirv32/U_controlUnit/memWrite
add wave -noupdate -expand -group {Control Unit} -label ALUControl /heirv32_sc_tb/U_heirv32/U_controlUnit/ALUControl
add wave -noupdate -expand -group {Control Unit} -label ALUSrc /heirv32_sc_tb/U_heirv32/U_controlUnit/ALUSrc
add wave -noupdate -expand -group {Control Unit} -label immSrc /heirv32_sc_tb/U_heirv32/U_controlUnit/immSrc
add wave -noupdate -expand -group {Control Unit} -label regWrite /heirv32_sc_tb/U_heirv32/U_controlUnit/regwrite
add wave -noupdate -expand -group Registers -color Gray65 -label REGS /heirv32_sc_tb/U_heirv32/U_registerFile/larr_registers
add wave -noupdate -expand -group Registers -label addr1 /heirv32_sc_tb/U_heirv32/U_registerFile/addr1
add wave -noupdate -expand -group Registers -label addr2 /heirv32_sc_tb/U_heirv32/U_registerFile/addr2
add wave -noupdate -expand -group Registers -label addr3 /heirv32_sc_tb/U_heirv32/U_registerFile/addr3
add wave -noupdate -expand -group Registers -label writeEnable3 /heirv32_sc_tb/U_heirv32/U_registerFile/writeEnable3
add wave -noupdate -expand -group Registers -color {Violet Red} -label btns /heirv32_sc_tb/U_heirv32/U_registerFile/btns
add wave -noupdate -expand -group Registers -label RD1 /heirv32_sc_tb/U_heirv32/U_registerFile/RD1
add wave -noupdate -expand -group Registers -label RD2 /heirv32_sc_tb/U_heirv32/U_registerFile/RD2
add wave -noupdate -expand -group Registers -color {Violet Red} -label leds /heirv32_sc_tb/U_heirv32/U_registerFile/leds
add wave -noupdate -expand -group Extend -label ext_input /heirv32_sc_tb/U_heirv32/U_extend/input
add wave -noupdate -expand -group Extend -label immSrc /heirv32_sc_tb/U_heirv32/U_controlUnit/immSrc
add wave -noupdate -expand -group Extend -label immExt /heirv32_sc_tb/U_heirv32/immExt
add wave -noupdate -expand -group Extend -label PCTarget /heirv32_sc_tb/U_heirv32/U_beqAdder/out1
add wave -noupdate -expand -group ALU -color Green -label ctrl /heirv32_sc_tb/U_heirv32/U_alu/ctrl
add wave -noupdate -expand -group ALU -color Green -label srcA /heirv32_sc_tb/U_heirv32/U_alu/srcA
add wave -noupdate -expand -group ALU -color Green -label srcB /heirv32_sc_tb/U_heirv32/U_alu/srcB
add wave -noupdate -expand -group ALU -label zero /heirv32_sc_tb/U_heirv32/U_alu/zero
add wave -noupdate -expand -group ALU -label res /heirv32_sc_tb/U_heirv32/U_alu/res
add wave -noupdate -expand -group {Data Memory} -color Gray65 -label MEMORY /heirv32_sc_tb/U_heirv32/U_dataMemory/larr_data
add wave -noupdate -expand -group {Data Memory} -label writeEn /heirv32_sc_tb/U_heirv32/U_dataMemory/writeEn
add wave -noupdate -expand -group {Data Memory} -label writeData /heirv32_sc_tb/U_heirv32/U_dataMemory/writeData
add wave -noupdate -expand -group {Data Memory} -label address /heirv32_sc_tb/U_heirv32/U_dataMemory/address
add wave -noupdate -expand -group {Data Memory} -label readData /heirv32_sc_tb/U_heirv32/U_dataMemory/readData
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {301765 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 214
configure wave -valuecolwidth 252
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {2236408 ps}
