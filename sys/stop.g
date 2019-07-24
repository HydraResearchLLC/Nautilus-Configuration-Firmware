; called when M0 (Stop) is run (e.g. when a print from SD card is cancelled)

M106 P0 I0 F250 L50 B0.1 H-1                                                  ; Start printer with part cooling fan off
M581 E1 T2 S-1 C1                                                             ; Disable filament sensor
G1 E-2 F2000
M140 S0                                                                       ; Turn off bed
M104 S0                                                                       ; Turn off extruder
M107
M98  P/sys/homez.g
