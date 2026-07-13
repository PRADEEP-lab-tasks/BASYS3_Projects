// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Mon Dec 18 12:47:29 2023
// Host        : EEE_07 running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file {E:/VIVADO
//               PROJECTs/project_1/project_1.sim/sim_1/impl/timing/xsim/testbench_time_impl.v}
// Design      : demux_1_to_4
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* ECO_CHECKSUM = "75c3dc7b" *) 
(* NotValidForBitStream *)
(* \DesignAttr:ENABLE_NOC_NETLIST_VIEW  *) 
(* \DesignAttr:ENABLE_AIE_NETLIST_VIEW  *) 
module demux_1_to_4
   (din,
    sel,
    y0,
    y1,
    y2,
    y3);
  input [3:0]din;
  input [1:0]sel;
  output y0;
  output y1;
  output y2;
  output y3;

  wire [3:0]din;
  wire [3:0]din_IBUF;
  wire [1:0]sel;
  wire [1:0]sel_IBUF;
  wire y0;
  wire y0_OBUF;
  wire y1;
  wire y1_OBUF;
  wire y2;
  wire y2_OBUF;
  wire y3;
  wire y3_OBUF;

initial begin
 $sdf_annotate("testbench_time_impl.sdf",,,,"tool_control");
end
  IBUF \din_IBUF[0]_inst 
       (.I(din[0]),
        .O(din_IBUF[0]));
  IBUF \din_IBUF[1]_inst 
       (.I(din[1]),
        .O(din_IBUF[1]));
  IBUF \din_IBUF[2]_inst 
       (.I(din[2]),
        .O(din_IBUF[2]));
  IBUF \din_IBUF[3]_inst 
       (.I(din[3]),
        .O(din_IBUF[3]));
  IBUF \sel_IBUF[0]_inst 
       (.I(sel[0]),
        .O(sel_IBUF[0]));
  IBUF \sel_IBUF[1]_inst 
       (.I(sel[1]),
        .O(sel_IBUF[1]));
  OBUF y0_OBUF_inst
       (.I(y0_OBUF),
        .O(y0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h04)) 
    y0_OBUF_inst_i_1
       (.I0(sel_IBUF[0]),
        .I1(din_IBUF[0]),
        .I2(sel_IBUF[1]),
        .O(y0_OBUF));
  OBUF y1_OBUF_inst
       (.I(y1_OBUF),
        .O(y1));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h08)) 
    y1_OBUF_inst_i_1
       (.I0(din_IBUF[1]),
        .I1(sel_IBUF[0]),
        .I2(sel_IBUF[1]),
        .O(y1_OBUF));
  OBUF y2_OBUF_inst
       (.I(y2_OBUF),
        .O(y2));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h08)) 
    y2_OBUF_inst_i_1
       (.I0(sel_IBUF[1]),
        .I1(din_IBUF[2]),
        .I2(sel_IBUF[0]),
        .O(y2_OBUF));
  OBUF y3_OBUF_inst
       (.I(y3_OBUF),
        .O(y3));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h80)) 
    y3_OBUF_inst_i_1
       (.I0(sel_IBUF[1]),
        .I1(din_IBUF[3]),
        .I2(sel_IBUF[0]),
        .O(y3_OBUF));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
