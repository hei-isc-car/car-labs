onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Clock and Reset}
add wave -noupdate -color Gray60 /debounce_tb/I_tb/testInfo
add wave -noupdate -color Gray50 /debounce_tb/clock
add wave -noupdate -color Gray50 /debounce_tb/reset
add wave -noupdate -divider Input
add wave -noupdate -color {Dark Orchid} /debounce_tb/input
add wave -noupdate -radix unsigned /debounce_tb/I_debouncer/DELAY
add wave -noupdate -radix unsigned /debounce_tb/I_debouncer/lvec_count
add wave -noupdate -radix binary -childformat {{/debounce_tb/I_debouncer/lvec_sample(9) -radix binary} {/debounce_tb/I_debouncer/lvec_sample(8) -radix binary} {/debounce_tb/I_debouncer/lvec_sample(7) -radix binary} {/debounce_tb/I_debouncer/lvec_sample(6) -radix binary} {/debounce_tb/I_debouncer/lvec_sample(5) -radix binary} {/debounce_tb/I_debouncer/lvec_sample(4) -radix binary} {/debounce_tb/I_debouncer/lvec_sample(3) -radix binary} {/debounce_tb/I_debouncer/lvec_sample(2) -radix binary} {/debounce_tb/I_debouncer/lvec_sample(1) -radix binary} {/debounce_tb/I_debouncer/lvec_sample(0) -radix binary}} -subitemconfig {/debounce_tb/I_debouncer/lvec_sample(9) {-radix binary} /debounce_tb/I_debouncer/lvec_sample(8) {-radix binary} /debounce_tb/I_debouncer/lvec_sample(7) {-radix binary} /debounce_tb/I_debouncer/lvec_sample(6) {-radix binary} /debounce_tb/I_debouncer/lvec_sample(5) {-radix binary} /debounce_tb/I_debouncer/lvec_sample(4) {-radix binary} /debounce_tb/I_debouncer/lvec_sample(3) {-radix binary} /debounce_tb/I_debouncer/lvec_sample(2) {-radix binary} /debounce_tb/I_debouncer/lvec_sample(1) {-radix binary} /debounce_tb/I_debouncer/lvec_sample(0) {-radix binary}} /debounce_tb/I_debouncer/lvec_sample
add wave -noupdate /debounce_tb/I_debouncer/lsig_samplePulse
add wave -noupdate -divider {Debonced input}
add wave -noupdate -color Gold /debounce_tb/debounced
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {59062638 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 265
configure wave -valuecolwidth 100
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
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {86730947 ps}
