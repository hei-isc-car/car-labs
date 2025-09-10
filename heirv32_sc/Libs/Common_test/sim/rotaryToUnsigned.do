onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /rotarytounsigned_tb/reset
add wave -noupdate /rotarytounsigned_tb/clock
add wave -noupdate -format Analog-Step -height 50 -max 14.999999999999998 -radix unsigned -radixshowbase 0 /rotarytounsigned_tb/rotary
add wave -noupdate /rotarytounsigned_tb/I_DUT/glitchDelayCounter
add wave -noupdate -format Analog-Step -height 50 -max 14.999999999999998 -radix unsigned -childformat {{/rotarytounsigned_tb/I_DUT/rotaryStable(3) -radix unsigned} {/rotarytounsigned_tb/I_DUT/rotaryStable(2) -radix unsigned} {/rotarytounsigned_tb/I_DUT/rotaryStable(1) -radix unsigned} {/rotarytounsigned_tb/I_DUT/rotaryStable(0) -radix unsigned}} -radixshowbase 0 -subitemconfig {/rotarytounsigned_tb/I_DUT/rotaryStable(3) {-height 17 -radix unsigned -radixshowbase 0} /rotarytounsigned_tb/I_DUT/rotaryStable(2) {-height 17 -radix unsigned -radixshowbase 0} /rotarytounsigned_tb/I_DUT/rotaryStable(1) {-height 17 -radix unsigned -radixshowbase 0} /rotarytounsigned_tb/I_DUT/rotaryStable(0) {-height 17 -radix unsigned -radixshowbase 0}} /rotarytounsigned_tb/I_DUT/rotaryStable
add wave -noupdate -format Analog-Step -height 200 -max 63.0 -radix unsigned -radixshowbase 0 /rotarytounsigned_tb/number
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 243
configure wave -valuecolwidth 40
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {210 us}
