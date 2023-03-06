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
	@ Prólogo de my_atoi, 24 bytes
	push {r7} //respaldo del apuntador del marco r7
	sub sp, sp, #20 //Reserva de memoria multiplos de 8 
	add r7, sp, #0  //mover el valor de sp a r7

	str r0, [r7] //respaldo de argumento de la función
	mov r2, #0x0 //; our string length counter 
	str r2, [r7, #4] //respaldo de argumento de la función
	mov r3, #0x0 //; end state counter value
	str r3, [r7, #8] //respaldo de argumento de la función
	mov r6, #1
	str r6, [r7, #12] //respaldo de argumento de la función
	mov r9, #10
	str r9, [r7, #16] //respaldo de argumento de la función
	@ Cuerpo de la función  
.string_length_loop: @ No son funciones, son etiquetas 
	ldr r0, [r7]
	ldrb r8, [r0]
	cmp r8, #0xa 
	beq .count
	ldr r0, [r7]
	add r0, r0, #1               //instrucciones longitud de la cadena 
	str r0, [r7]
	ldr r2, [r7, #4]
	add r2, r2, #1
	str r2, [r7, #4]
	b .string_length_loop  
.count:
	sub r0, r0, #1
	str r0, [r7]
	ldrb r8, [r0] //; the first number in the string
	sub r8, r8, #0x30
	ldr r6, [r7, #12]
	mul r4, r8, r6
	mov r8, r4
	ldr r6, [r7, #12]                                 //instrcciones del contador 
	ldr r9, [r7, #16]
	mul r4, r6, r9 //; increment the placeholder 
	mov r6, r4
	str r6, [r7, #12]
	ldr r3, [r7, #8]
	add r3, r3, r8
	str r3, [r7, #8]
	ldr r2, [r7, #4]
	sub r2, r2, #1
	str r2, [r7, #4]
	ldr r2, [r7, #4]
	cmp r2, #0x0
	beq .leave
	b .count
.leave:
	@ Epílogo de my_atoi
	mov r0, r3   //el resultado de la funcion lo movemos a r0
	adds r7, r7, #20 //los bytes reservados en el prologo lo sumamos a r7
	mov sp, r7  //el valor del registro sp lo movemos a r7
	pop {r7} //recuperación del valor previo del registro r7
	bx lr //retornar el control a la función invoncadora(main)


read_user_input:
	@ Prólogo de read_user_input, 16 bytes
	push {r7} //respaldo del apuntador del marco r7
	sub sp, sp, #12 //Reserva de memoria multiplos de 8 
	add r7, sp, #0 //mover el valor de sp a r7
	str r0, [r7, #4] //respaldo de argumento de la función
	str r1, [r7, #8] //respaldo de argumento de la función
	@ Cuerpo de la función  
	mov r4, r7
	ldr r2, [r7, #8]
	ldr r1, [r7, #4]
	mov	r0, #0x0
	mov r7, #0x3
	svc 0x0  //llamda al sistema
	mov r3, r0
	mov r7, r4 //extrae el valor del sp

	@ Epílogo de read_user_input
	mov r0, r3 //el resultado de la funcion lo movemos a r0
	adds r7, r7, #12 //los bytes reservados en el prologo lo sumamos a r7
	mov sp, r7 //el valor del registro sp lo modvemos a r7
	pop {r7} //recuperación del valor previo del registro r7
	bx  lr //retornar el control a la función invoncadora(main)


int_to_string:
	@ Prólogo de int_to_string, 40 bytes
	push {r7} //respaldo del apuntador del marco r7
	sub sp, sp, #36 //Reserva de memoria multiplos de 8 
	add r7, sp, #0 //mover el valor de sp a r7

	str r0, [r7] //respaldo de argumento de la función
	str r1, [r7, #4] //respaldo de argumento de la función
	mov r3, #0x0 
	str r3, [r7, #8] //respaldo de argumento de la función 
	mov r3, #10000
	str r3, [r7, #12] //respaldo de argumento de la función
	mov r5, #10
	str r5, [r7, #16] //respaldo de argumento de la función
	@ Cuerpo de la función  
.loop:
	ldr r3, [r7, #12]
	udiv r4, r0, r3
	str r4, [r7, #20]
	ldr r4, [r7, #20]
	add r4, r4, #0x30
	str r4, [r7, #20]

	ldr r3, [r7, #8]
	ldr r1, [r7, #4]
	add r1, r1, r3
	strb r4, [r1]
	str r4, [r7, #20]
	ldr r3, [r7, #8]
	add r3, r3, #1
	str r3, [r7, #8]

	ldr r4, [r7, #20]
	sub r4, r4, #0x30
	str r4, [r7, #20]
	ldr r3, [r7, #12]
	mul r6, r4, r3
	str r6, [r7, #24]
	ldr r6, [r7, #24]
	sub r0, r0, r6

	ldr r3, [r7, #12]
	ldr r5, [r7, #16]
	udiv r6, r3, r5
	str r6, [r7, #28]
	ldr r6, [r7, #28]
	mov r3, r6
	str r3, [r7, #12]
	cmp r3, #0
	beq .leave_int
	b .loop
.leave_int:
	mov r4, #0xa
	ldr r3, [r7, #8]
	ldr r1, [r7, #4]
	add r1, r1, r3
	add r1, r1, #1
	strb r4, [r1]
	@ Epílogo de int_to_string
	mov r3, #0  
	mov r0, r3 //el resultado de la funcion lo movemos a r0
	adds r7, r7, #36 //los bytes reservados en el prologo lo sumamos a r7
	mov sp, r7 //el valor del registro sp lo modvemos a r7
	pop {r7} //recuperación del valor previo del registro r7
	bx lr //retornar el control a la función invoncadora(main)


display:
	@ Prólogo
	push {r7} //respaldo del apuntador del marco r7
	sub sp, sp, #12 //Reserva de memoria multiplos de 8 
	add r7, sp, #0 //mover el valor de sp a r7
	str r0, [r7] //respaldo de argumento de la función
	@ Cuerpo de la función  
	mov r4, r7
	ldr r1, [r7]
	mov r0, #0x1
	mov r7, #0x4	

	mov r2, #0x8
	svc 0x0 //llamada al sistema 
	
	mov r3, r0
	mov r7, r4
	@ Epílogo
	mov r0, r3 //el resultado de la funcion lo movemos a r0
	adds r7, r7, #12  //los bytes reservados en el prologo lo sumamos a r7
	mov sp, r7  //el valor del registro sp lo modvemos a r7
	pop {r7} //recuperación del valor previo del registro r7
	bx lr //retornar el control a la función invoncadora(main)


media:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	@ Prólogo
	push	{r7} //respaldo del apuntador del marco r7
	sub	sp, sp, #20 //Reserva de memoria multiplos de 8 
	add	r7, sp, #0 //mover el valor de sp a r7
	str	r0, [r7, #4] //respaldo de argumento de la función
	str	r1, [r7]  //respaldo de argumento de la función
	movs	r3, #0 @ sum = 0
	str	r3, [r7, #8] //respaldo de argumento de la función
	movs	r3, #0 @ i = 0
	str	r3, [r7, #12] //respaldo de argumento de la función
	@ Cuerpo de la función  
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
	@ Epílogo
	mov	r0, r3 //el resultado de la funcion lo movemos a r0
	adds	r7, r7, #20 //los bytes reservados en el prologo lo sumamos a r7
	mov	sp, r7  //el valor del registro sp lo movemos a r7
	@ sp needed
	pop	{r7} //recuperación del valor previo del registro r7
	bx	lr //retornar el control a la función invoncadora(main)

	.size	media, .-media
	.align	1
	.global	ascii_to_int
	.syntax unified
	.thumb
	.thumb_func
	.fpu softvfp
	.type	ascii_to_int, %function
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
	push	{r7, lr} //respaldo del apuntador del marco r7 y lr(función anidada)
	sub	sp, sp, #56 //Reserva de memoria multiplos de 8 
	add	r7, sp, #0 //mover el valor de sp a r7
	ldr	r3, .L14
	ldr	r3, [r3] 
	str	r3, [r7, #52] 
	mov	r3,#0
	movs	r3, #0
	str	r3, [r7] 
	@ Cuerpo de la función  
	b	.L10
.L11:
	ldr r0, =first
	ldr r1, =#0x6
	bl read_user_input @ llamada a read_user_input

	ldr r0, =first
	bl my_atoi

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

	@ Cálculo de  la media
	str	r0, [r7, #4]
	ldr	r0, [r7, #4]
	ldr r1, =sum
	bl int_to_string

	ldr r0, =sum
	bl display

	ldr	r2, .L14
	ldr	r1, [r2]
	ldr	r2, [r7, #52]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L13
	bl	__stack_chk_fail

.L13:
	@ Epílogo
	mov	r0, r3 //el resultado de la funcion lo movemos a r0
	adds	r7, r7, #56 //los bytes reservados en el prologo lo sumamos a r7
	mov	sp, r7 //el valor del registro sp lo movemos a r7
	@ sp needed
	pop	{r7, pc} //recuperación del valor previo del registro r7 y 
				//recuperación del contador de programa 

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
