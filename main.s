	.arch armv7-m
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	1
	.global	media
	.syntax unified
	.thumb
	.thumb_func
	.fpu softvfp
	.type	media, %function

media:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #20
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7] 
	movs	r3, #0 @ sum = 0
	str	r3, [r7, #8]
	movs	r3, #0 @ i = 0
	str	r3, [r7, #12]
	b	.L2
.L3:
	ldr	r3, [r7, #12]
	lsls	r3, r3, #2
	ldr	r2, [r7, #4]
	add	r3, r3, r2
	ldr	r3, [r3]
	ldr	r2, [r7, #8]
	add	r3, r3, r2
	str	r3, [r7, #8]
	ldr	r3, [r7, #12]
	adds	r3, r3, #1
	str	r3, [r7, #12]
.L2:
	ldr	r2, [r7, #12]
	ldr	r3, [r7]
	cmp	r2, r3 
	blt	.L3 @ i < size
	ldr	r2, [r7, #8]
	ldr	r3, [r7]
	sdiv	r3, r2, r3
	mov	r0, r3
	adds	r7, r7, #20
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
	.size	media, .-media
	.align	1
	.global	ascii_to_int
	.syntax unified
	.thumb
	.thumb_func
	.fpu softvfp
	.type	ascii_to_int, %function

ascii_to_int:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #20
	add	r7, sp, #0
	str	r0, [r7, #4]
	movs	r3, #0
	str	r3, [r7, #8]
	movs	r3, #0
	str	r3, [r7, #12]
	b	.L6
.L7:
	ldr	r2, [r7, #8]
	mov	r3, r2
	lsls	r3, r3, #2
	add	r3, r3, r2
	lsls	r3, r3, #1
	mov	r1, r3
	ldr	r3, [r7, #12]
	ldr	r2, [r7, #4]
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	subs	r3, r3, #48
	add	r3, r3, r1
	str	r3, [r7, #8]
	ldr	r3, [r7, #12]
	adds	r3, r3, #1
	str	r3, [r7, #12]
.L6:
	ldr	r3, [r7, #12]
	ldr	r2, [r7, #4]
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L7
	ldr	r3, [r7, #8]
	mov	r0, r3
	adds	r7, r7, #20
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
	.size	ascii_to_int, .-ascii_to_int
	.section	.rodata
	.align	2
.LC0:
	.word	__stack_chk_guard
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.fpu softvfp
	.type	main, %function

main:
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #56
	add	r7, sp, #0
	ldr	r3, .L14
	ldr	r3, [r3]
	str	r3, [r7, #52]
	mov	r3,#0
	movs	r3, #0
	str	r3, [r7]
	b	.L10
.L11:
	ldr	r3, [r7]
	adds	r3, r3, #1
	str	r3, [r7]
.L10:
	ldr	r3, [r7]
	cmp	r3, #10
	ble	.L11
	add	r3, r7, #8
	movs	r1, #11
	mov	r0, r3
	bl	media
	str	r0, [r7, #4]
	movs	r3, #0
	ldr	r2, .L14
	ldr	r1, [r2]
	ldr	r2, [r7, #52]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L13
	bl	__stack_chk_fail
.L13:
	mov	r0, r3
	adds	r7, r7, #56
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L15:
	.align	2
.L14:
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
