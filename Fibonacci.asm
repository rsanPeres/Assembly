.data  			#local de inicialização das variaveis
msgEntrada: .asciiz "Digite um valor: "
msgSaida: .asciiz "O resultado é: "


.text 

	la $a0, msgEntrada		#armazena o endereço da mensagem para ser impressa
	li $v0, 4			#armazena o codigo de impressao em $v0
 	syscall
	
	li $v0, 5		#faz a leitura do valor inteiro digitado pelo usuario e armazena em $v0
	syscall			#	
	move $t2, $v0 		#armazena em $t0 o numero digitado pelo usuario

	move $a0,$t2		#armazena o valor digitado em $a0 para passagem para a instrução fibonacci
	move $v0,$t2		# respostasss????

	jal fibonacci		# guarda $pc + 4(proxima instrução e chama a função fibonacci(valorDigitado)
	move $t3, $v0		# quarda o resultado passado da instrção em um temporario para manipulação

	la $a0, msgSaida	#armazena o endereço da mensagem para ser impressa
	li $v0, 4		#armazena o codigo de impressao em $v0
 	syscall

	move $a0,$t3    	#guarda o resultado no argumento para ser impresso
	li $v0,1		#armazena o codigo de impressão de inteiros
	syscall			# chama o sistema
	
	li $v0, 10		# armazena em $v0 o codigo que finaliza o programa
	syscall

	fibonacci:
	#no primeiro ciclo, se n digitado for um ou zero ja retorna e finaliza a aplicação
	
	beq $a0,0, igualZero	#sai da instrução se for igual a 0
	beq $a0,1, igualUm		#sai da instrução se for igual a 1
	
	sub $sp,$sp,4   		#abertura de espaço na pilha 
	sw $ra,0($sp)			#armazenamento do endereço
	addi $a0, $a0, -1		#faz (n-1)

	jal fibonacci     		#fibonacci(n - 1)
	add $a0,$a0,1
	lw $ra,0($sp)   		#pega endereço guardado anteriormente
	add $sp,$sp,4			#restaura pilha

	sub $sp,$sp,8   
	sw $v0,4($sp)
	sw $ra,0($sp)			#armazena $ra

	addi $a0,$a0, -2   		# faz (n - 2)	
	jal fibonacci     		#fibonacci(n - 2)
	add $a0,$a0,2 			#retorna valor de $a0

	lw $ra,0($sp)   
	lw $s7,4($sp)   
	add $sp,$sp,8

	add $v0,$v0,$s7 		# soma fibonacci(n - 2) + fibonacci(n - 1)
	jr $ra	

	igualUm:		#se igual a um
	li $v0,1		#guarda 1 no valor de retorno
	jr $ra			#retorna 

	igualZero:		#se igual a zero
	li $v0,0		#guarda 1 no valor de retorno
	jr $ra			#retorna 
	

	
