* subckt [circuit_name] [pVIN1] [...pVINx] [param1=value1] [..param]
.subckt NAND2 A B Q VDD
    * mos [drain] [gate] [source] [body] [p/n] [length] [width]
    M1 VDD A Q VDD pmos_lvt
    M2 VDD B Q VDD pmos_lvt
    M3 Q A 1 1 nmos_lvt
    M4 1 B GND GND nmos_lvt
.ends