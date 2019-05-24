; called before a print from SD card is resumed

G1 X-12.5 Y0 F6000                                                            ; Position over prime bucket
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
