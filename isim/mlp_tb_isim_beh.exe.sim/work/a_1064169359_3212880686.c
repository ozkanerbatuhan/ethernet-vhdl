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
static const char *ng0 = "/home/ise/ISE_146/ethernet/mlp/MAC_Unit.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_1242562249;

char *ieee_p_1242562249_sub_17126692536656888728_1035706684(char *, char *, int , int );
char *ieee_p_1242562249_sub_17249857350030274602_1035706684(char *, char *, char *, char *, int );
char *ieee_p_1242562249_sub_2423793367844140314_1035706684(char *, char *, char *, char *, int );
char *ieee_p_1242562249_sub_2598175070666390882_1035706684(char *, char *, char *, char *, char *, char *);
unsigned char ieee_p_1242562249_sub_3044623114557194624_1035706684(char *, char *, char *, char *, char *);
unsigned char ieee_p_1242562249_sub_3044623114557266498_1035706684(char *, char *, char *, char *, char *);
char *ieee_p_1242562249_sub_3525738511873186323_1035706684(char *, char *, char *, char *, char *, char *);
char *ieee_p_1242562249_sub_5461289951233117757_1035706684(char *, char *, char *, char *, int );
unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_1064169359_3212880686_p_0(char *t0)
{
    char t13[16];
    char t19[16];
    char t20[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    unsigned int t14;
    unsigned int t15;
    int t16;
    char *t17;
    char *t18;
    int t21;

LAB0:    xsi_set_current_line(54, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 5768);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(55, ng0);
    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 != 0)
        goto LAB5;

LAB7:    xsi_set_current_line(59, ng0);
    t1 = (t0 + 5960);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(61, ng0);
    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t5 = (t2 == (unsigned char)3);
    if (t5 != 0)
        goto LAB8;

LAB10:
LAB9:    xsi_set_current_line(65, ng0);
    t1 = (t0 + 1352U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t5 = (t2 == (unsigned char)3);
    if (t5 != 0)
        goto LAB11;

LAB13:
LAB12:    xsi_set_current_line(71, ng0);
    t1 = (t0 + 1672U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t5 = (t2 == (unsigned char)3);
    if (t5 != 0)
        goto LAB16;

LAB18:
LAB17:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(56, ng0);
    t3 = xsi_get_transient_memory(40U);
    memset(t3, 0, 40U);
    t7 = t3;
    memset(t7, (unsigned char)2, 40U);
    t8 = (t0 + 5896);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t3, 40U);
    xsi_driver_first_trans_fast(t8);
    xsi_set_current_line(57, ng0);
    t1 = (t0 + 5960);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    goto LAB6;

LAB8:    xsi_set_current_line(62, ng0);
    t1 = xsi_get_transient_memory(40U);
    memset(t1, 0, 40U);
    t4 = t1;
    memset(t4, (unsigned char)2, 40U);
    t7 = (t0 + 5896);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t1, 40U);
    xsi_driver_first_trans_fast(t7);
    goto LAB9;

LAB11:    xsi_set_current_line(66, ng0);
    t1 = (t0 + 1832U);
    t4 = *((char **)t1);
    t1 = (t0 + 8720U);
    t7 = (t0 + 1992U);
    t8 = *((char **)t7);
    t7 = (t0 + 8736U);
    t9 = ieee_p_1242562249_sub_2598175070666390882_1035706684(IEEE_P_1242562249, t13, t4, t1, t8, t7);
    t10 = (t0 + 3488U);
    t11 = *((char **)t10);
    t10 = (t11 + 0);
    t12 = (t13 + 12U);
    t14 = *((unsigned int *)t12);
    t15 = (1U * t14);
    memcpy(t10, t9, t15);
    xsi_set_current_line(67, ng0);
    t1 = (t0 + 3488U);
    t3 = *((char **)t1);
    t1 = (t0 + 8816U);
    t4 = (t0 + 3248U);
    t7 = *((char **)t4);
    t16 = *((int *)t7);
    t4 = ieee_p_1242562249_sub_2423793367844140314_1035706684(IEEE_P_1242562249, t13, t3, t1, t16);
    t8 = (t0 + 3608U);
    t9 = *((char **)t8);
    t8 = (t9 + 0);
    t10 = (t13 + 12U);
    t14 = *((unsigned int *)t10);
    t14 = (t14 * 1U);
    memcpy(t8, t4, t14);
    xsi_set_current_line(68, ng0);
    t1 = (t0 + 2632U);
    t3 = *((char **)t1);
    t1 = (t0 + 8784U);
    t4 = (t0 + 3608U);
    t7 = *((char **)t4);
    t4 = (t0 + 8832U);
    t8 = ieee_p_1242562249_sub_3525738511873186323_1035706684(IEEE_P_1242562249, t13, t3, t1, t7, t4);
    t9 = (t13 + 12U);
    t14 = *((unsigned int *)t9);
    t15 = (1U * t14);
    t2 = (40U != t15);
    if (t2 == 1)
        goto LAB14;

LAB15:    t10 = (t0 + 5896);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t17 = (t12 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t8, 40U);
    xsi_driver_first_trans_fast(t10);
    goto LAB12;

LAB14:    xsi_size_not_matching(40U, t15, 0);
    goto LAB15;

LAB16:    xsi_set_current_line(72, ng0);
    t1 = (t0 + 2152U);
    t4 = *((char **)t1);
    t1 = (t0 + 8752U);
    t7 = ieee_p_1242562249_sub_2423793367844140314_1035706684(IEEE_P_1242562249, t20, t4, t1, 24);
    t8 = (t0 + 3368U);
    t9 = *((char **)t8);
    t16 = *((int *)t9);
    t8 = ieee_p_1242562249_sub_17249857350030274602_1035706684(IEEE_P_1242562249, t19, t7, t20, t16);
    t10 = (t0 + 3248U);
    t11 = *((char **)t10);
    t21 = *((int *)t11);
    t10 = ieee_p_1242562249_sub_2423793367844140314_1035706684(IEEE_P_1242562249, t13, t8, t19, t21);
    t12 = (t0 + 3728U);
    t17 = *((char **)t12);
    t12 = (t17 + 0);
    t18 = (t13 + 12U);
    t14 = *((unsigned int *)t18);
    t14 = (t14 * 1U);
    memcpy(t12, t10, t14);
    xsi_set_current_line(73, ng0);
    t1 = (t0 + 2632U);
    t3 = *((char **)t1);
    t1 = (t0 + 8784U);
    t4 = (t0 + 3728U);
    t7 = *((char **)t4);
    t4 = (t0 + 8848U);
    t8 = ieee_p_1242562249_sub_3525738511873186323_1035706684(IEEE_P_1242562249, t13, t3, t1, t7, t4);
    t9 = (t13 + 12U);
    t14 = *((unsigned int *)t9);
    t15 = (1U * t14);
    t2 = (40U != t15);
    if (t2 == 1)
        goto LAB19;

LAB20:    t10 = (t0 + 5896);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t17 = (t12 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t8, 40U);
    xsi_driver_first_trans_fast(t10);
    xsi_set_current_line(74, ng0);
    t1 = (t0 + 5960);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    goto LAB17;

LAB19:    xsi_size_not_matching(40U, t15, 0);
    goto LAB20;

}

