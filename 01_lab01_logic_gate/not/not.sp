* subckt [circuit_name] [pVIN1] [...pVINx] [param1=value1] [..param]
.subckt NOT VIN VOUT VDD
    * mos [drain] [gate] [source] [body] [p/n] [length] [width]
    M1 VOUT VIN VDD VDD pmos_lvt
    M2 VOUT VIN GND GND nmos_lvt
.ends