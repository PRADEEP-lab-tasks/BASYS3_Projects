/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
IKI_DLLESPEC extern void execute_54(char*, char *);
IKI_DLLESPEC extern void execute_344(char*, char *);
IKI_DLLESPEC extern void execute_345(char*, char *);
IKI_DLLESPEC extern void execute_3(char*, char *);
IKI_DLLESPEC extern void vlog_const_rhs_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
IKI_DLLESPEC extern void execute_312(char*, char *);
IKI_DLLESPEC extern void execute_313(char*, char *);
IKI_DLLESPEC extern void execute_314(char*, char *);
IKI_DLLESPEC extern void execute_315(char*, char *);
IKI_DLLESPEC extern void execute_316(char*, char *);
IKI_DLLESPEC extern void execute_317(char*, char *);
IKI_DLLESPEC extern void execute_318(char*, char *);
IKI_DLLESPEC extern void execute_319(char*, char *);
IKI_DLLESPEC extern void execute_320(char*, char *);
IKI_DLLESPEC extern void execute_321(char*, char *);
IKI_DLLESPEC extern void execute_322(char*, char *);
IKI_DLLESPEC extern void execute_323(char*, char *);
IKI_DLLESPEC extern void execute_324(char*, char *);
IKI_DLLESPEC extern void execute_325(char*, char *);
IKI_DLLESPEC extern void execute_326(char*, char *);
IKI_DLLESPEC extern void execute_327(char*, char *);
IKI_DLLESPEC extern void execute_328(char*, char *);
IKI_DLLESPEC extern void execute_329(char*, char *);
IKI_DLLESPEC extern void execute_330(char*, char *);
IKI_DLLESPEC extern void execute_331(char*, char *);
IKI_DLLESPEC extern void execute_332(char*, char *);
IKI_DLLESPEC extern void execute_333(char*, char *);
IKI_DLLESPEC extern void execute_334(char*, char *);
IKI_DLLESPEC extern void execute_335(char*, char *);
IKI_DLLESPEC extern void execute_336(char*, char *);
IKI_DLLESPEC extern void execute_337(char*, char *);
IKI_DLLESPEC extern void execute_338(char*, char *);
IKI_DLLESPEC extern void execute_339(char*, char *);
IKI_DLLESPEC extern void execute_340(char*, char *);
IKI_DLLESPEC extern void execute_341(char*, char *);
IKI_DLLESPEC extern void execute_342(char*, char *);
IKI_DLLESPEC extern void execute_343(char*, char *);
IKI_DLLESPEC extern void execute_60(char*, char *);
IKI_DLLESPEC extern void execute_66(char*, char *);
IKI_DLLESPEC extern void vlog_timingcheck_execute_0(char*, char*, char*);
IKI_DLLESPEC extern void execute_69(char*, char *);
IKI_DLLESPEC extern void execute_70(char*, char *);
IKI_DLLESPEC extern void execute_71(char*, char *);
IKI_DLLESPEC extern void execute_14(char*, char *);
IKI_DLLESPEC extern void execute_73(char*, char *);
IKI_DLLESPEC extern void execute_74(char*, char *);
IKI_DLLESPEC extern void execute_75(char*, char *);
IKI_DLLESPEC extern void execute_76(char*, char *);
IKI_DLLESPEC extern void execute_77(char*, char *);
IKI_DLLESPEC extern void execute_78(char*, char *);
IKI_DLLESPEC extern void execute_79(char*, char *);
IKI_DLLESPEC extern void execute_80(char*, char *);
IKI_DLLESPEC extern void execute_72(char*, char *);
IKI_DLLESPEC extern void execute_17(char*, char *);
IKI_DLLESPEC extern void execute_19(char*, char *);
IKI_DLLESPEC extern void execute_20(char*, char *);
IKI_DLLESPEC extern void execute_84(char*, char *);
IKI_DLLESPEC extern void execute_87(char*, char *);
IKI_DLLESPEC extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
IKI_DLLESPEC extern void execute_89(char*, char *);
IKI_DLLESPEC extern void execute_90(char*, char *);
IKI_DLLESPEC extern void execute_91(char*, char *);
IKI_DLLESPEC extern void execute_92(char*, char *);
IKI_DLLESPEC extern void execute_93(char*, char *);
IKI_DLLESPEC extern void execute_94(char*, char *);
IKI_DLLESPEC extern void execute_95(char*, char *);
IKI_DLLESPEC extern void execute_96(char*, char *);
IKI_DLLESPEC extern void execute_97(char*, char *);
IKI_DLLESPEC extern void execute_99(char*, char *);
IKI_DLLESPEC extern void execute_100(char*, char *);
IKI_DLLESPEC extern void execute_101(char*, char *);
IKI_DLLESPEC extern void execute_102(char*, char *);
IKI_DLLESPEC extern void execute_103(char*, char *);
IKI_DLLESPEC extern void execute_104(char*, char *);
IKI_DLLESPEC extern void execute_105(char*, char *);
IKI_DLLESPEC extern void execute_106(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_73(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_74(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_75(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_76(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_77(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_78(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_79(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_80(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_81(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_82(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_83(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_84(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_85(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_86(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_87(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_88(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_89(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_90(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_91(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_92(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_93(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_94(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_95(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_96(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_97(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_98(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_99(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_100(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_101(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_102(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_103(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_104(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_105(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_106(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_107(char*, char *);
IKI_DLLESPEC extern void timing_checker_condition_m_99662441_f4d1fc17_108(char*, char *);
IKI_DLLESPEC extern void execute_133(char*, char *);
IKI_DLLESPEC extern void execute_141(char*, char *);
IKI_DLLESPEC extern void execute_142(char*, char *);
IKI_DLLESPEC extern void execute_143(char*, char *);
IKI_DLLESPEC extern void execute_107(char*, char *);
IKI_DLLESPEC extern void execute_26(char*, char *);
IKI_DLLESPEC extern void execute_154(char*, char *);
IKI_DLLESPEC extern void execute_155(char*, char *);
IKI_DLLESPEC extern void execute_156(char*, char *);
IKI_DLLESPEC extern void execute_157(char*, char *);
IKI_DLLESPEC extern void execute_153(char*, char *);
IKI_DLLESPEC extern void execute_41(char*, char *);
IKI_DLLESPEC extern void execute_236(char*, char *);
IKI_DLLESPEC extern void execute_237(char*, char *);
IKI_DLLESPEC extern void execute_235(char*, char *);
IKI_DLLESPEC extern void execute_56(char*, char *);
IKI_DLLESPEC extern void execute_57(char*, char *);
IKI_DLLESPEC extern void execute_58(char*, char *);
IKI_DLLESPEC extern void execute_59(char*, char *);
IKI_DLLESPEC extern void execute_346(char*, char *);
IKI_DLLESPEC extern void execute_347(char*, char *);
IKI_DLLESPEC extern void execute_348(char*, char *);
IKI_DLLESPEC extern void execute_349(char*, char *);
IKI_DLLESPEC extern void execute_350(char*, char *);
IKI_DLLESPEC extern void execute_351(char*, char *);
IKI_DLLESPEC extern void transaction_2(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_3(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_4(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_5(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_6(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_7(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_8(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_9(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_10(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_11(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_12(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_13(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_14(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_15(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_16(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_17(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_18(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_19(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_20(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_21(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_22(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_23(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_24(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_25(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_26(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_27(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_28(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_29(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_30(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_31(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_32(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_33(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_34(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_35(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_36(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_37(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_38(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_39(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_40(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_41(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_42(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_43(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_44(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_45(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_46(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_47(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_48(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_49(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_50(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_51(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_52(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_53(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_54(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_55(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[192] = {(funcp)execute_54, (funcp)execute_344, (funcp)execute_345, (funcp)execute_3, (funcp)vlog_const_rhs_process_execute_0_fast_no_reg_no_agg, (funcp)execute_312, (funcp)execute_313, (funcp)execute_314, (funcp)execute_315, (funcp)execute_316, (funcp)execute_317, (funcp)execute_318, (funcp)execute_319, (funcp)execute_320, (funcp)execute_321, (funcp)execute_322, (funcp)execute_323, (funcp)execute_324, (funcp)execute_325, (funcp)execute_326, (funcp)execute_327, (funcp)execute_328, (funcp)execute_329, (funcp)execute_330, (funcp)execute_331, (funcp)execute_332, (funcp)execute_333, (funcp)execute_334, (funcp)execute_335, (funcp)execute_336, (funcp)execute_337, (funcp)execute_338, (funcp)execute_339, (funcp)execute_340, (funcp)execute_341, (funcp)execute_342, (funcp)execute_343, (funcp)execute_60, (funcp)execute_66, (funcp)vlog_timingcheck_execute_0, (funcp)execute_69, (funcp)execute_70, (funcp)execute_71, (funcp)execute_14, (funcp)execute_73, (funcp)execute_74, (funcp)execute_75, (funcp)execute_76, (funcp)execute_77, (funcp)execute_78, (funcp)execute_79, (funcp)execute_80, (funcp)execute_72, (funcp)execute_17, (funcp)execute_19, (funcp)execute_20, (funcp)execute_84, (funcp)execute_87, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_89, (funcp)execute_90, (funcp)execute_91, (funcp)execute_92, (funcp)execute_93, (funcp)execute_94, (funcp)execute_95, (funcp)execute_96, (funcp)execute_97, (funcp)execute_99, (funcp)execute_100, (funcp)execute_101, (funcp)execute_102, (funcp)execute_103, (funcp)execute_104, (funcp)execute_105, (funcp)execute_106, (funcp)timing_checker_condition_m_99662441_f4d1fc17_73, (funcp)timing_checker_condition_m_99662441_f4d1fc17_74, (funcp)timing_checker_condition_m_99662441_f4d1fc17_75, (funcp)timing_checker_condition_m_99662441_f4d1fc17_76, (funcp)timing_checker_condition_m_99662441_f4d1fc17_77, (funcp)timing_checker_condition_m_99662441_f4d1fc17_78, (funcp)timing_checker_condition_m_99662441_f4d1fc17_79, (funcp)timing_checker_condition_m_99662441_f4d1fc17_80, (funcp)timing_checker_condition_m_99662441_f4d1fc17_81, (funcp)timing_checker_condition_m_99662441_f4d1fc17_82, (funcp)timing_checker_condition_m_99662441_f4d1fc17_83, (funcp)timing_checker_condition_m_99662441_f4d1fc17_84, (funcp)timing_checker_condition_m_99662441_f4d1fc17_85, (funcp)timing_checker_condition_m_99662441_f4d1fc17_86, (funcp)timing_checker_condition_m_99662441_f4d1fc17_87, (funcp)timing_checker_condition_m_99662441_f4d1fc17_88, (funcp)timing_checker_condition_m_99662441_f4d1fc17_89, (funcp)timing_checker_condition_m_99662441_f4d1fc17_90, (funcp)timing_checker_condition_m_99662441_f4d1fc17_91, (funcp)timing_checker_condition_m_99662441_f4d1fc17_92, (funcp)timing_checker_condition_m_99662441_f4d1fc17_93, (funcp)timing_checker_condition_m_99662441_f4d1fc17_94, (funcp)timing_checker_condition_m_99662441_f4d1fc17_95, (funcp)timing_checker_condition_m_99662441_f4d1fc17_96, (funcp)timing_checker_condition_m_99662441_f4d1fc17_97, (funcp)timing_checker_condition_m_99662441_f4d1fc17_98, (funcp)timing_checker_condition_m_99662441_f4d1fc17_99, (funcp)timing_checker_condition_m_99662441_f4d1fc17_100, (funcp)timing_checker_condition_m_99662441_f4d1fc17_101, (funcp)timing_checker_condition_m_99662441_f4d1fc17_102, (funcp)timing_checker_condition_m_99662441_f4d1fc17_103, (funcp)timing_checker_condition_m_99662441_f4d1fc17_104, (funcp)timing_checker_condition_m_99662441_f4d1fc17_105, (funcp)timing_checker_condition_m_99662441_f4d1fc17_106, (funcp)timing_checker_condition_m_99662441_f4d1fc17_107, (funcp)timing_checker_condition_m_99662441_f4d1fc17_108, (funcp)execute_133, (funcp)execute_141, (funcp)execute_142, (funcp)execute_143, (funcp)execute_107, (funcp)execute_26, (funcp)execute_154, (funcp)execute_155, (funcp)execute_156, (funcp)execute_157, (funcp)execute_153, (funcp)execute_41, (funcp)execute_236, (funcp)execute_237, (funcp)execute_235, (funcp)execute_56, (funcp)execute_57, (funcp)execute_58, (funcp)execute_59, (funcp)execute_346, (funcp)execute_347, (funcp)execute_348, (funcp)execute_349, (funcp)execute_350, (funcp)execute_351, (funcp)transaction_2, (funcp)transaction_3, (funcp)transaction_4, (funcp)transaction_5, (funcp)transaction_6, (funcp)transaction_7, (funcp)transaction_8, (funcp)transaction_9, (funcp)transaction_10, (funcp)transaction_11, (funcp)transaction_12, (funcp)transaction_13, (funcp)transaction_14, (funcp)transaction_15, (funcp)transaction_16, (funcp)transaction_17, (funcp)transaction_18, (funcp)transaction_19, (funcp)transaction_20, (funcp)transaction_21, (funcp)transaction_22, (funcp)transaction_23, (funcp)transaction_24, (funcp)transaction_25, (funcp)transaction_26, (funcp)transaction_27, (funcp)transaction_28, (funcp)transaction_29, (funcp)transaction_30, (funcp)transaction_31, (funcp)transaction_32, (funcp)transaction_33, (funcp)transaction_34, (funcp)transaction_35, (funcp)transaction_36, (funcp)transaction_37, (funcp)transaction_38, (funcp)transaction_39, (funcp)transaction_40, (funcp)transaction_41, (funcp)transaction_42, (funcp)transaction_43, (funcp)transaction_44, (funcp)transaction_45, (funcp)transaction_46, (funcp)transaction_47, (funcp)transaction_48, (funcp)transaction_49, (funcp)transaction_50, (funcp)transaction_51, (funcp)transaction_52, (funcp)transaction_53, (funcp)transaction_54, (funcp)transaction_55, (funcp)vlog_transfunc_eventcallback};
const int NumRelocateId= 192;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/testbench_time_impl/xsim.reloc",  (void **)funcTab, 192);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/testbench_time_impl/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void wrapper_func_0(char *dp)

{

}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/testbench_time_impl/xsim.reloc");
	wrapper_func_0(dp);

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_xsimdir_location_if_remapped(argc, argv)  ;
    iki_set_sv_type_file_path_name("xsim.dir/testbench_time_impl/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/testbench_time_impl/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/testbench_time_impl/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
