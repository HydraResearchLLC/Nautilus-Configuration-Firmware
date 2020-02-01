; Executed by the firmware on start-up

; GENERAL
G90                                                     ; Send absolute coordinates...
M83                                                     ; ...but relative extruder moves
M667 S1                                                 ; Select CoreXY mode

; NETWORK
M550 PHydra Research Nautilus                           ; Set machine name
M552 S1                                                 ; Enable network
M586 P0 S1                                              ; Enable HTTP
M586 P1 S0                                              ; Disable FTP
M586 P2 S0                                              ; Disable Telnet

; DRIVES
M584 X0 Y1 Z2 E3                                        ; Assign axis to drivers
M569 P0 S1                                              ; Drive 0 goes forwards
M569 P1 S1                                              ; Drive 1 goes forwards
M569 P2 S1                                              ; Drive 2 goes forwards
M569 P3 S1                                              ; Drive 3 goes forwards
M569 P4 S1                                              ; Drive 4 goes forwards

; MOTION CONFIG
M350 X16 Y16 Z16 E16 I1                                 ; Configure microstepping with interpolation
M92 X200 Y200 Z1600 E278                                ; Set steps per mm (E-true=292, E-effective=278 )
M566 X420 Y420 Z25 E800                                 ; Set maximum instantaneous speed changes (mm/min), Cura will override this
M203 X15000 Y15000 Z500 E12000                          ; Set maximum speeds (mm/min)
M201 X2200 Y2200 Z250 E1250                             ; Set accelerations (mm/s^2)
M204 P800 T2000                                         ; Set printing and travel accelerations, Cura will override this
M906 X1350 Y1350 Z1100 E1200 I80                        ; Set motor currents (mA) and motor idle factor in per cent
M84 S30                                                 ; Set idle timeout

; AXIS LIMITS
M208 X-8 Y-.625 Z0 S1                                   ; Set axis minima
M208 X209.75 Y206.875 Z225 S0                           ; Set axis maxima
M564 H1 S1                                              ; Disable movement without homing

; STALLGAURD/ENDSTOPS
M574 X2 Y2 S1                                           ; Configure X-max and Y-max endstops
M574 Z2 S1                                              ; Configure Z-max endstop
M915 X Y S8 F1 H400 R3                                  ; Configure Stall Guard for X and Y
M915 Z S23 F1 H200 R0                                   ; Configure Stall Guard for Z
M915 P3 S1.7 F1 H400 R0                                 ; Configure Stall Guard for E

; FILAMENT SENSOR
M591 D0 P1 C3 S1                                        ; Configure simple filament sensor pause print on runout

; Z-PROBE
M307 H3 A-1 C-1 D-1                                     ; Configure heater 3 for servo control
M558 P9 H3 R0.25 F375 T12000 A5 S0.012                  ; Set Z-probe type BLTouch
G31 X12 Y-29 Z2 P25                                     ; Set Z-probe trigger value, offset, and trigger height
M557 X5:205 Y5:176 P4:4                                 ; Define mesh grid

; HEATERS/SERVOS
M307 H0 B0 S1.00                                        ; Disable bang-bang mode for the bed heater and set PWM limit
M307 H2 A-1 C-1 D-1                                     ; Configure heater 2 for LEDs lighting
M42 P2 S255                                             ; Turn interior lighting on
M305 P0 T100000 B3950 C0 R4700                          ; Set thermistor + ADC parameters for heater 0
M143 H0 S127                                            ; Set temperature limit for heater 0 to 127C
M305 P1 X501 R4700                                      ; Configure PT1000 for heater 1
M143 H1 S308                                            ; Set temperature limit for heater 1 to 300C
M570 H0 P10 T10 S.1                                     ; Heater 0 fault detection
M570 H1 P10 T10 S.1                                     ; Heater 1 fault detection

; FANS
M106 P0 I0 F250 L25 B0.1 H-1                            ; Set fan 0 value, PWM signal inversion and frequency. Thermostatic control off
M106 P1 S1 I0 F500 H1 T50                               ; Set fan 1 value, PWM signal inversion and frequency. Thermostatic control is turned on
M106 P2 S1 I0 F500 H1 T50                               ; Configure fan 2 for air filter. Thermostatic control is turned on

; TOOLS
M563 P0 D0 H1                                           ; Define tool 0
G10 P0 X0 Y0 Z0                                         ; Set tool 0 axis offsets
G10 P0 R0 S0                                            ; Set initial tool 0 active and standby temperatures to 0C

; EXTRUSION
M572 D0 S0.05                                           ; Set default pressure advance value

; POWERLOSS
M911 S22.0 R23.0 P"M913 X0 Y0 G91 M83 G1 Z3 E-5 F1000"  ; Set voltage thresholds and actions to run on power loss

; INITIALIZE
M98  P/sys/initialize.g                                 ; Call initialization system file
M501                                                    ; Read stored parameters from sys/config-override
