M913 E50                                                                      ; Reduce extruder motor current
G1 S1 E150 F2000                                                              ; Load until stall
M913 E100                                                                     ; Return extruder motor current
M302 S160 R110                                                                ; Disable cold extrusion
