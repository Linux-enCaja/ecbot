/*******************************************************************************
 *
 * Filename: arm_init.s
 *
 * Initialization for C-environment and basic operation.  Adapted from
 *  ATMEL cstartup.s.
 *
 * Revision information:
 *
 * 20AUG2004	kb_admin	initial creation
 *
 * BEGIN_KBDD_BLOCK
 * No warranty, expressed or implied, is included with this software.  It is
 * provided "AS IS" and no warranty of any kind including statutory or aspects
 * relating to merchantability or fitness for any purpose is provided.  All
 * intellectual property rights of others is maintained with the respective
 * owners.  This software is not copyrighted and is intended for reference
 * only.
 * END_BLOCK
 ******************************************************************************/

	.equ	TWI_EEPROM_SIZE,	0x2000
	.equ	ARM_MODE_USER,	0x10
	.equ	ARM_MODE_FIQ,	0x11
	.equ	ARM_MODE_IRQ,	0x12
	.equ	ARM_MODE_SVC,	0x13
	.equ	ARM_MODE_ABORT,	0x17
	.equ	ARM_MODE_UNDEF,	0x1B
	.equ	ARM_MODE_SYS,	0x1F

	.equ	I_BIT,	0x80
	.equ	F_BIT,	0x40
	.equ	T_BIT,	0x20

/*
 * Stack definitions
 *
 * Start near top of internal RAM.
 */

	.equ	END_INT_SRAM,		0x4000
	.equ	SVC_STACK_START,	(END_INT_SRAM - 0x4)

start:

/* vectors - must reside at address 0			*/
/* the format of this table is defined in the datasheet	*/
                B           InitReset       	@; reset
undefvec:
                B           undefvec        	@; Undefined Instruction
swivec:
                B           swivec          	@; Software Interrupt
pabtvec:
                B           pabtvec         	@; Prefetch Abort
dabtvec:
                B           dabtvec         	@; Data Abort
rsvdvec:
		.long	(TWI_EEPROM_SIZE >> 9)
irqvec:
                ldr         pc, [pc,#-0xF20]    @; IRQ : read the AIC
fiqvec:
                B           fiqvec          	@; FIQ


InitReset:

/* Set stack and init for SVC				*/
	ldr	r1, = SVC_STACK_START
	mov	sp, r1		@; Init stack SYS

	msr     cpsr_c, #(ARM_MODE_SVC | I_BIT | F_BIT)
	mov     sp, r1		@ ; Init stack SYS

/* Perform system initialization				*/

	.extern	DefaultSystemInit

	ldr	r0, = DefaultSystemInit
	mov	lr, pc
	bx	r0

/* Start execution at main					*/

	.extern	main
_main:
__main:
	ldr       r0, = main
	mov       lr, pc
	bx        r0

/* main should not return.  If it does, spin forever		*/

infiniteLoop:
	b	infiniteLoop

/* the following section is used to store boot commands in 	*/
/*  non-volatile memory.					*/

	.global BootCommandSection
BootCommandSection:
	.string "Bootloader for KB9200 Evaluation Board."
	.string "This is the default test command area."
	.string "Use 'l' to load the command table."
	.string "Use 'd' to display the command table."
	.string "Use 's' to set a command in the table."
	.string "Use 'w' to write the command table to non-volatile memory."
	.string "           "
