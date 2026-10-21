/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/ise/ISE_146/ethernet/mlp/weight_rom.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_1242562249;

int ieee_p_1242562249_sub_17802405650254020620_1035706684(char *, char *, char *);
char *ieee_p_1242562249_sub_2749763749646623249_1035706684(char *, char *, char *, char *, int );
unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_3912748731_3212880686_p_0(char *t0)
{
    char t27[16];
    char t28[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    int t5;
    char *t6;
    char *t7;
    char *t8;
    int t9;
    int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    int t15;
    int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;

LAB0:    xsi_set_current_line(319, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 5680);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(320, ng0);
    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t3 = (t0 + 10568U);
    t5 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t4, t3);
    if (t5 == 0)
        goto LAB6;

LAB11:    if (t5 == 1)
        goto LAB7;

LAB12:    if (t5 == 2)
        goto LAB8;

LAB13:    if (t5 == 3)
        goto LAB9;

LAB14:
LAB10:    xsi_set_current_line(334, ng0);
    t1 = xsi_get_transient_memory(16U);
    memset(t1, 0, 16U);
    t3 = t1;
    memset(t3, (unsigned char)2, 16U);
    t4 = (t0 + 5792);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t13 = *((char **)t8);
    memcpy(t13, t1, 16U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(335, ng0);
    t1 = xsi_get_transient_memory(16U);
    memset(t1, 0, 16U);
    t3 = t1;
    memset(t3, (unsigned char)2, 16U);
    t4 = (t0 + 5856);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t13 = *((char **)t8);
    memcpy(t13, t1, 16U);
    xsi_driver_first_trans_fast(t4);

LAB5:    goto LAB3;

LAB6:    xsi_set_current_line(322, ng0);
    t6 = (t0 + 2152U);
    t7 = *((char **)t6);
    t6 = (t0 + 1352U);
    t8 = *((char **)t6);
    t6 = (t0 + 10584U);
    t9 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t8, t6);
    t10 = (t9 - 0);
    t11 = (t10 * 1);
    xsi_vhdl_check_range_of_index(0, 63, 1, t9);
    t12 = (t11 * 40U);
    t13 = (t0 + 1512U);
    t14 = *((char **)t13);
    t13 = (t0 + 10600U);
    t15 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t14, t13);
    t16 = (t15 - 0);
    t17 = (t16 * 1);
    xsi_vhdl_check_range_of_index(0, 39, 1, t15);
    t18 = (t12 + t17);
    t19 = (16U * t18);
    t20 = (0 + t19);
    t21 = (t7 + t20);
    t22 = (t0 + 5792);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    memcpy(t26, t21, 16U);
    xsi_driver_first_trans_fast(t22);
    xsi_set_current_line(323, ng0);
    t1 = (t0 + 2312U);
    t3 = *((char **)t1);
    t1 = (t0 + 1832U);
    t4 = *((char **)t1);
    t1 = (t0 + 10632U);
    t5 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t4, t1);
    t9 = (t5 - 0);
    t11 = (t9 * 1);
    xsi_vhdl_check_range_of_index(0, 63, 1, t5);
    t12 = (16U * t11);
    t17 = (0 + t12);
    t6 = (t3 + t17);
    t7 = (t0 + 5856);
    t8 = (t7 + 56U);
    t13 = *((char **)t8);
    t14 = (t13 + 56U);
    t21 = *((char **)t14);
    memcpy(t21, t6, 16U);
    xsi_driver_first_trans_fast(t7);
    goto LAB5;

LAB7:    xsi_set_current_line(325, ng0);
    t1 = (t0 + 2472U);
    t3 = *((char **)t1);
    t1 = (t0 + 1352U);
    t4 = *((char **)t1);
    t1 = (t0 + 10584U);
    t5 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t4, t1);
    t9 = (t5 - 0);
    t11 = (t9 * 1);
    xsi_vhdl_check_range_of_index(0, 31, 1, t5);
    t12 = (t11 * 64U);
    t6 = (t0 + 1512U);
    t7 = *((char **)t6);
    t6 = (t0 + 10600U);
    t10 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t7, t6);
    t15 = (t10 - 0);
    t17 = (t15 * 1);
    xsi_vhdl_check_range_of_index(0, 63, 1, t10);
    t18 = (t12 + t17);
    t19 = (16U * t18);
    t20 = (0 + t19);
    t8 = (t3 + t20);
    t13 = (t0 + 5792);
    t14 = (t13 + 56U);
    t21 = *((char **)t14);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    memcpy(t23, t8, 16U);
    xsi_driver_first_trans_fast(t13);
    xsi_set_current_line(326, ng0);
    t1 = (t0 + 2632U);
    t3 = *((char **)t1);
    t1 = (t0 + 1832U);
    t4 = *((char **)t1);
    t1 = (t0 + 10632U);
    t5 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t4, t1);
    t9 = (t5 - 0);
    t11 = (t9 * 1);
    xsi_vhdl_check_range_of_index(0, 31, 1, t5);
    t12 = (16U * t11);
    t17 = (0 + t12);
    t6 = (t3 + t17);
    t7 = (t0 + 5856);
    t8 = (t7 + 56U);
    t13 = *((char **)t8);
    t14 = (t13 + 56U);
    t21 = *((char **)t14);
    memcpy(t21, t6, 16U);
    xsi_driver_first_trans_fast(t7);
    goto LAB5;

