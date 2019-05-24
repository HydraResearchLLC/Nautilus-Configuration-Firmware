M400                   				   ; make sure everything has stopped before we make changes
M574 U2 S3.9         				   ; set endstops to use motor stall
M913 U100       			   ; reduce motor current to 50% to prevent belts slipping
G91                   				   ; use relative positioning
G1 S1 U60 F3000 	                           ; home u
G90                  				   ; back to absolute positioning
M400                   				   ; make sure everything has stopped before we reset the motor currents
M913 X100 Y100 Z100 U100      		           ; motor currents back to normal
G4 P1
;G1 U48
;G4 P1
M574 U2 S3.9        				   ; set endstops to use motor stall
M913 U100       			   ; reduce motor current to 50% to prevent belts slipping
G91                   				   ; use relative positioning
G1 S1 U60 F3000 	                           ; home u
G90                  				   ; back to absolute positioning
M400                   				   ; make sure everything has stopped before we reset the motor currents
M913 X100 Y100 Z100 U100      		           ; motor currents back to normal


M581 E1 T2 S0 C0			      	   ; Only Unload if filament is present