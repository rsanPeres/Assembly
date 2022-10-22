#Trabalho apresentaado a disciplica de Arquitetura  e organização de computadores

.data  			#local de inicialização das variaveis
 vet: .word 

 msgEntrada: .asciiz "Digite um valor: "
nCrescente: .asciiz " A sequencia crescente é: "
nDecrescente: .asciiz " A sequencia decrescente é: "

.text 
main:

la $a2, vet				#armazena endereço de vetor no registrador $v1

li $t1, 0				#contador indica a posição no vetor	
			
add $a1, $a1, $t1 			#armazena em %a0 o indice
addi $a3, $a3, 4                        #indica o tamanho do vetor                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4-8

addi $sp, $sp, -12
sw $a3, 8($sp)
sw $a2, 4($sp)
sw $a1, 0($sp)

leitura:				# faz leitura dos valores e quarda em ordem crescente no vetor
	addi $a0, $a0, 0
	beq $t1, $a3, fimLeitura	#verifica se o indice contem mesmo valor do tamanho do vetor, se sim vai para ordenação
	la $a0, msgEntrada		#armazena o endereço da mensagem para ser impressa
	li $v0, 4			#armazena o codigo de impressao em $v0
 	syscall				#chama sistema para imprimir
	
	li $v0, 5			#faz a leitura do valor inteiro digitado pelo usuario e armazena em $v0
	syscall				# chamada do sistema 
	
	sw $v0, 0($a2)			#salva o valor lido no teclado na posição i

	addi $a2, $a2, 4		#adiciona a posição do vetor ao indice
	addi $t1, $t1, 1		#incrementa o contador

	j leitura

fimLeitura:	
	addi $a0, $a0, 4


	j percorreVet
 


percorreVet:
		beq $a0, $zero, fimOrdena
		lw $a1, 0($sp)
		lw $a2, 4($sp)
  		sw $a3, 8($sp)
		addi $sp, $sp, 12
		addi $sp, $sp, -12
		sw $a3, 8($sp)
		sw $a2, 4($sp)
		sw $a1, 0($sp)
			
		addi $a0, $a0, -1

		beq $a1, $a3, percorreVet	#Testa de o contador já chegou no ultimo elemento do vetor
		lw $t6, 0($a2)			#carrega o valor salvo na posição i do contador em $t6
		
		addi $a2, $a2, 4		#incrementa 4 no endereço para receber o proximo valor
		lw $t5, 0($a2)			#carreha o proximo valor no registrado $t5
		
		slt $t7, $t6, $t5		#testa se o valor i é menor que o valor i+1
		beq $t7, 1, Else		#se $t6 < $t5 vai pro else 
		
		sw $t6, 0($a2)			#guarda $t6 na posição i+1
		addi $a2, $a2, -4		#muda o endereço do vetor para i
		sw $t5, 0($a2)			# guarda o valor i+ 1 em i
		
		addi $a2, $a2, 4		#icrementa a posição do contador $t4
		addi $a1,$a1, 1			#adiciona 1 ao contador
		j percorreVet			# retorna para inicio da função
		
		Else:				# se i < i+1
		addi $a1,$a1, 1			#só incremento a posição do vetor
		j percorreVet
	
		fimOrdena:
lw $a1, 0($sp)
lw $a2, 4($sp)
sw $a3, 8($sp)
addi $sp, $sp, 12
addi $sp, $sp, -12
sw $a3, 8($sp)
sw $a2, 4($sp)
sw $a1, 0($sp)
la $a0, nCrescente
li $v0, 4				# 
syscall					#chama o sistema

j ImprimeCrescente


	ImprimeCrescente:			#Imprime os valores salvos no vetor 
	
	beq $a1,$a3, Exit 		#se todos ps valores foram impressos vai para função imprime decrescente
	
	lw $t6, 0($a2)				#armazena o endereço do vetor somado ao indice em $t4
	
	move $a0,$t6   				#guarda o numero no argumento para ser impresso
	li $v0, 1				# Imprime valor na posição i do vetor
	syscall					#chama o sistema


	addi $a1,$a1, 1				#incrementa indice
	addi $a2, $a2, 4			#guarda a posição do contador no $t4
j ImprimeCrescente



	Exit:					#função finaliza a aplicação
	

	li $v0, 10				#grava o código de saida no registrador 
	syscall					#chama sistema para finalizar

	



	

	

