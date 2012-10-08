Presto
======

Presto is a simple open-source rolling plotter.

This device was part of my diploma graduation project, this is the basic frame I used to develop a specific online-connected printing device.

See a modified version of the frame here : https://vimeo.com/45618302.

The tool-head design is left to do considering what you want to use as a printing device, consider using a spring-loaded pen driven by a servo. I used a second Arduino checking the "MOTOR ON" output from the GrblShield (M3/M4 gcode instruction) to drive the servo to a "down" position, when sending a "MOTOR OFF" command (M5 gcode instruction) the Grblshield pin goes down and the servo is driven to an "up" position by the secondary Arduino, so there is no need to modify the Grbl CNC client to support Servo control (I originally used a simple ATTiny45 to sample the shield pin and drive the servo accordingly).

The BOM is available here http://kitbom.com/thibalte/presto.