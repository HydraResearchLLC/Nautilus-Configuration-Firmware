M280 P3 S160 I1                                                               ; Reset BLTouch
G4 P750                                                                       ; Wait .5 sec
M98 P/sys/deployprobe.g                                                       ; Deploy probe
G4 P750                                                                       ; Wait .5 sec
M98 P/sys/retractprobe.g                                                      ; Retract probe
