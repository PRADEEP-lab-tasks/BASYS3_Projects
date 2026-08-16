## Created by Pradeep with the help of AI


## basys3_oled.xdc
## Constraints for: switches -> decimal value -> Pmod OLED (SSD1306) on JB
## Pin data taken from Digilent's official Basys3_Master.xdc and the
## PmodOLED reference manual.

## 100 MHz system clock
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Slide switches SW0 (LSB) .. SW15 (MSB)
set_property PACKAGE_PIN V17 [get_ports {sw[0]}]
set_property PACKAGE_PIN V16 [get_ports {sw[1]}]
set_property PACKAGE_PIN W16 [get_ports {sw[2]}]
set_property PACKAGE_PIN W17 [get_ports {sw[3]}]
set_property PACKAGE_PIN W15 [get_ports {sw[4]}]
set_property PACKAGE_PIN V15 [get_ports {sw[5]}]
set_property PACKAGE_PIN W14 [get_ports {sw[6]}]
set_property PACKAGE_PIN W13 [get_ports {sw[7]}]
set_property PACKAGE_PIN V2  [get_ports {sw[8]}]
set_property PACKAGE_PIN T3  [get_ports {sw[9]}]
set_property PACKAGE_PIN T2  [get_ports {sw[10]}]
set_property PACKAGE_PIN R3  [get_ports {sw[11]}]
set_property PACKAGE_PIN W2  [get_ports {sw[12]}]
set_property PACKAGE_PIN U1  [get_ports {sw[13]}]
set_property PACKAGE_PIN T1  [get_ports {sw[14]}]
set_property PACKAGE_PIN R2  [get_ports {sw[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[*]}]

## Center pushbutton (manual reset / force redraw)
set_property PACKAGE_PIN U18 [get_ports btnC]
set_property IOSTANDARD LVCMOS33 [get_ports btnC]

## Pmod OLED on connector JB
## JB1=CS  JB2=SDIN  JB3=N/C  JB4=SCLK  JB7=D/C  JB8=RES  JB9=VBATC  JB10=VDDC
set_property PACKAGE_PIN A14 [get_ports oled_cs]
set_property PACKAGE_PIN A16 [get_ports oled_sdin]
set_property PACKAGE_PIN B16 [get_ports oled_sclk]
set_property PACKAGE_PIN A15 [get_ports oled_dc]
set_property PACKAGE_PIN A17 [get_ports oled_res]
set_property PACKAGE_PIN C15 [get_ports oled_vbat]
set_property PACKAGE_PIN C16 [get_ports oled_vdd]
set_property IOSTANDARD LVCMOS33 [get_ports {oled_cs oled_sdin oled_sclk oled_dc oled_res oled_vbat oled_vdd}]