LAB8:    xsi_set_current_line(328, ng0);
    t1 = (t0 + 2792U);
    t3 = *((char **)t1);
    t1 = (t0 + 1352U);
    t4 = *((char **)t1);
    t1 = (t0 + 10584U);
    t5 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t4, t1);
    t9 = (t5 - 0);
    t11 = (t9 * 1);
    xsi_vhdl_check_range_of_index(0, 15, 1, t5);
    t12 = (t11 * 32U);
    t6 = (t0 + 1512U);
    t7 = *((char **)t6);
    t6 = (t0 + 10600U);
    t10 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t7, t6);
    t15 = (t10 - 0);
    t17 = (t15 * 1);
    xsi_vhdl_check_range_of_index(0, 31, 1, t10);
    t18 = (t12 + t17);
    t19 = (16U * t18);
    t20 = (0 + t19);
    t8 = (t3 + t20);
    t13 = (t0 + 5792);
    t14 = (t13 + 56U);
    t21 = *((char **)t14);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    memcpy(t23, t8, 16U);
    xsi_driver_first_trans_fast(t13);
    xsi_set_current_line(329, ng0);
    t1 = (t0 + 2952U);
    t3 = *((char **)t1);
    t1 = (t0 + 1832U);
    t4 = *((char **)t1);
    t1 = (t0 + 10632U);
    t5 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t4, t1);
    t9 = (t5 - 0);
    t11 = (t9 * 1);
    xsi_vhdl_check_range_of_index(0, 15, 1, t5);
    t12 = (16U * t11);
    t17 = (0 + t12);
    t6 = (t3 + t17);
    t7 = (t0 + 5856);
    t8 = (t7 + 56U);
    t13 = *((char **)t8);
    t14 = (t13 + 56U);
    t21 = *((char **)t14);
    memcpy(t21, t6, 16U);
    xsi_driver_first_trans_fast(t7);
    goto LAB5;

LAB9:    xsi_set_current_line(331, ng0);
    t1 = (t0 + 3112U);
    t3 = *((char **)t1);
    t1 = (t0 + 1352U);
    t4 = *((char **)t1);
    t11 = (5 - 1);
    t12 = (t11 * 1U);
    t17 = (0 + t12);
    t1 = (t4 + t17);
    t6 = (t28 + 0U);
    t7 = (t6 + 0U);
    *((int *)t7) = 1;
    t7 = (t6 + 4U);
    *((int *)t7) = 0;
    t7 = (t6 + 8U);
    *((int *)t7) = -1;
    t5 = (0 - 1);
    t18 = (t5 * -1);
    t18 = (t18 + 1);
    t7 = (t6 + 12U);
    *((unsigned int *)t7) = t18;
    t7 = ieee_p_1242562249_sub_2749763749646623249_1035706684(IEEE_P_1242562249, t27, t1, t28, 2);
    t9 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t7, t27);
    t10 = (t9 - 0);
    t18 = (t10 * 1);
    xsi_vhdl_check_range_of_index(0, 2, 1, t9);
    t19 = (t18 * 16U);
    t8 = (t0 + 1512U);
    t13 = *((char **)t8);
    t8 = (t0 + 10600U);
    t15 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t13, t8);
    t16 = (t15 - 0);
    t20 = (t16 * 1);
    xsi_vhdl_check_range_of_index(0, 15, 1, t15);
    t29 = (t19 + t20);
    t30 = (16U * t29);
    t31 = (0 + t30);
    t14 = (t3 + t31);
    t21 = (t0 + 5792);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t14, 16U);
    xsi_driver_first_trans_fast(t21);
    xsi_set_current_line(332, ng0);
    t1 = (t0 + 3272U);
    t3 = *((char **)t1);
    t1 = (t0 + 1832U);
    t4 = *((char **)t1);
    t11 = (5 - 1);
    t12 = (t11 * 1U);
    t17 = (0 + t12);
    t1 = (t4 + t17);
    t6 = (t28 + 0U);
    t7 = (t6 + 0U);
    *((int *)t7) = 1;
    t7 = (t6 + 4U);
    *((int *)t7) = 0;
    t7 = (t6 + 8U);
    *((int *)t7) = -1;
    t5 = (0 - 1);
    t18 = (t5 * -1);
    t18 = (t18 + 1);
    t7 = (t6 + 12U);
    *((unsigned int *)t7) = t18;
    t7 = ieee_p_1242562249_sub_2749763749646623249_1035706684(IEEE_P_1242562249, t27, t1, t28, 2);
    t9 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t7, t27);
    t10 = (t9 - 0);
    t18 = (t10 * 1);
    xsi_vhdl_check_range_of_index(0, 2, 1, t9);
    t19 = (16U * t18);
    t20 = (0 + t19);
    t8 = (t3 + t20);
    t13 = (t0 + 5856);
    t14 = (t13 + 56U);
    t21 = *((char **)t14);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    memcpy(t23, t8, 16U);
    xsi_driver_first_trans_fast(t13);
    goto LAB5;

LAB15:;
}

static void work_a_3912748731_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(340, ng0);

LAB3:    t1 = (t0 + 3432U);
    t2 = *((char **)t1);
    t1 = (t0 + 5920);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 5696);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_3912748731_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(341, ng0);

LAB3:    t1 = (t0 + 3592U);
    t2 = *((char **)t1);
    t1 = (t0 + 5984);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 5712);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


void ieee_p_2592010699_sub_7991387870887201249_503743352();

extern void work_a_3912748731_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3912748731_3212880686_p_0,(void *)work_a_3912748731_3212880686_p_1,(void *)work_a_3912748731_3212880686_p_2};
	xsi_register_didat("work_a_3912748731_3212880686", "isim/mlp_tb_isim_beh.exe.sim/work/a_3912748731_3212880686.didat");
	xsi_register_executes(pe);
	xsi_register_resolution_function(1, 2, (void *)ieee_p_2592010699_sub_7991387870887201249_503743352, 6);
}
