; called when a print from SD card is paused

M83                                                                           ; Relative extruder moves
G1 E-2 F3600                                                                  ; Retract 2mm of filament
G91                                                                           ; Relative positioning
G1 Z50 F1000                                                                  ; Drop Z 50mm
G90                                                                           ; Absolute positioning
G1 X200 Y200 F6000                                                            ; Go to back right
