; B 250 Tool Cartridge Offset

G10 P0 Z-1                                                                    ; Subtract Baby Stepping Value from the Z value of this line
M500                                                                          ; Save tool offset to config-override.g
M501                                                                          ; Reload config-override.g
