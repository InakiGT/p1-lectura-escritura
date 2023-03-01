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


my_atoi:
	push {lr}
	push {r4-r11}
	mov r2, #0x0 //; our string length counter 
	mov r3, #0x0 //; end state counter value
	mov r6, #1
	mov r9, #10

_string_length_loop:
	ldrb r8, [r0]
	cmp r8, #0xa 
	beq _count
	add r0, r0, #1
	add r2, r2, #1
	b _string_length_loop
	
_count:
	sub r0, r0, #1
	ldrb r8, [r0] //; the first number in the sting
	sub r8, r8, #0x30
	mul r4, r8, r6
	mov r8, r4
	mul r4, r6, r9 //; increment the placeholder 
	mov r6, r4
	add r3, r3, r8
	sub r2, r2, #1
	cmp r2, #0x0
	beq _leave
	b _count

_leave:
	mov r0, r3
	pop {r4-r11}
	bx lr

read_user_input:
	push {r7}
	sub sp, sp, #12
	add r7, sp, #0
	str r0, [r7, #4]
	str r1, [r7, #8]

	mov r4, r7
	ldr r2, [r7, #8]
	ldr r1, [r7, #4]
	mov	r0, #0x0
	mov r7, #0x3
	svc 0x0

	mov r3, r0
	add r7, #0
	mov r7, r4 @ Extrae el valor del sp

	mov r0, r3
	adds r7, r7, #12
	mov sp, r7
	pop {r7}
	bx  lr

int_to_string:
	push {lr}
	push {r4-r11}
	mov r2, #0x0
	mov r3, #10000
	mov r7, #10

_loop:
	mov r4, #0x0
	udiv r4, r0, r3
	add r4, r4, #0x30

	ldr r5, =sum
	add r5, r5, r2
	strb r4, [r5]
	add r2, r2, #1

	sub r4, r4, #0x30
	mul r6, r4, r3
	sub r0, r0, r6

	udiv r6, r3, r7
	mov r3, r6
	cmp r3, #0
	beq _leave_int
	b _loop

_leave_int:
	mov r4, #0xa
	ldr r5, =sum
	add r5, r5, r2
	add r5, r5, #1
	strb r4, [r5]
	pop {r4-r11}
	bx lr

display:
	push {lr}
	push {r4-r11}

	mov r7, #0x4
	mov r0, #0x1
	ldr r1, =sum
	mov r2, #0x8
	svc 0x0

	pop {r4-r11}
	bx lr

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
	ldr r0, =first
	ldr r1, =#0x6
	bl read_user_input @ llamada a read_user_input

	ldr r0, =first
	bl my_atoi
	str r0, [r7, #12]

	ldr	r3, [r7] @ asignación del valor
	lsls	r3, r3, #2
	add	r2, r7, #56
	add	r3, r3, r2
	mov	r2, r0 @aquí se asigna
	str	r2, [r3, #-48]

	ldr	r3, [r7] @i++
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

	@ Cálculamos la media
	str	r0, [r7, #4]
	ldr	r0, [r7, #4]
	bl int_to_string

	bl display

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
	.section .data
	first:
		.skip 8
	sum:
		.skip 8
		