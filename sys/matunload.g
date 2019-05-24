
G1 X-8 Y20 F4000                                                              ; Position over purge bucket
G1 E1.45 F175                                                                 ; Ramming stage 1
G1 E1.51 F181                                                                 ; Ramming stage 2
G1 E1.66 F200                                                                 ; Ramming stage 3
G1 E1.77 F212                                                                 ; Ramming stage 4
G1 E1.98 F237                                                                 ; Ramming stage 5
G1 E-15.0000 F6000                                                            ; Retract fast at first
G1 E-14.0000 F1200                                                            ; Retract into cold zone
G1 E-4.0000 F600                                                              ; Slowdown retract 1
G1 E-2.0000 F360                                                              ; Slowdown retract 2
G1 E10.0000 F475                                                              ; Cooling move 1
G1 E-10.0000 F237                                                             ; Cooling move 2
