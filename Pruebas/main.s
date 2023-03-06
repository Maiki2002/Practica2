.cpu cortex-m3
	.arch armv7-m
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
    .data
    message:
        .space 20 @Reserva espacio en la seccion de datos globales. 20 bytes
	out:
		.space 20
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function

imprimir:
	@prologo
	push {r7}
	sub sp, sp, #12	@¿Como se cuanto tengo que reservar?
	add r7, sp, #0

	@Argumentos de la funcion que provienen de main (r0, r1)
	str r0, [r7] 		@Direccion base del buffer
	str r1, [r7, #4] 	@Tamaño del buffer

	@imprimir en consola
	ldr r0, =1			@indica que se imprimira en la salida estandar
	ldr r1, [r7]		@Direccion base del buffer
    ldr r2, [r7, #4]	@Tamaño del buferr
	mov r7, #4			@"Write"
    svc 0x0
	mov r3, r0			@Por convencion se respalda en r3, lo que tiene r0
	add r7, sp, #0

	@epilogo
	mov r0, r3
	adds r7, r7, #12
	mov sp, r7
	pop {r7}
	bx lr

leer:
	@prologo
	push {r7}
	sub sp, sp, #8		@¿Como se cuanto tengo que reservar?  8 por el respaldo de r0 y r1
	add r7, sp, #0

	@Argumentos de la funcion que provienen de main (r0, r1)
	str r0, [r7] 		@Direccion base del buffer
	str r1, [r7, #4] 	@Tamaño del buffer

	ldr r0, =0			@Indica que se leerá desde la entrada estándar.
	ldr r1, [r7]		@Asignación de la dirección del buffer.
	ldr r2, [r7, #4]	@Asignación del tamaño del buffer
	mov r7, #3			@Indica la salida estadar "read"
	svc #0				@El valor de retorno se guarda en r0
	mov r3, r0			@Por convencion se respalda en r3, lo que tiene r0
	add r7, sp, #0

	@epilogo
	mov r0, r3
	adds r7, r7, #8
	mov sp, r7
	pop {r7}
	bx lr
    
main:
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	movs	r2, #0 		@num = 0
	
	@Argumentos de la funcion leer
	ldr r0, =message	@Base buffer direccion in
	mov r1, #20			@tamaño del buffer

	bl leer

	@Argumentos de la funcion imprimir	
	ldr r0, =out		@Base buffer direccion out
	mov r1, #20			@tamaño del buffer

	bl imprimir
	
	mov	r3, r0
	mov		r0, r3
	adds	r7, r7, #8
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
	bx	lr
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 12.2 (Build arm-12.24)) 12.2.1 20221205"
