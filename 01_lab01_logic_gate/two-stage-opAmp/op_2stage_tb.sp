.title 312611096 Lab1_Bonus

*** Options
.protect
.include '../7nm_TT.pm'
.unprotect
.option post
*** Components
* mos [drain] [gate] [source] [body] [p/n] [length] [width]
* M1 3 1 5 0 nmos_lvt L=2u W=8u AS=18p AD=18p PS=18u PD=18u
* M2 4 2 5 0 nmos_lvt L=2u W=8u AS=18p AD=18p PS=18u PD=18u
* M3 3 3 VDD VDD pmos_lvt L=10u W=10u AS=12p AD=12p PS=16u PD=16u
* M4 4 3 VDD VDD pmos_lvt L=10u W=10u AS=12p AD=12p PS=16u PD=16u
* M5 5 VBIAS VSS VSS nmos_lvt L=2u W=7u AS=49p AD=49p PS=26u PD=26u
* M6 VOUT 4 VDD VDD pmos_lvt L=2u W=70u AS=490p AD=490p PS=150u PD=150u
* M7 VOUT VBIAS VSS VSS nmos_lvt L=2u W=130u AS=930p AD=930p PS=260u PD=260u
* M8 VBIAS VBIAS VSS VSS nmos_lvt L=2u W=7u AS=49p AD=49p PS=26u PD=26u
M1 3 1 5 0 nmos_lvt
* M1 3 vout 5 0 nmos_lvt
M2 4 2 5 0 nmos_lvt
M3 3 3 VDD VDD pmos_lvt
M4 4 3 VDD VDD pmos_lvt
M5 5 VBIAS VSS VSS nmos_lvt
M6 VOUT 4 VDD VDD pmos_lvt
M7 VOUT VBIAS VSS VSS nmos_lvt
M8 VBIAS VBIAS VSS VSS nmos_lvt
* Feedback CAP
Cc VOUT 4 0.44pF
Cl VOUT 0 4pF
lbias VDD VBIAS 8.8u

*** Power Source
.op
* [Voltage Source Name] [Node1] [Node2] [DC value]
VDD VDD GND 5V
VSS VSS GND 0V
Vin2 2 0 2.5V
* Vin2 2 0 pulse(0v 5v 1n 1p 1p 600n 1200n)
Vin1 1 0 DC 1.5V AC 1V
***  Measurement
* .tran 5n 1
* .prove tran
* .save all
* AC Analysis function
.AC dec 10 10 100MEG
.PROBE AC vdb(VOUT) vp(VOUT) vdb(4) vp(4)
.meas AC Unit_gain when vdb(VOUT)=0
.meas AC phase_mar FIND vp(VOUT) when vdb(VOUT)=0
.end