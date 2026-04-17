.title 312611096 Lab1_AND2

*** Options
.protect
.include '../7nm_TT.pm'
.unprotect
.option post
*** Include
.include './and2.sp'

*** Components
X1 A B Q_bar VDD NAND2
X2 Q_bar Q VDD NOT

*** Power Source
* [Voltage Source Name] [Node1] [Node2] [DC value]
V1 VDD GND 1.8V
* [Voltage Source Name] [Node1] [Node2]  PULSE(VL  VH  delay  trise  tfall  pulse_width  period)
V2 A GND PULSE(0V 1.8V 1ns 1ns 1ns 5us 10us)
V3 B GND PULSE(0V 1.8V 1ns 1ns 1ns 10us 20us)

***  Measurement
* Analysis Transient [incr] [stop]
.TRAN 0.5us 60us
.end