static void work_a_1064169359_3212880686_p_1(char *t0)
{
    char t1[16];
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    int t6;
    char *t7;
    unsigned int t8;
    unsigned char t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;

LAB0:    xsi_set_current_line(81, ng0);

LAB3:    t2 = (t0 + 2632U);
    t3 = *((char **)t2);
    t2 = (t0 + 8784U);
    t4 = (t0 + 3368U);
    t5 = *((char **)t4);
    t6 = *((int *)t5);
    t4 = ieee_p_1242562249_sub_5461289951233117757_1035706684(IEEE_P_1242562249, t1, t3, t2, t6);
    t7 = (t1 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t9 = (40U != t8);
    if (t9 == 1)
        goto LAB5;

LAB6:    t10 = (t0 + 6024);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t4, 40U);
    xsi_driver_first_trans_fast(t10);

LAB2:    t15 = (t0 + 5784);
    *((int *)t15) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(40U, t8, 0);
    goto LAB6;

}

static void work_a_1064169359_3212880686_p_2(char *t0)
{
    char t3[16];
    char t8[16];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    int t6;
    unsigned char t7;
    char *t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    int t16;
    int t17;
    unsigned int t18;

LAB0:    xsi_set_current_line(86, ng0);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t1 = (t0 + 8800U);
    t4 = (t0 + 3248U);
    t5 = *((char **)t4);
    t6 = *((int *)t5);
    t4 = ieee_p_1242562249_sub_17126692536656888728_1035706684(IEEE_P_1242562249, t3, 32767, t6);
    t7 = ieee_p_1242562249_sub_3044623114557266498_1035706684(IEEE_P_1242562249, t2, t1, t4, t3);
    if (t7 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t1 = (t0 + 8800U);
    t6 = (-(32768));
    t4 = (t0 + 3248U);
    t5 = *((char **)t4);
    t16 = *((int *)t5);
    t4 = ieee_p_1242562249_sub_17126692536656888728_1035706684(IEEE_P_1242562249, t3, t6, t16);
    t7 = ieee_p_1242562249_sub_3044623114557194624_1035706684(IEEE_P_1242562249, t2, t1, t4, t3);
    if (t7 != 0)
        goto LAB7;

LAB8:    xsi_set_current_line(91, ng0);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t1 = (t0 + 8800U);
    t4 = ieee_p_1242562249_sub_2423793367844140314_1035706684(IEEE_P_1242562249, t3, t2, t1, 16);
    t5 = (t3 + 12U);
    t18 = *((unsigned int *)t5);
    t18 = (t18 * 1U);
    t7 = (16U != t18);
    if (t7 == 1)
        goto LAB11;

LAB12:    t9 = (t0 + 6088);
    t11 = (t9 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t4, 16U);
    xsi_driver_first_trans_fast_port(t9);

LAB3:    t1 = (t0 + 5800);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(87, ng0);
    t9 = ieee_p_1242562249_sub_17126692536656888728_1035706684(IEEE_P_1242562249, t8, 32767, 16);
    t10 = (16U != 16U);
    if (t10 == 1)
        goto LAB5;

LAB6:    t11 = (t0 + 6088);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t9, 16U);
    xsi_driver_first_trans_fast_port(t11);
    goto LAB3;

LAB5:    xsi_size_not_matching(16U, 16U, 0);
    goto LAB6;

LAB7:    xsi_set_current_line(89, ng0);
    t17 = (-(32768));
    t9 = ieee_p_1242562249_sub_17126692536656888728_1035706684(IEEE_P_1242562249, t8, t17, 16);
    t10 = (16U != 16U);
    if (t10 == 1)
        goto LAB9;

LAB10:    t11 = (t0 + 6088);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t9, 16U);
    xsi_driver_first_trans_fast_port(t11);
    goto LAB3;

LAB9:    xsi_size_not_matching(16U, 16U, 0);
    goto LAB10;

LAB11:    xsi_size_not_matching(16U, t18, 0);
    goto LAB12;

}

static void work_a_1064169359_3212880686_p_3(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(95, ng0);

LAB3:    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 6152);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t8 = (t0 + 5816);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_1064169359_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1064169359_3212880686_p_0,(void *)work_a_1064169359_3212880686_p_1,(void *)work_a_1064169359_3212880686_p_2,(void *)work_a_1064169359_3212880686_p_3};
	xsi_register_didat("work_a_1064169359_3212880686", "isim/mlp_tb_isim_beh.exe.sim/work/a_1064169359_3212880686.didat");
	xsi_register_executes(pe);
}
