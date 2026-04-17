.title 312611096 Lab1_NOT

*** Options
.protect
.include '../7nm_TT.pm'
.unprotect
.option post

*** Include
.include './not.sp'

*** Components
X1 VIN VOUT VDD NOT

*** Power Source
* [Voltage Source Name] [Node1] [Node2] [DC value]
V1 VDD GND 1.8V
* [Voltage Source Name] [Node1] [Node2]  PULSE(VL  VH  delay  trise  tfall  pulse_width  period)
V2 VIN GND PULSE(0V 1.8V 1ns 1ns 1ns 10us 20us)

*** Measurement
* Analysis Transient [incr] [stop]
.TRAN 0.5us 60us
.end