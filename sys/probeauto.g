; bed.g
; called to perform automatic bed compensation via G32

M291 P"Bed level calibration in progress..." R"Auto Level Compensation" S1 T0
G91
G1 Z5 F3000
G90
M98 P/sys/homeall.g
M98 P/sys/probereset.g                                                        ; Reset BLTouch
G29 S2                                                                        ; Clear old bed level data
G1 X102.5 Y102.5 Z8                                                           ; Move to center of bed probe point
G30                                                                           ; Establish Z=0 datum
G29                                                                           ; Run mesh bed level calibration
G1 X-8 Y0 Z5 F4000
M292 P0
M291 P"Bed level calibration complete!" R"Auto Level Compensation" S1 T5
