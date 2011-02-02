/*
 * (C) Copyright 2007
 * emQbit
 *
 * Configuration settings for the ECB_AT91 board
 *
 * Based in the configuation settings for the AT91RM9200DK board.
 * By Rick Bronson <rick@efn.org>
 *
 * See file CREDITS for list of people who contributed to this
 * project.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

#ifndef __CONFIG_H
#define __CONFIG_H

/* ARM asynchronous clock */
#define AT91C_MAIN_CLOCK	180000000
#define AT91C_MASTER_CLOCK	60000000

#define AT91_SLOW_CLOCK		32768	/* slow clock */

#define CONFIG_ARM920T		1	/* This is an ARM920T Core	*/
#define CONFIG_AT91RM9200	1	/* It's an Atmel AT91RM9200 SoC	*/
#define CONFIG_ECB_AT91		1	/* on an AT91RM9200DK Board	*/
#undef  CONFIG_USE_IRQ			/* we don't need IRQ/FIQ stuff	*/
#define USE_920T_MMU		1

#define CONFIG_CMDLINE_TAG	1	/* enable passing of ATAGs	*/
#define CONFIG_SETUP_MEMORY_TAGS 1
#define CONFIG_INITRD_TAG	1

#ifndef CONFIG_SKIP_LOWLEVEL_INIT
#define CFG_LONGHELP

/* flash */
#define MC_PUIA_VAL	0x00000000
#define MC_PUP_VAL	0x00000000
#define MC_PUER_VAL	0x00000000
#define MC_ASR_VAL	0x00000000
#define MC_AASR_VAL	0x00000000
#define EBI_CFGR_VAL	0x00000000
#define SMC2_CSR_VAL	0x00003284 /* 16bit, 2 TDF, 4 WS */

/* clocks */
#define PLLAR_VAL	0x20263E04 /* 179.712000 MHz for PCK */
#define PLLBR_VAL	0x10483E0E /* 48.054857 MHz (divider by 2 for USB) */
#define MCKR_VAL	0x00000202 /* PCK/3 = MCK Master Clock = 59.904000MHz from PLLA */

/* sdram */
#define PIOC_ASR_VAL	0xFFFF0000 /* Configure PIOC as peripheral (D16/D31) */
#define PIOC_BSR_VAL	0x00000000
#define PIOC_PDR_VAL	0xFFFF0000
#define EBI_CSA_VAL	0x00000002 /* CS1=SDRAM */
#define SDRC_CR_VAL	0x2188c155 /* set up the SDRAM */
#define SDRAM		0x20000000 /* address of the SDRAM */
#define SDRAM1		0x20000080 /* address of the SDRAM */
#define SDRAM_VAL	0x00000000 /* value written to SDRAM */
#define SDRC_MR_VAL	0x00000002 /* Precharge All */
#define SDRC_MR_VAL1	0x00000004 /* refresh */
#define SDRC_MR_VAL2	0x00000003 /* Load Mode Register */
#define SDRC_MR_VAL3	0x00000000 /* Normal Mode */
#define SDRC_TR_VAL	0x000002E0 /* Write refresh rate */
#endif	/* CONFIG_SKIP_LOWLEVEL_INIT */

#define CONFIG_BOOTARGS		"mem=32M root=dev/mmcblk0p1 rootfstype=ext3 console=ttyS0,115200n8 rootdelay=1"
#define CONFIG_ETHADDR		00:00:00:00:00:5b
#define CONFIG_NETMASK		255.255.255.0
#define CONFIG_IPADDR		192.168.0.135
#define CONFIG_SERVERIP		192.168.0.128
#define CONFIG_BOOTCOMMAND	"bootm C0021840"
#define CONFIG_BOOTFILE		"ecb_at91.img"
#define CONFIG_ROOTPATH		"/home/at91/rootfs"
#define CONFIG_LOADADDR		0x20200000

/*
 * Size of malloc() pool
 */
#define CFG_MALLOC_LEN		(CFG_ENV_SIZE + 128*1024)
#define CFG_GBL_DATA_SIZE	128	/* size in bytes reserved for initial data */
#define CONFIG_BAUDRATE		115200

/*
 * Hardware drivers
 */

/* define one of these to choose the DBGU, USART0  or USART1 as console */
#define CONFIG_DBGU
#undef CONFIG_USART0
#undef CONFIG_USART1

#undef	CONFIG_HWFLOW			/* don't include RTS/CTS flow control support */
#undef	CONFIG_MODEM_SUPPORT		/* disable modem initialization stuff */

#define CONFIG_BOOTDELAY	2
#define CONFIG_ENV_OVERWRITE	1

#define CONFIG_COMMANDS		\
		((CONFIG_CMD_DFL | CFG_CMD_NET | CFG_CMD_PING | CFG_CMD_DHCP ) & \
		~(CFG_CMD_BDI | CFG_CMD_FPGA | CFG_CMD_MISC))

/* this must be included AFTER the definition of CONFIG_COMMANDS (if any) */
#include <cmd_confdefs.h>

