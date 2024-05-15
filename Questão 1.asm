.data

	limite: .word 11

.text
	# $t0 soma dos primos
	# $t1 j
	# t2 j*j
	# $t3 numero que quremos verificar se é primo, tambem é o registrador de controle loop que soma primos
	# t4 guarda o resto da divisao
	# t6 final do intervalo 
	
	addi $t3, $zero, 2
	lw $t6, limite
	
	LOOPSOMA:
		addi $t1, $zero, 2
		bgt $t3, $t6, BREAKLOOPSOMA
		
		LOOPRIMO:
		
			mult $t1, $t1
			mflo $t2
		
			bgt $t2, $t3, BREAKLOOPRIMO
		
			div $t3, $t1
			mfhi $t4
			
			addi $t1, $t1, 1
		
			beq $t4, 0, PRIMO
			
			j LOOPRIMO
		
		BREAKLOOPRIMO:
		
			add $t0, $t0, $t3	
		
		PRIMO:
		
		addi $t3, $t3, 1
		
		j LOOPSOMA
	
	BREAKLOOPSOMA:
	
	nop
