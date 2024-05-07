.data

	matrizRespostas: .align 2  # 1 2 1
			 .word 1, 2, 3, 4, 1 # 5
		     	       4, 3, 2, 1, 2 # 0
		               4, 2, 1, 3, 3 # 1
		               1, 1, 2, 2, 1 # 2
	
	vetorGabarito: .align 2
		       .word 1, 2, 3, 4, 1
		    
	vetorPontuacao: .align 2
			.space 16

.text

	# $t0: quantidade de alunos com 5 acertos;
	# $t1: quantidade de alunos entre 1 e 4 acertos;
	# $t2: quantidade de alunos que não acertaram nada.
	# $t3: controlador linha
	# $t4: controlador coluna
	# $t5: valor em bytes para acessar determinada posição da matrizRespostas
	# $t6: pontuacao atual do enésimo aluno
	# $t7: valor da posição [$t3][$t4] da matrizRespostas
	# $t8: valor em bytes para acessar determinada posição do vetorGabarito
	# $t9: valor da posição [$t8] do vetorGabarito
	# $a0: valor em bytes para acessar determinada posição do vetorPontuacao

	LOOP_LINHA:
	
		beq $t3, 4, FINAL_MATRIZ
		move $t4, $zero
	
		LOOP_COLUNA:
		
			beq $t4, 5, PROXIMA_LINHA
				
				lw $t7, matrizRespostas($t5)
				lw $t9, vetorGabarito($t8)
				
				beq $t7, $t9, ADD_PONTUACAO
				
					j NAO_ACERTOU
				
				ADD_PONTUACAO:
				
					addi $t6, $t6, 1
				
				NAO_ACERTOU:
					
					addi $t4, $t4, 1
					addi $t5, $t5, 4
					addi $t8, $t8, 4
					j LOOP_COLUNA
				
			PROXIMA_LINHA:
			
				addi $t3, $t3, 1
				move $t8, $zero
				sw $t6, vetorPontuacao($a0)
				addi $a0, $a0, 4
				
				beq $t6, 5, ACERTOS5
				
					bge $t6, 1, ACERTOS1_4
					
						addi $t2, $t2, 1  
						j FIM_VERIFICAO_ACERTOS
				
				ACERTOS5:
					
					addi $t0, $t0, 1
					j FIM_VERIFICAO_ACERTOS   # Quero dizer que é o fim da verificação para ver se o aluno acertou 5, 1-4 ou nenhuma das alternativas
				
				ACERTOS1_4:
				
					addi $t1, $t1, 1
				
				FIM_VERIFICAO_ACERTOS:
				
					move $t6, $zero
					
				j LOOP_LINHA
					
	FINAL_MATRIZ:
	
	nop