#define CONFIG_NR_DRAM_BANKS	1
#define PHYS_SDRAM		0x20000000
#define PHYS_SDRAM_SIZE		0x2000000  /* 32 megs */

#define CFG_MEMTEST_START	PHYS_SDRAM
#define CFG_MEMTEST_END		CFG_MEMTEST_START + PHYS_SDRAM_SIZE - 262144

#define CONFIG_DRIVER_ETHER
#define CONFIG_NET_RETRY_COUNT	20

#define CONFIG_HAS_DATAFLASH		1
#define CFG_SPI_WRITE_TOUT		(5*CFG_HZ)
#define CFG_MAX_DATAFLASH_BANKS		1
#define CFG_MAX_DATAFLASH_PAGES		4096
#define CFG_DATAFLASH_LOGIC_ADDR_CS0	0xC0000000	/* Logical adress for CS0 */

/* Remember that you must have the same mapping in the Darrell loader  */
#define NB_DATAFLASH_AREA		   5  /* protected areas (4 + u-boot env) */
#define DATAFLASH_MAX_PAGESIZE		1056
#define DATAFLASH_LOADER_BASE		   (0*DATAFLASH_MAX_PAGESIZE)
#define DATAFLASH_UBOOT_BASE		  (12*DATAFLASH_MAX_PAGESIZE)
#define DATAFLASH_ENV_UBOOT_BASE	 (122*DATAFLASH_MAX_PAGESIZE)
#define DATAFLASH_KERNEL_BASE		 (130*DATAFLASH_MAX_PAGESIZE)
#define DATAFLASH_FILESYSTEM_BASE	(1664*DATAFLASH_MAX_PAGESIZE)

#define PHYS_FLASH_1			0x10000000
#define PHYS_FLASH_SIZE			0x200000  /* 2 megs main flash */
#define CFG_FLASH_BASE			PHYS_FLASH_1
#define CFG_MAX_FLASH_BANKS		1
#define CFG_MAX_FLASH_SECT		256
#define CFG_FLASH_ERASE_TOUT		(2*CFG_HZ) /* Timeout for Flash Erase */
#define CFG_FLASH_WRITE_TOUT		(2*CFG_HZ) /* Timeout for Flash Write */

#define CFG_ENV_IS_IN_DATAFLASH
#define CFG_ENV_SIZE			0x2000  /* 8*DATAFLASH_MAX_PAGESIZE - 0x100 */
#define CFG_ENV_OFFSET			(DATAFLASH_ENV_UBOOT_BASE)
#define CFG_ENV_ADDR			(CFG_DATAFLASH_LOGIC_ADDR_CS0 + CFG_ENV_OFFSET)

#define CFG_LOAD_ADDR		0x20200000	/* default load address */

#ifdef CONFIG_SKIP_LOWLEVEL_INIT
#define CFG_BOOT_SIZE		0x00 /* 0 KBytes */
#define CFG_U_BOOT_BASE		PHYS_FLASH_1
#define CFG_U_BOOT_SIZE		0x60000 /* 384 KBytes */
#else
#define CFG_BOOT_SIZE		0x6000 /* 24 KBytes */
#define CFG_U_BOOT_BASE		(PHYS_FLASH_1 + 0x10000)
#define CFG_U_BOOT_SIZE		0x10000 /* 64 KBytes */
#endif	/* CONFIG_SKIP_LOWLEVEL_INIT */

#define AT91_PROGRAM_MACADDR

#define CFG_BAUDRATE_TABLE	{115200 , 19200, 38400, 57600, 9600 }

#define CFG_PROMPT		"ecb_at91> "	/* Monitor Command Prompt */
#define CFG_CBSIZE		256		/* Console I/O Buffer Size */
#define CFG_MAXARGS		16		/* max number of command args */
#define CFG_PBSIZE		(CFG_CBSIZE+sizeof(CFG_PROMPT)+16) /* Print Buffer Size */

#ifndef __ASSEMBLY__
/*-----------------------------------------------------------------------
 * Board specific extension for bd_info
 *
 * This structure is embedded in the global bd_info (bd_t) structure
 * and can be used by the board specific code (eg board/...)
 */

struct bd_info_ext {
	/* helper variable for board environment handling
	 *
	 * env_crc_valid == 0    =>   uninitialised
	 * env_crc_valid  > 0    =>   environment crc in flash is valid
	 * env_crc_valid  < 0    =>   environment crc in flash is invalid
	 */
	int env_crc_valid;
};
#endif

#define CFG_HZ 1000
#define CFG_HZ_CLOCK AT91C_MASTER_CLOCK/2	/* AT91C_TC0_CMR is implicitly set to */
					/* AT91C_TC_TIMER_DIV1_CLOCK */

#define CONFIG_STACKSIZE	(32*1024)	/* regular stack */

#ifdef CONFIG_USE_IRQ
#error CONFIG_USE_IRQ not supported
#endif

#endif
