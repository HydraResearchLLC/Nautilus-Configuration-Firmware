M106 P0 I0 F40 L130 B.5 H-1                                                   ; Start printer with part cooling fan off
G29 S1                                                                        ; Call bed compensation height map
M98  P/sys/homez.g
M98  P/sys/homex.g
M98  P/sys/homey.g
T0                                                                            ; Activate tool 0
M501                                                                          ; Read stored parameters from sys/config-override
