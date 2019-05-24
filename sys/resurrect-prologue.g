M291 P"Please make sure your part is still adhered to the bed before pressing ""OK"" to continue" R"Resume printing after power loss?" S3
G4 P100
M291 P"Re-homing..." R"Power Loss Recovery" S1
G4 P100
G28                                                                             ; home all
M291 P"Waiting to reach temperature" R"Power Loss Recovery" S1
G1 X-8 Y20 F6000                                                                ; Position over purge bucket
M116                                                                            ; wait for temperatures
M83                                                                             ; relative extrusion
G1 E15 F100                                                                     ; Prime
G1 E-1 F2200                                                                    ; retract
M98  P/sys/wipe.g                                                               ; wipe
G1 E0.5 F1100                                                                   ; Prime filament back into nozzle
