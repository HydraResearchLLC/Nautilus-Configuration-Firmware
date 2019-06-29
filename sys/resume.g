; called before a print from SD card is resumed

T R1                                                                          ; Call last active tool
G1 X-12.5 Y0 F6000                                                            ; Position over prime bucket
M116                                                                          ; Wait for temps
G1 E15 F100                                                                   ; Prime
G1 E-1 F2200                                                                  ; Retract
G91                                                                           ; Relative positioning
G1 Z-40 F1000                                                                 ; Raise Z 40mm
G90                                                                           ; Absolute positioning
M98  P/sys/wipe.g                                                             ; Wipe
G1 E0.5 F1100                                                                 ; Prime filament back into nozzle
G1 R1 X0 Y0 Z5 F6000                                                          ; Go to 5mm above position of the last print move
G1 R1 X0 Y0                                                                   ; Go back to the last print move
M83                                                                           ; Relative extruder moves
