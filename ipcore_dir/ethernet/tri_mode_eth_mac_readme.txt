

                    Core Name: Xilinx LogiCORE Tri-Mode Ethernet MAC
                    Version: 4.6 Rev 3
                    Release: ISE 14.1
                    Release Date: April 8, 2013


================================================================================

This document contains the following sections:

1. Introduction
2. New Features
3. Supported Devices
4. Resolved Issues
5. Known Issues
6. Technical Support
7. Core Release History
8. Legal Disclaimer

================================================================================

1. INTRODUCTION

For the most recent updates to the IP installation instructions for this core,
please go to:

   http://www.xilinx.com/ipcenter/coregen/ip_update_install_instructions.htm

For system requirements:

   http://www.xilinx.com/ipcenter/coregen/ip_update_system_requirements.htm

This file contains release notes for the Xilinx LogiCORE(TM) IP
Tri-Mode Ethernet MAC v4.6 solution. For the latest core
updates, see the product page at:

   http://www.xilinx.com/products/ipcenter/TEMAC.htm

................................................................................

2. NEW FEATURES

  - ISE 14.1 software support

................................................................................

3. SUPPORTED DEVICES
 
  The following device families are supported by the core for this release.

   All Virtex-6 devices

   Spartan-6 devices
     Spartan-6                LX/LXT
     Defense Grade Spartan-6Q LX/LXT

   All Virtex-5 devices

   Spartan-3 device families
     Spartan-3
     Spartan-3A and Spartan-3AN
     Spartan-3A DSP
     Spartan-3E

   Virtex-4 devices
     Virtex-4                 LX/SX/FX

................................................................................

4. RESOLVED ISSUES

  - CR687357 - The TX stats byte count is incorrect if the TX IFG drops below 8.
  - CR695056 - When using the TX IFG input, the smallest value which can be obtained
               in full duplex mose (with half duplex supported) is 9 bytes
  - CR687357 - Multiple pause frame requests can result in a corrupted pause 
               quanta being output
  - CR666762 - Back-to-back fragmented Frames (0 to 2 bytes in size) following
               an IFG of 1 byte and a missing preamble field could be
               concatenated together.
  - CR679450 - The transmitter could lock-up when transmitting in half-duplex
               mode at 1Gb/s.
   
................................................................................

5. KNOWN ISSUES

The following are known issues for v4.6 of this core at time of release:

  - None

The most recent information, including known issues, workarounds, and
resolutions for this version is provided in the release notes Answer Record
for the ISE 14.1 IP Update at

   http://www.xilinx.com/support/documentation/user_guides/xtp025.pdf

................................................................................

6. TECHNICAL SUPPORT

To obtain technical support, create a WebCase at www.xilinx.com/support.
Questions are routed to a team with expertise using this product.

Xilinx provides technical support for use of this product when used
according to the guidelines described in the core documentation, and
cannot guarantee timing, functionality, or support of this product for
designs that do not follow specified guidelines.

................................................................................

7. CORE RELEASE HISTORY

Date     By            Version   Change Description
========================================================================
04/2013  Xilinx, Inc.  4.6 rev 3   Patch release
12/2012  Xilinx, Inc.  4.6 rev 2   Patch release
10/2012  Xilinx, Inc.  4.6 rev 1   Patch release
04/2012  Xilinx, Inc.  4.6         Release for ISE 14.1
03/2011  Xilinx, Inc.  4.5         Release for ISE 13.1
07/2010  Xilinx, Inc.  4.4 rev 2   Patch release
07/2010  Xilinx, Inc.  4.4 rev 1   Patch release
04/2010  Xilinx, Inc.  4.4         Release for ISE 12.1
03/2010  Xilinx, Inc.  4.3 rev 2   Release for ISE 11.5
11/2009  Xilinx, Inc.  4.3 rev 1   Patch release
09/2009  Xilinx, Inc.  4.3         Release for ISE 11.3
06/2009  Xilinx, Inc.  4.2         Release for ISE 11.2
04/2009  Xilinx, Inc.  4.1         Release for ISE 11.1
03/2008  Xilinx, Inc.  3.5         Release for ISE 10.1i
08/2007  Xilinx, Inc.  3.4         Release for ISE 9.2i
04/2007  Xilinx, Inc.  3.3 rev 1   Spartan(TM)-3A DSP support
02/2007  Xilinx, Inc.  3.3         Release for ISE 9.1i
09/2006  Xilinx, Inc.  3.2         Release for ISE 8.2i
07/2006  Xilinx, Inc.  3.1         Release for ISE 8.2i
01/2006  Xilinx, Inc.  2.2         Release for ISE 8.1i
06/2005  Xilinx, Inc.  2.1 patch 1 Patch release
04/2005  Xilinx, Inc.  2.1         Release for ISE 7.1i
09/2004  Xilinx, Inc.  1.1         Release for ISE 6.3i
========================================================================

................................................................................

8. LEGAL DISCLAIMER

(c) Copyright 2004 - 2013 Xilinx, Inc. All rights reserved.

This file contains confidential and proprietary information
of Xilinx, Inc. and is protected under U.S. and
international copyright and other intellectual property
laws.

DISCLAIMER
This disclaimer is not a license and does not grant any
rights to the materials distributed herewith. Except as
otherwise provided in a valid license issued to you by
Xilinx, and to the maximum extent permitted by applicable
law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
(2) Xilinx shall not be liable (whether in contract or tort,
including negligence, or under any other theory of
liability) for any loss or damage of any kind or nature
related to, arising under or in connection with these
materials, including for any direct, or any indirect,
special, incidental, or consequential loss or damage
(including loss of data, profits, goodwill, or any type of
loss or damage suffered as a result of any action brought
by a third party) even if such damage or loss was
reasonably foreseeable or Xilinx had been advised of the
possibility of the same.

CRITICAL APPLICATIONS
Xilinx products are not designed or intended to be fail-
safe, or for use in any application requiring fail-safe
performance, such as life-support or safety devices or
systems, Class III medical devices, nuclear facilities,
applications related to the deployment of airbags, or any
other applications that could lead to death, personal
injury, or severe property or environmental damage
(individually and collectively, "Critical
Applications"). Customer assumes the sole risk and
liability of any use of Xilinx products in Critical
Applications, subject only to applicable laws and
regulations governing limitations on product liability.

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
PART OF THIS FILE AT ALL TIMES.
