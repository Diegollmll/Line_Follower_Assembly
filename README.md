# Line Follower in Assembly
This repository contents the tools and the tutorial to create a Line Follower using five sensors and the driver l298n

In the realization of this project, the PIC16F877A was chosen as the controller, due to its easy way to get and to use it, in the same way the l298n driver was used, due to that it performs an incredible job controlling DC motors and stepper motors. This line follower robot has a 5 sensor strip that generates an output for the inputs of the l298n driver, as well as generates the operation of three LEDs (2 yellow and 1 red) depending on the case. To carry out the programming code, the MPLABX software was used, making use of the assembly language, to later verify its operation in the Proteus Professional software.
The line follower robot moves along a 20mm wide line and stops at a 20cm wide black box.

This repository contents:

* Source code (Assembly)
* Simulation in Proteus Professional (File .pdsprj)
* Laboratory report

Software requeriments:

* MPLABX
* Proteus Professional
* PDF viewer

Hardware requeriments:

* PIC16F877A or similar
* Driver l298n
* Gearmotors
* Sensors strip
* Programmer Pickit

How to install:

* Download the software Proteus Professional
* Load the file .pdsprj
* Load the source code to obtain the file .Hex
* Load the file .Hex in the PIC16F877A in Proteus

Authors:

Universidad de Ibague - Electronica Digitral II

* Diego Alejandro Torres Urrego (https://github.com/Diegollmll)
* Luis Fernando Gomez Diaz
