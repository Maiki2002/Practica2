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
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function

@ By me, Stephen :D
ASCII_Entero:  @Prólogo
		push {r7}
		sub sp,sp,#8 
		adds r7,sp,#0
		@ Argumentos r0 y r4. r0 = dirección del ASCII; r4 = el que evalúa.
		str r0,[r7]
		str r4,[r7,#4]
		
		@ The function body
		ldr r2,[r7,#4] @ This is equal to r2 <- r4
		ldr r1,[r7] @ r1 <- r0
		
		While:
			ldrb r0, [r1],#1 @ O de igual manera: [r1,#1] Why this? Well... Porque carga una cadena de bytes y esto incrementa a uno.
			cmp r0,#0
			bne Do @ Mientras no sea NULL
			b exit @ Case False, please exit this.
			
				then: b exit @ Pues no quedará letras más por comparar, es decir, no cumplirá con lo dicho. (Ya que las comparaciones 
			@ muestran un OR, o sea "if (character[i] < 0x30 || character[i] > 0x39)" y si ambas son verdaderas o una de ellas lo es, sale del programa).
			
		Do:
			cmp r0, #0x30
			blt then @ (character < 0x30). The 0x30 is equal to '0'.
			cmp r0,#0x39
			bgt then (character > 0x39). The 0x39 is equal to '9'.
			subs r0,r0,#0x30 @ r0 = character - 48.
			add r3,r2,r2,lsl #2 @ r3 = r2 + (4 * r2) => 5 * r2
			add r2,r0,r3,lsl #1 @ r2 = r0 + r3 << 1 => r0 + 10 * r2
			b While @ repeat when the condition is full false.
			
		exit:
			@ Epílogo
			mov r0,r2 @ We return our result or answer. Es decir, el ascii convertido a entero.
			adds r7,r7,#8
			mov sp,r7
			pop {r7}
			bx lr @ Return now
			
			

imprimir:
	@prologo
	push {r7}
	sub sp, sp, #12	@¿Como se cuanto tengo que reservar?
	add r7, sp, #0

	@str r3, [r7]

	@Argumentos de la funcion que provienen de main (r0, r1)
	str r0, [r7] 		@Direccion base del buffer
	str r1, [r7, #4] 	@Tamaño del buffer

	@imprimir en consola
	ldr r0, =1			@indica que se imprimira en la salida estandar
	ldr r1, [r7]		@Direccion base del buffer
    ldr r2, [r4, #4]	@Tamaño del buferr
	mov r7, #4			@"Write"
    svc 0x0

	@epilogo
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
	
	ldr r0, =message	@Base buffer direccion
	mov r1, #20			@tamaño del buffer

	bl leer
	
	@mov r3,r0			@Argumento de la funcion imprimir	
	
	@ AQUÍ SE INVOCARÍA LA FUNCIÓN (YA MÍA) DEL "ASCII_Entero" CON LOS DOS ARGUMENTOS: DIRECCIÓN DEL ASCII Y UN REGISTRO QUE EVALÚA, INICIADO EN CERO.
	
	ldr r0, =message	@Base buffer direccion
	mov r1, #20			@tamaño del buffer

	bl imprimir
	
	mov	r3, r0
	mov		r0, r3
	adds	r7, r7, #8
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 12.2 (Build arm-12.24)) 12.2.1 20221205"
