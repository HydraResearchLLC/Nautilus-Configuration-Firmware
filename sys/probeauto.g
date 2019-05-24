; bed.g
; called to perform automatic bed compensation via G32

M291 P"Bed level calibration in progress..." R"Auto Level Compensation" S1 T0
G91
G1 Z5 F3000
G90
M98 P/sys/homeall.g
M561                                                                          ; clear old bed level data
G29 S2                                                                        ; clear old bed level data
G29
G1 X-8 Y0 Z5 F4000
M292 P0
M291 P"Bed level calibration complete!" R"Auto Level Compensation" S1 T5
