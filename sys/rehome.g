M300 S250 P1000																	; Play notification beep
G4 P250
M300 S250 P1000																	; Play notification beep
G4 P250
M291 P"A crash occured during printing. Printing will resume once recalibration is complete, please wait..." R"Crash Detected" S1 T30
M98  P/sys/homex.g
M98  P/sys/homey.g
