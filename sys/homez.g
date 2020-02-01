G91                                                                           ; Relative positioning
G1 S1 Z240 F2000                                                              ; course home Z
G1 Z-4 F300                                                                   ; move away from the endstops
G1 S1 Z10                                                                     ; fine home Z
G90                                                                           ; Absolute positioning
G1 Z223 F1000                                                                 ; Lift Z slightly to avoid intermediate position errors                                                                            ; Activate tool 0
