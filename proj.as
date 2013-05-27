;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ARQUITECTURA DE COMPUTADORES ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    2009/2010 - 2ÂºSEMESTRE    ;;
;;           PROJECTO           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 56886 Marco Ferreira         ;;
;; 56978 Joao Lopes             ;;
;; 64787 Joao Neto              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Definicao de Constantes ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; I/O - Janela de Texto
IO_READ     EQU   FFFFh	;; Porto de Leitura
IO_WRITE    EQU   FFFEh	;; Porto de Escrita
IO_STATUS   EQU   FFFDh ;; Porto de Leitura de Estado (foi escrito algum caracter)
IO_CURSOR   EQU   FFFCh ;; Porto para alterar a posicao do cursor


;; I/O - Interruptores
INTERRUPTORES	EQU	FFF9h	;; Porto de Leitura do Estado dos Interruptores

;; I/O - LEDs
LEDS		EQU	FFF8h	;; Porto de Escrita de Estado dos LEDs

;; I/O - LCD
LCD		EQU	FFF5h	;; Porto para Escrita no LCD
LCD_CONTROL	EQU	FFF4h	;; Porto para alterar a Posicao do Cursor

;; I/O - Temporizador
TimerControl	EQU	FFF7h	;; Porto de Controlo
TimerValue	EQU	FFF6h	;; Porto de Escrita com o valor a contabilizar (0.1x)
EnableTimer	EQU	1


;; I/O - Mascara de Interrupcoes
INT_MASK	EQU	FFFAh	;; Porto para alterar Mascara de Interrupcoes
MASK  	  	EQU	1000001111111111b ;; Mascara de interrupções, fazendo enable ao temporizador, e interruptores de 0 a 9

;; I/O - Display de 7 segmentos
Display1	EQU	FFF0h	;; Porto de Escrita do Segmento 1
Display2	EQU	FFF1h	;; Porto de Escrita do Segmento 2
Display3	EQU	FFF2h	;; Porto de Escrita do Segmento 3
Display4	EQU	FFF3h	;; Porto de Escrita do Segmento 4


;; Diversos
SP_INICIAL  EQU   FDFFh	;; Topo da Pilha
MUDAR_LINHA EQU	  00C0h ;; Valor a somar para atingir próxima linha
FIM_TEXTO   EQU   '@' ;; Marcador de Fim de linha
RAND_MASK	EQU	8016h	;; Mascara usada na geracao de numeros aleatorios
RAND_INIT	EQU	CAFEh	;; Sequencia aleatoria inicial
CICLOS_PASSAGEIROS	EQU	50


	

;;;;;;;;;;;;;;;;;;;;;;;
;;   ZONA DE DADOS   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		ORIG 7000h
TEST_TEMP	WORD	0000h ;; Verifica se temporizador foi activado
POS_COMBOIO	TAB	6 ;; Vector com as 6 posicoes do comboio do usr
POS_FANTASMA	TAB	6 ;; Vector com as 6 posicoes da automotora fant	 
Estacao1	WORD	830Eh ;; Endereco da primeira posicao a colocar passageiros da estacao 1 (designada por nos)
Estacao2	WORD	8A0Eh ;; Endereco da primeira posicao a colocar passageiros da estacao 2 (designada por nos)
Estacao3	WORD	920Ch ;; Endereco da primeira posicao a colocar passageiros da estacao 3 (designada por nos)
Estacao4	WORD	9723h ;; Endereco da primeira posicao a colocar passageiros da estacao 4 (designada por nos)
PassageirosEstacao1 WORD 0h ;; Numero de passageiros ja inseridos na estacao 1
PassageirosEstacao2 WORD 0h ;; Numero de passageiros ja inseridos na estacao 2
PassageirosEstacao3 WORD 0h ;; Numero de passageiros ja inseridos na estacao 3
PassageirosEstacao4 WORD 0h ;; Numero de passageiros ja inseridos na estacao 4
DIR_COMBOIO	WORD	0000h ;; Vector velocidade. 8 bits mais  sig: velocidade vertical
DIR_FANTASMA	WORD	0000h ;; Vector velocidade. 8 bits menos sig: velocidade horizontal
CAR_COMBOIO	STR	'||||||' ;; Caracteres que se encontra por baixo do comboio utilizador
CAR_FANTASMA	STR	'------' ;; Caracteres que se encontra por baixo da automotora fantasma
CAR_COMBOIO_INICIAL	STR	'||||||' ;; Caracteres que se encontra por baixo do comboio utilizador inicialmente
CAR_FANTASMA_INICIAL	STR	'------' ;; Caracteres que se encontra por baixo da automotora fantasma inicialmente
Ag0             WORD    8321h       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Ag1             WORD    8629h       ;;
Ag2             WORD    863Eh       ;;
Ag3             WORD    8C3Eh       ;;
Ag4             WORD    9734h       ;;           Posicao das agulhas
Ag5             WORD    971Dh       ;;
Ag6             WORD    921Dh       ;;
Ag7             WORD    8D05h       ;;
Ag8             WORD    8A19h       ;;
Ag9             WORD    8619h       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Ag0_INICIAL		WORD	'-'   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Ag1_INICIAL             WORD    '-'   ;;
Ag2_INICIAL             WORD    '/'   ;;
Ag3_INICIAL             WORD    '|'   ;;
Ag4_INICIAL             WORD    '/'   ;;
Ag5_INICIAL             WORD    '-'   ;;               Posicao inicial das agulhas               
Ag6_INICIAL             WORD    '\'   ;; 
Ag7_INICIAL             WORD    '|'   ;;
Ag8_INICIAL             WORD    '/'   ;;
Ag9_INICIAL     	WORD    '/'   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ChangedAg0      WORD    0h  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ChangedAg1      WORD    0h  ;;
ChangedAg2      WORD    0h  ;;
ChangedAg3      WORD    0h  ;;
ChangedAg4      WORD    0h  ;;
ChangedAg5      WORD    0h  ;;         Indica se a agulha foi alterada
ChangedAg6      WORD    0h  ;;
ChangedAg7      WORD    0h  ;;
ChangedAg8      WORD    0h  ;;
ChangedAg9      WORD    0h  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Contador1	WORD    0h ;; Pontuacao - unidades
Contador2       WORD    0h ;; Pontuacao - dezenas
Contador3       WORD    0h ;; Pontuacao - centenas
Contador4       WORD    0h ;; Pontuacao - milhares
Colisao		WORD	0h ;; Indica se houve colisão
FimJogo		WORD	0h ;; Indica se o jogo é suposto acabar
PontuacaoMaxima	WORD	0h ;; Contem a pontuacao mais elevada até ao momento 
TimeLong    	WORD    0003h ;; Valor do temporizador
RandNum		WORD	RAND_INIT
CiclosPassageiros	WORD	CICLOS_PASSAGEIROS
TipoDescFant	WORD	0h	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; String com o cenário do jogo e string de novo Jogo ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		ORIG	8000h
CEN0		STR	'---------------------------------\                              '
ERR0		TAB	00C0h
CEN1		STR	'                                 |                              '
ERR1		TAB	00C0h
CEN2		STR	'                                 |                              '
ERR2		TAB	00C0h
CEN3		STR	'     /--------========----------------------------------------\ ' 
ERR3		TAB	00C0h
CEN4		STR	'     |                           0                            | '
ERR4		TAB	00C0h
CEN5		STR	'     |                   9               1                    | '
ERR5		TAB	00C0h
CEN6		STR	'     |     --------------/---------------------OooooO---------/ '
ERR6		TAB	00C0h
CEN7		STR	'     |                   |               |                  2 | '
ERR7		TAB	00C0h
CEN8		STR	'     |                   |               |                    | '
ERR8		TAB	00C0h
CEN9		STR	'     |                   |               |                    | '
ERR9		TAB	00C0h
CEN10		STR	'     |     \--========---/ 8             |                    | '
ERR10		TAB	00C0h
CEN11		STR	'     |     |             |               |                    | '
ERR11		TAB	00C0h
CEN12		STR	'     |     |             |               |          /---------| '
ERR12		TAB	00C0h
CEN13		STR	'  /--|7    |             |               |          |       3 | '
ERR13		TAB	00C0h
CEN14		STR	'  |  |     |             |               |          |         | '
ERR14		TAB	00C0h
CEN15		STR	'  #  |     \-------------/               |          |         | '
ERR15		TAB	00C0h
CEN16		STR	'  #  |                                   |          |         | '
ERR16		TAB	00C0h
CEN17		STR	'  #  |                       6           |          |         | '
ERR17		TAB	00C0h
CEN18		STR	'  #  \------========---------\-----------/          |           '
ERR18		TAB	00C0h
CEN19		STR	'  #                          |                      |           '
ERR19		TAB	00C0h
CEN20		STR	'  O                          |                      |           '
ERR20		TAB	00C0h
CEN21		STR	'  |                          |                      |           '  
ERR21		TAB	00C0h
CEN22		STR	'  |                        5 |                      |4          '
ERR22		TAB	00C0h
CEN23		STR	'  \--------------------------------==========-------/---------- '
ERR23		TAB	00C0h
NOVOJOGOCEN1	STR	'Prima tecla@'
NOVOJOGOCEN2	STR	'  N  para  @'
NOVOJOGOCEN3	STR	' novo jogo @'

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TABELA DE INTERRUPCOES ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		ORIG FE00h
INT0		WORD	Agulha0
INT1		WORD	Agulha1
INT2		WORD	Agulha2
INT3		WORD	Agulha3
INT4		WORD	Agulha4
INT5		WORD	Agulha5
INT6		WORD	Agulha6
INT7		WORD	Agulha7
INT8		WORD	Agulha8
INT9		WORD	Agulha9

		ORIG FE0FH
INT15		WORD	Timer


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ROTINAS TRATAMENTO INTERRUPCOES ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		ORIG	2000h
Timer:		PUSH	R1	
		MOV	R1,M[TimeLong]
		MOV	M[TimerValue],R1
		MOV	R1,EnableTimer
		MOV	M[TimerControl],R1
		INC	M[TEST_TEMP]
		POP	R1
		RTI


Agulha0:	INC   M[ChangedAg0]
                RTI

Agulha1:	INC   M[ChangedAg1]
                RTI

Agulha2:	INC   M[ChangedAg2]
                RTI

Agulha3:	INC  M[ChangedAg3]
                RTI

Agulha4:	INC M[ChangedAg4]
                RTI

Agulha5:	INC M[ChangedAg5]
                RTI

Agulha6:	INC M[ChangedAg6]
                RTI

Agulha7:	INC  M[ChangedAg7]
                RTI

Agulha8:	INC  M[ChangedAg8]
                RTI

Agulha9:	INC  M[ChangedAg9]
                RTI

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Zona de código ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	ORIG	0000h
JMP		inicio



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- RandGen
;; Rotina que gera uma sequencia pseudo-aleatoria de numeros de 16 bits com;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ROTINAS TRATAMENTO INTERRUPCOES ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; distribuicao
;; uniforme, com passo de repeticao elevado.
;;
;; Entradas: M[RandNum] - Sequencia Antiga
;; Saidas: M[RandNum] - Sequencia Nova
RandGen:	PUSH	R1
		PUSH	R2
		PUSH	R3
		MOV	R1, M[RandNum]
		MOV	R2, RAND_MASK
		MOV	R3, R1
		SHR	R3, 1
		BR.NC	RandGenElse
		XOR	R1, R2
RandGenElse:	ROR	R1, 1
		MOV	M[RandNum], R1
		POP	R3
		POP	R2
		POP	R1
		RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Inicializacoes ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- Esc_Cenario
;; Rotina que faz a chamada à micro-instrucção de modo a escrever o cenário
;; na janela de texto.
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma;; Posição inicial das agulhas
Esc_Cenario:	PUSH	R1
		PUSH	R2
		PUSH	R3
		MOV	R1, CEN0
		MOV	R2, R0
		MOV	R3, 24
Esc_Cenario_1:	I2OP	R1, R2
		ADD	R1, 100h
		ADD	R2, 100h
		DEC	R3
		CMP	R3, R0
		BR.Z	fim_Esc_Cenario
		BR	Esc_Cenario_1
fim_Esc_Cenario:POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- Inicializa_Comboio
;; Rotina que faz a escrita do comboio do utilizador 
;; na sua posição inicial na janela de texto
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
Inicializa_Comboio:	PUSH	R1
			PUSH	R2
			PUSH	R3
			PUSH	R4
			MOV	R1, POS_COMBOIO
			MOV	R2, 1402h
			MOV	M[R1],R2
			ADD	R2, 8000h
			MOV	R3, 'O'
			MOV	M[R2], R3
			INC	R1
			MOV	R2, 1302h
			MOV	M[R1],R2			
			ADD	R2, 8000h
			MOV	R3, '#'
			MOV	M[R2], R3					
			INC	R1
			MOV	R2, 1202h
			MOV	M[R1],R2	
			ADD	R2, 8000h
			MOV	R3, '#'
			MOV	M[R2], R3	
			INC	R1
			MOV	R2, 1102h
			MOV	M[R1],R2		
			ADD	R2, 8000h
			MOV	R3, '#'
			MOV	M[R2], R3
			INC	R1
			MOV	R2, 1002h
			MOV	M[R1],R2		
			ADD	R2, 8000h
			MOV	R3, '#'
			MOV	M[R2], R3
			INC	R1
			MOV	R2, 0F02h
			MOV	M[R1],R2
			ADD	R2, 8000h
			MOV	R3, '#'
			MOV	M[R2], R3		
			MOV	R3, 0100h
			MOV	R4, DIR_COMBOIO
			MOV	M[R4], R3
			POP	R4
			POP	R3
			POP	R2
			POP	R1
 			RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- Inicializa_Automotora
;; Rotina que faz a escrita da automotora fantasma 
;; na sua posição inicial na janela de texto
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
Inicializa_Automotora:	PUSH	R1
			PUSH	R2
			PUSH	R3
			PUSH	R4
			MOV	R1, POS_FANTASMA
			MOV	R2, 062Fh
			MOV	M[R1],R2
			ADD	R2, 8000h
			MOV	R3, 'O'
			MOV	M[R2], R3
			INC	R1
			MOV	R2, 0630h 
			MOV	M[R1],R2
			ADD	R2, 8000h
			MOV	R3, 'o'
			MOV	M[R2], R3		
			INC	R1
			MOV	R2, 0631h
			MOV	M[R1],R2
			ADD	R2, 8000h
			MOV	R3, 'o'
			MOV	M[R2], R3		
			INC	R1
			MOV	R2, 0632h
			MOV	M[R1],R2
			ADD	R2, 8000h
			MOV	R3, 'o'
			MOV	M[R2], R3		
			INC	R1
			MOV	R2, 0633h
			MOV	M[R1],R2
			ADD	R2, 8000h
			MOV	R3, 'o'
			MOV	M[R2], R3		
			INC	R1
			MOV	R2, 0634h
			MOV	M[R1],R2
			ADD	R2, 8000h
			MOV	R3, 'O'
			MOV	M[R2], R3		
			MOV	R3, -1h
			MOV	R4, DIR_FANTASMA
			MOV	M[R4], R3
 			POP	R4
			POP	R3
			POP	R2
			POP	R1
			RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- Inicializa_Pontuacao
;; Rotina que coloca os contadores da pontuação a 0 
;; 
;; Entradas: Nenhuma
;; Saidas: Nenhuma
Inicializa_Pontuacao:   MOV     M[Display1],R0
                        MOV     M[Display2],R0  
                        MOV     M[Display3],R0  
                        MOV     M[Display4],R0  
                        RET




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- Set_Timer
;; Rotina que faz manualmente a reinicialização do temporizador 
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
Set_Timer:	PUSH	R7
		MOV	R7, M[TimeLong]
		MOV	M[TimerValue],R7
		MOV	R7, EnableTimer
		MOV	M[TimerControl],R7
		POP	R7
		RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Rotinas responsáveis pelo movimento do comboio do utilizador ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- MoveComboio
;; Rotina que faz a chamada a todas as rotinas responsáveis pela  
;; movimentacao do comboio do utilizador
;; 
;; Entradas: Nenhuma
;; Saidas: Nenhuma
MoveComboio:	CALL	ApagarUltimaCarruagem ;; Apaga a ultima carruagem
		CALL	ComutarComboioCar ;; Faz a troca dos caracteres que se encontram por baixo do comboio
		CALL	EscreveLocomotiva ;; Faz a escrita do comboio na posicao nova
		CALL	ActualizaPosicoes ;; Actualiza o POS_COMBOIO com as novas posicoes do comboio
		CALL	VerificaCarril ;; Efectua as curvas caso necessario
		CALL	VerificaPassageiros ;; verifica se a nova posicao do comboio contém um passageiro
		INC	M[Contador1] ;; Pontuação incrementada após movimento
		DEC	M[CiclosPassageiros]
		RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ApagarUltimaCarruagem
;; Rotina que apaga a ultima carruagem do comboio do utilizador
;; e coloca no seu lugar o caracter que se encontra por baixo da carruagem
;; 
;; Entradas: Nenhuma
;; Saidas: Nenhuma
ApagarUltimaCarruagem:	PUSH	R1
			PUSH	R2
			PUSH	R3
			MOV	R1, CAR_COMBOIO
			MOV	R2, M[R1+5]	; devolve o caracter por baixo da ultima carruagem
			MOV	R1, POS_COMBOIO
			MOV	R3, M[R1+5]	; devolve posicao ultima carruagem
			MOV	M[IO_CURSOR], R3
			MOV	M[IO_WRITE], R2
			ADD	R3, 8000h
			MOV	M[R3], R2
			POP	R3
			POP	R2
			POP	R1
			RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ComutarComboioCar
;; Rotina que faz a troca dos caracteres que se encontram por baixo do comboio
;; 
;; Entradas: Nenhuma
;; Saidas: Nenhuma
ComutarComboioCar:	PUSH	R1
			PUSH	R2
			PUSH	R3
                        MOV	R1, 5
ComutarComboioCarCiclo:	MOV	R2, CAR_COMBOIO
			ADD	R2, R1
			DEC	R2
			MOV	R3, M[R2]
			INC	R2
			MOV	M[R2], R3
			DEC	R1
			CMP	R1, R0
			BR.NZ	ComutarComboioCarCiclo
			POP	R3
			POP	R2
			POP	R1
                        RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- EscreveLocomotiva
;; Rotina que faz a escrita da Locomotiva na posicao resultante do movimento
;; 
;; Entradas: Nenhuma
;; Saidas: Nenhuma
EscreveLocomotiva:	PUSH	R1
			PUSH	R2
			PUSH	R3
			MOV	R1, M[POS_COMBOIO]
			MOV	M[IO_CURSOR], R1
			MOV	R2, '#'
			MOV	M[IO_WRITE], R2		; apagar locomotiva, escrever cardinal
			MOV	R3, R1
			ADD	R3, 8000h
			MOV	M[R3], R2			
			ADD	R1, M[DIR_COMBOIO]
			MOV	M[IO_CURSOR], R1
			ADD	R1, 8000h			
			MOV	R2, M[R1]		; ler caracter seguinte (da linha)
			PUSH	R1			
			PUSH	R2			
			CALL	VerificaDescarrilamento
			POP	R2
			POP	R1		
			MOV	M[CAR_COMBOIO], R2
			MOV	R2, 'O'
			MOV	M[IO_WRITE], R2		; escrever nova locomotiva                        
			POP	R3			
			POP	R2
			POP	R1
			RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- VerificaDescarrilamento
;; Rotina que verifica se o comboio foi para uma posicao valida 
;; ou se colidiu com a automotora fantasma
;; 
;; Entradas: R1 - Endereco da string para onde o comboio se desloca
;;	     R2 - Caracter contido na posicao resultante do movimento do comboio
;; Saidas: Nenhuma
VerificaDescarrilamento:PUSH	R1
			PUSH	R2
			MOV	R1, M[SP+5]
			MOV	R2, M[SP+4]
			CMP	R2, ' '
			BR.Z	DescarrilaFant
			CMP	R2, '9'
			BR.NP	Verifica1
			BR	Verifica2
Verifica1:		CMP	R2, '0'
			BR.NN	DescarrilaFant
Verifica2:		CMP	R1, 8000h
			BR.N	DescarrilaFant
			CMP	R1, 9740h
			BR.P	DescarrilaFant
			AND	R1, 00FFh
			CMP	R1, 0040h
			BR.P	DescarrilaFant
			BR	VerificaDescarrilamentoFim
DescarrilaFant:		INC	M[Colisao]
VerificaDescarrilamentoFim:POP	R2
			POP	R1
			RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ActualizaPosicoes
;; Rotina que actualiza o POS_COMBOIO
;; 
;; Entradas: Nenhuma
;; Saidas: Nenhuma
ActualizaPosicoes:	PUSH	R1
			PUSH	R2
			PUSH	R3
                        MOV	R1, 5
ActualizaPosicoesCiclo:	MOV	R2, POS_COMBOIO
			ADD	R2, R1
                        DEC	R2
                        MOV	R3, M[R2]
                        INC	R2
                        MOV	M[R2], R3
                        DEC	R1
                        CMP	R1, R0
                        BR.NZ	ActualizaPosicoesCiclo
			MOV	R1, M[POS_COMBOIO]
			ADD	R1, M[DIR_COMBOIO]
			MOV	M[POS_COMBOIO], R1
                        POP	R3
			POP	R2
			POP	R1
                        RET




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- VerificaCarril
;; Rotina responsável pelas curvas. Caso encontre um caracter
;; correspondente a uma curva altera o DIR_COMBOIO
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
VerificaCarril:		PUSH	R1
			PUSH	R2
			PUSH	R6
			PUSH	R7
                        MOV	R1, M[POS_COMBOIO]
			ADD	R1, 8000h
                        MOV	R2, M[R1]		; caracter da posicao seguinte
			CMP     R2, '\'
                        BR.Z    MudaDir1
			CMP	R2, '/'
			JMP.Z	MudaDir2
			JMP	fim_verCarril
MudaDir1:		MOV	R7, M[DIR_COMBOIO]
			CMP	R7, 0100h
			JMP.Z	MudaDir1DIR
			CMP	R7, 0001h
			JMP.Z	MudaDir1BAIXO
			CMP	R7, -1h
			BR.Z	MudaDir1SOBE
			CMP	R7, -100h
			BR.Z	MudaDir1ESQ
			JMP	fim_verCarril
MudaDir1ESQ:		MOV	R6, -1h
			MOV	R7, DIR_COMBOIO
			MOV	M[R7],R6
			JMP	fim_verCarril
MudaDir1SOBE:		MOV	R6, -100h
			MOV	R7, DIR_COMBOIO
			MOV	M[R7],R6		
			JMP	fim_verCarril
MudaDir1BAIXO:		MOV	R6, 0100h
			MOV	R7, DIR_COMBOIO
			MOV	M[R7],R6
			BR	fim_verCarril
MudaDir1DIR:		MOV	R6, 0001h
			MOV	R7, DIR_COMBOIO
			MOV	M[R7],R6
			BR	fim_verCarril
MudaDir2:		MOV	R7, M[DIR_COMBOIO]
			CMP	R7, 0100h
			JMP.Z	MudaDir1ESQ
			CMP	R7, 0001h
			JMP.Z	MudaDir1SOBE
			CMP	R7, -1h
			JMP.Z	MudaDir1BAIXO
			CMP	R7, -100h
			JMP.Z	MudaDir1DIR
fim_verCarril:		POP	R7
			POP	R6
			POP	R2
			POP	R1
                        RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- VerificaPassageiros
;; Rotina verifica se a nova posicao do comboio contém um passageiro
;; Caso isso aconteca, soma 100 pontos à pontuacao e retira o passageiro da estacao
;; 
;; Entradas: Nenhuma
;; Saidas: Nenhuma
VerificaPassageiros:	PUSH	R1
			PUSH	R2
			MOV	R1, CAR_COMBOIO
			MOV	R2, '&'			
			CMP	M[R1], R2
			BR.NZ	VerificaPassageirosFim
			INC	M[Contador3]
			MOV	R1, M[CAR_COMBOIO]
			MOV	R2, '='
			MOV	M[CAR_COMBOIO], R2
VerificaPassageirosFim:	POP	R2
			POP	R1
			RET






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Rotinas responsáveis pelo movimento da automotora fantasma ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- MoveComboioFant
;; Rotina que faz a chamada a todas as rotinas responsáveis pela  
;; movimentacao da automotora fantasma
;; 
;; Entradas: Nenhuma
;; Saidas: Nenhuma
MoveComboioFant:CALL	ApagarUltimaCarruagemFant
		CMP	M[Colisao], R0
		BR.NZ	MoveComboioFant1		
		CALL	ComutarFantasmaCar
		CALL	EscreveFantasma	; e primeira carruagem, e ler caracter
		CALL	ActualizaPosicoesFant
		CALL	VerificaCarrilFant
		BR	MoveComboioFantfim
MoveComboioFant1:CALL	AgulhaOuNao
		MOV	R1, 1h
		CMP	R1, M[TipoDescFant]
		BR.Z	MoveComboioFant2
MoveComboioFant3:CALL	DescTroco
		CALL	InverteCarFant
		CALL	InvertePosFant
		MOV	M[Colisao], R0
		BR 	MoveComboioFantfim
MoveComboioFant2:MOV	M[Colisao], R0
		CALL	DescAgulha
MoveComboioFantfim:RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- AgulhaOuNao
;; Rotina que verifica se a colisao do fantasma veio de uma agulha ou se veio de 1 troco sem caminho 
;; Entradas: Nenhuma
;; Saidas: Nenhuma
AgulhaOuNao:	PUSH	R1
		PUSH	R2
		MOV	R1, M[POS_FANTASMA]
		ADD	R1, 8000h
		MOV	R2, Ag0
AgulhaOuNao1:	CMP	R1, M[R2]
		BR.Z	DescarrilaAgulha
		INC	R2
		CMP	R2, Ag9
		BR.P	Descarrila
		BR	AgulhaOuNao1
Descarrila:	MOV	R1, 2
		MOV	M[TipoDescFant], R1
		BR	AgulhaOuNaofim
DescarrilaAgulha:MOV	R1, 1
		MOV	M[TipoDescFant], R1
		BR	AgulhaOuNaofim
AgulhaOuNaofim:	POP	R2
		POP	R1
		RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- DescAgulha
;; Rotina que altera a direcção do fantasma caso este fosse descarrilar através de uma agulha
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
DescAgulha:	PUSH	R1
		PUSH	R2
		PUSH	R4
		PUSH	R5 
		MOV	R4, 1h
DescAgulha1:	CALL	RandGen
		MOV	R1, M[RandNum]
		MOV	R2, 4h
		DIV	R1, R2
		CMP	R2, R0
		JMP.Z	ViraEsq
		CMP	R2, 1h
		JMP.Z	ViraDir
		CMP	R2, 2h
		JMP.Z	ViraCima
		CMP	R2, 3h
		JMP.Z	ViraBaixo
ViraEsq:	MOV	R1, FFFFh
		MOV	M[DIR_FANTASMA], R1
		MOV	R2, M[POS_FANTASMA]
		ADD	R2, R1
		ADD	R2, 8000h
		MOV	R5, M[POS_FANTASMA]
		ADD	R5, R1		
		CMP	R5, M[R4+POS_FANTASMA]
		JMP.Z	DescAgulha1
		PUSH	R2
		PUSH	R1
		CALL	VerificaDescarrilamentoFant
		POP	R1
		POP	R2
		CMP	M[Colisao], R0
		JMP.Z	dirValida
		MOV	M[Colisao], R0
		JMP	DescAgulha1
ViraDir:	MOV	R1, 1h
		MOV	M[DIR_FANTASMA], R1
		MOV	R2, M[POS_FANTASMA]
		ADD	R2, R1
		ADD	R2, 8000h
		MOV	R5, M[POS_FANTASMA]
		ADD	R5, R1		
		CMP	R5, M[R4+POS_FANTASMA]
		JMP.Z	DescAgulha1
		PUSH	R2
		PUSH	R1
		CALL	VerificaDescarrilamentoFant
		POP	R1
		POP	R2
		CMP	M[Colisao], R0
		JMP.Z	dirValida
		MOV	M[Colisao], R0
		JMP	DescAgulha1
ViraCima:	MOV	R1, FF00h
		MOV	M[DIR_FANTASMA], R1
		MOV	R2, M[POS_FANTASMA]
		ADD	R2, R1
		ADD	R2, 8000h
		MOV	R5, M[POS_FANTASMA]
		ADD	R5, R1		
		CMP	R5, M[R4+POS_FANTASMA]
		JMP.Z	DescAgulha1
		PUSH	R2
		PUSH	R1
		CALL	VerificaDescarrilamentoFant
		POP	R1
		POP	R2
		CMP	M[Colisao], R0
		JMP.Z	dirValida
		MOV	M[Colisao], R0
		JMP	DescAgulha1
ViraBaixo:	MOV	R1, 100h
		MOV	M[DIR_FANTASMA], R1
		MOV	R2, M[POS_FANTASMA]
		ADD	R2, R1
		ADD	R2, 8000h
		MOV	R5, M[POS_FANTASMA]
		ADD	R5, R1		
		CMP	R5, M[R4+POS_FANTASMA]
		JMP.Z	DescAgulha1
		PUSH	R2
		PUSH	R1
		CALL	VerificaDescarrilamentoFant
		POP	R1
		POP	R2
		CMP	M[Colisao], R0
		JMP.Z	dirValida
		MOV	M[Colisao], R0
		JMP	DescAgulha1
dirValida:	POP	R5
		POP	R4
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- DescTroco
;; Rotina que altera a direcção do fantasma caso este fosse descarrilar através de um troco sem caminho
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
DescTroco:	PUSH	R1
		MOV	R1, M[DIR_FANTASMA]
	 	CMP	R1, 1h
		BR.Z	InverteESQ
		CMP	R1, FFFFh
		BR.Z	InverteDIR
		CMP	R1, 100h
		BR.Z	InverteBAI
		MOV	R1, 100h
		MOV	M[DIR_FANTASMA], R1
InverteESQ:	MOV	R1, FFFFh
		MOV	M[DIR_FANTASMA], R1
		BR DescTrocofim
InverteDIR:	MOV	R1, 1h
		MOV	M[DIR_FANTASMA], R1
		BR DescTrocofim
InverteBAI:	MOV	R1, FF00h
		MOV	M[DIR_FANTASMA], R1
		BR DescTrocofim
DescTrocofim:	POP	R1
		RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- InverteCarFant
;; Rotina que Inverte a estrutura CAR_FANTASMA
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
InverteCarFant:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		MOV	R1, CAR_FANTASMA
		MOV	R2, R1
		ADD	R2, 5h
InverteCarFant1:MOV	R3, M[R1] ;; 1o valor
		MOV	R4, M[R2] ;; ultimo valor
		MOV	M[R1], R4
		MOV	M[R2], R3
		INC	R1
		DEC	R2
		CMP	R1, R2
		BR.NN	InverteCarFantfim
		BR	InverteCarFant1	
InverteCarFantfim:POP	R4
		POP	R3
		POP	R2
		POP	R1
		RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- InvertePosFant
;; Rotina que Inverte a estrutura POS_FANTASMA
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
InvertePosFant:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		MOV	R1, POS_FANTASMA
		MOV	R2, R1
		ADD	R2, 5h
InvertePosFant1:MOV	R3, M[R1] ;; 1o valor
		MOV	R4, M[R2] ;; ultimo valor
		MOV	M[R1], R4
		MOV	M[R2], R3
		INC	R1
		DEC	R2
		CMP	R1, R2
		BR.NN	InvertePosFantfim
		BR	InvertePosFant1	
InvertePosFantfim:POP	R4
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ApagarUltimaCarruagemFant
;; Rotina que apaga a ultima carruagem da automotora fantasma 
;; (neste caso corresponde a uma unidade motora)
;; e coloca no seu lugar o caracter que se encontra por baixo da unidade motora
;; 
;; Entradas: Nenhuma
;; Saidas: Nenhuma
ApagarUltimaCarruagemFant:PUSH	R1
			PUSH	R2
			PUSH	R3
			PUSH	R4
			MOV	R1, M[POS_FANTASMA]
			ADD	R1, M[DIR_FANTASMA]
			ADD	R1, 8000h
			MOV	R2, M[R1]
			PUSH	R1
			PUSH	R2
			CALL	VerificaDescarrilamentoFant
			POP	R2
			POP	R1
			CMP	M[Colisao], R0
			JMP.NZ	ApagarUltimaCarruagemFantfim
			MOV	R1, CAR_FANTASMA
			MOV	R2, M[R1+5]	; devolve o caracter por baixo da ultima carruagem
			MOV	R1, POS_FANTASMA
			MOV	R3, M[R1+5]	; devolve posicao ultima carruagem
			MOV	M[IO_CURSOR], R3
			MOV	M[IO_WRITE], R2
			ADD	R3, 8000h
			MOV	M[R3], R2
			MOV	R3, M[R1+4]
			MOV	M[IO_CURSOR], R3
			MOV	R4, 'O'
			MOV	M[IO_WRITE], R4
			ADD	R3, 8000h
			MOV	M[R3], R4
ApagarUltimaCarruagemFantfim:POP	R4			
			POP	R3
			POP	R2
			POP	R1
			RET



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ComutarFantasmaCar
;; Rotina que faz a troca dos caracteres que se encontram por baixo da automotora fantasma
;; 
;; Entradas: Nenhuma
;; Saidas: Nenhuma
ComutarFantasmaCar:	PUSH	R1
			PUSH	R2
			PUSH	R3
                        MOV	R1, 5
ComutarFantasmaCarCiclo:MOV	R2, CAR_FANTASMA
			ADD	R2, R1
			DEC	R2
			MOV	R3, M[R2]
			INC	R2
			MOV	M[R2], R3
			DEC	R1
			CMP	R1, R0
			BR.NZ	ComutarFantasmaCarCiclo
			POP	R3
			POP	R2
			POP	R1
                        RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- EscreveFantasma
;; Rotina que faz a escrita da unidade motora na posicao resultante do movimento
;; 
;; Entradas: Nenhuma
;; Saidas: Nenhuma
EscreveFantasma:	PUSH	R1
			PUSH	R2
			PUSH 	R3
			MOV	R1, M[POS_FANTASMA]
			MOV	M[IO_CURSOR], R1
			MOV	R2, 'o'
			MOV	M[IO_WRITE], R2		
			MOV	R3, R1
			;ADD	R3, 8000h
			;MOV	M[R3],R2
			ADD	R1, M[DIR_FANTASMA]
			ADD	R1, 8000h
			MOV	R2, M[R1]
			MOV	M[CAR_FANTASMA], R2
			MOV	M[IO_CURSOR], R1
			MOV	R2, 'O'
			MOV	M[IO_WRITE], R2		; escrever nova locomotiva
			;ADD	R1, 8000h
			;MOV	M[R1], R2
			POP	R3
			POP	R2
			POP	R1
			RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- VerificaDescarrilamentoFant
;; Rotina que verifica se a automotora foi para uma posicao valida 
;; 
;; Entradas: R1 - Endereco da string para onde o comboio se desloca
;;	     R2 - Caracter contido na posicao resultante do movimento do comboio
;; Saidas: Nenhuma
VerificaDescarrilamentoFant:DSI
			PUSH	R1
			PUSH	R2
			PUSH	R3
			MOV	R1, M[SP+6]
			MOV	R2, M[SP+5]
			CMP	R2, ' '
			BR.Z	MudaDirFant
			CMP	R2, '9'
			BR.N	VerificaFant1
			BR	VerificaFant2
VerificaFant1:		CMP	R2, '0'
			BR.P	MudaDirFant
VerificaFant2:		MOV	R3, M[POS_COMBOIO]
			ADD	R3, 8000h
			CMP	R1, R3
			BR.Z	MudaDirFant
			SUB	R3, M[DIR_COMBOIO]
			CMP	R1, R3
			BR.Z	MudaDirFant
			CMP	R1, 8000h
			BR.N	MudaDirFant
			CMP	R1, 9740h
			BR.P	MudaDirFant
			AND	R1, 00FFh
			CMP	R1, 0040h
			BR.P	MudaDirFant
			BR	VerificaDescarrilamentoFantFim
MudaDirFant:		INC	M[Colisao]
VerificaDescarrilamentoFantFim:POP	R3
			POP	R2
			POP	R1
			ENI
			RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ActualizaPosicoesFant
;; Rotina que actualiza o POS_FANTASMA
;; 
;; Entradas: Nenhuma
;; Saidas: Nenhuma
ActualizaPosicoesFant:	PUSH	R1
			PUSH	R2
			PUSH	R3
                        MOV	R1, 5
ActualizaPosicoesFant1:	MOV	R2, POS_FANTASMA
			ADD	R2, R1
                        DEC	R2
                        MOV	R3, M[R2]
                        INC	R2
                        MOV	M[R2], R3
                        DEC	R1
                        CMP	R1, R0
                        BR.NZ	ActualizaPosicoesFant1
			MOV	R1, M[POS_FANTASMA]
			ADD	R1, M[DIR_FANTASMA]
			MOV	M[POS_FANTASMA], R1
			POP	R3                        
			POP	R2
			POP	R1
                        RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- VerificaCarrilFant
;; Rotina responsável pelas curvas. Caso encontre um caracter
;; correspondente a uma curva altera o DIR_FANTASMA
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
VerificaCarrilFant:		PUSH	R1
				PUSH	R2
				PUSH	R6
				PUSH	R7
                        MOV	R1, M[POS_FANTASMA]
			ADD	R1, 8000h
                        MOV	R2, M[R1]		; caracter da posicao seguinte
			CMP     R2, '\'
                        BR.Z    MudaDir1Fant
			CMP	R2, '/'
			JMP.Z	MudaDir2Fant
			JMP	fim_verCarrilFant
MudaDir1Fant:		MOV	R7, M[DIR_FANTASMA]
			CMP	R7, 0100h
			JMP.Z	MudaDir1DIRFant
			CMP	R7, 0001h
			JMP.Z	MudaDir1BAIXOFant
			CMP	R7, -1h
			BR.Z	MudaDir1SOBEFant
			CMP	R7, -100h
			BR.Z	MudaDir1ESQFant
			JMP	fim_verCarrilFant
MudaDir1ESQFant:		MOV	R6, -1h
			MOV	R7, DIR_FANTASMA
			MOV	M[R7],R6
			JMP	fim_verCarrilFant
MudaDir1SOBEFant:		MOV	R6, -100h
			MOV	R7, DIR_FANTASMA
			MOV	M[R7],R6		
			JMP	fim_verCarrilFant
MudaDir1BAIXOFant:		MOV	R6, 0100h
			MOV	R7, DIR_FANTASMA
			MOV	M[R7],R6
			BR	fim_verCarrilFant
MudaDir1DIRFant:		MOV	R6, 0001h
			MOV	R7, DIR_FANTASMA
			MOV	M[R7],R6
			BR	fim_verCarrilFant
MudaDir2Fant:		MOV	R7, M[DIR_FANTASMA]
			CMP	R7, 0100h
			JMP.Z	MudaDir1ESQFant
			CMP	R7, 0001h
			JMP.Z	MudaDir1SOBEFant
			CMP	R7, -1h
			JMP.Z	MudaDir1BAIXOFant
			CMP	R7, -100h
			JMP.Z	MudaDir1DIRFant
fim_verCarrilFant:	POP	R7
			POP	R6
			POP	R2
			POP	R1
                        RET



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Actualizações ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ActualizaPontuacao
;; Rotina responsável pelas leitura dos contadores da pontuação
;; e conversao desta para decimal
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
ActualizaPontuacao:    PUSH    R1
                MOV     R1, M[Contador1]
                CMP     R1, 10
                BR.NZ   fimDisplay
Maior9:         INC     M[Contador2]
                MOV     M[Contador1],R0
                MOV     R1,M[Contador2]
                CMP     R1, 10
                BR.NZ   fimDisplay
                INC     M[Contador3]
                MOV     M[Contador2],R0
                MOV     R1,M[Contador3]
                CMP     R1, 10
                BR.NZ   fimDisplay
                INC     M[Contador4]
                MOV     M[Contador3],R0
                MOV     R1,M[Contador4]
                CMP     R1, 10 
                BR.NZ   fimDisplay
                MOV     M[Contador4],R0
fimDisplay:     CALL    Display
                POP     R1
                RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- Display
;; Rotina responsável pela escrita da pontuacao no display de 7 segmentos
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
Display:        PUSH    R1
                MOV     R1,M[Contador1]
                MOV     M[Display1],R1
                MOV     R1,M[Contador2]
                MOV     M[Display2],R1
                MOV     R1,M[Contador3]
                MOV     M[Display3],R1
                MOV     R1,M[Contador4]
                MOV     M[Display4],R1
                POP     R1
                RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ActualizaVelocidade
;; Rotina responsável pela leitura do interruptores
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
ActualizaVelocidade:	PUSH	R7
			MOV	R7, M[INTERRUPTORES]
			ADD	R7, 3h
			CMP	M[TimeLong], R7
			BR.Z	ActualizaVelocidade1
			MOV	M[TimeLong], R7
			CALL	Set_Timer
ActualizaVelocidade1:	POP	R7
			RET	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ActualizaLeds
;; Rotina responsável pela representação do nivel de jogo (através dos leds)
;; consoante o valor dos Interruptores
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
ActualizaLeds:		PUSH	R6
			PUSH	R7
			MOV	R7, M[INTERRUPTORES]
			MOV	R6, R0
ActualizaLeds1:	CMP	R7, R0
			BR.Z	ActualizaLedsFim
ActualizaLeds2:	SHL	R6, 1
			INC	R6			
			DEC	R7
			BR	ActualizaLeds1
ActualizaLedsFim:	MOV	M[LEDS], R6
			POP	R7
			POP	R6
			RET
			

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- EscreveDisplayPontuacao
;; Rotina responsável pela escrita no LCD da pontuação máxima
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
EscreveDisplayPontuacao:PUSH R2
		PUSH R3
			MOV	R2, 8000h
			MOV	M[LCD_CONTROL], R2
			MOV	R3, M[Contador4]
			ADD	R3, 48
			MOV	M[LCD],R3
			INC	R2
			MOV	M[LCD_CONTROL], R2
			MOV	R3, M[Contador3]
			ADD	R3, 48
			MOV	M[LCD],R3
			INC	R2
			MOV	M[LCD_CONTROL], R2
			MOV	R3, M[Contador2]
			ADD	R3, 48
			MOV	M[LCD],R3			
			INC	R2
			MOV	M[LCD_CONTROL], R2			
			MOV	R3, M[Contador1]
			ADD	R3, 48			
			MOV	M[LCD],R3			
			POP	R3
			POP	R2
			RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Passageiros
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- InserePassageiro
;; Rotina responsável pela Insercao de passageiros no cenario de jogo
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
InserePassageiro:PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		CALL	RandGen
		MOV	R1, M[RandNum]
		MOV	R2, 4h
		DIV	R1, R2
		CMP	R2, R0
		JMP.Z	InserePassageiro1
		CMP	R2, 1h
		JMP.Z	InserePassageiro2
		CMP	R2, 2h
		JMP.Z	InserePassageiro3
InserePassageiro4:	MOV	R1, Estacao4
		MOV	R2, M[PassageirosEstacao4]
		CMP	R2, 8h
		JMP.Z	InserePassageirofim
		INC	M[PassageirosEstacao4]
		MOV	R3, M[R1]
		ADD	R3, R2
		MOV	R4, '#'
		MOV	R2, '&'
		MOV	M[R3], R2
		CMP	M[R3], R4
		JMP.Z	InserePassageiroIncrementa
		MOV	R4, 'O'
		CMP	M[R3], R4
		JMP.Z	InserePassageiroComboio4
		JMP	InserePassageiroContinua4
InserePassageiroComboio4:MOV	R4, M[POS_COMBOIO]
		CMP	M[R3], R4
		JMP.Z	InserePassageiroIncrementa
InserePassageiroContinua4:SUB	R3, 8000h		
		MOV	M[IO_CURSOR], R3
		MOV	R4, '&'
		MOV	M[IO_WRITE], R4
		JMP	InserePassageirofim
InserePassageiro1:MOV	R1, Estacao1
		MOV	R2, M[PassageirosEstacao1]
		CMP	R2, 8h
		JMP.Z	InserePassageirofim
		INC	M[PassageirosEstacao1]
		MOV	R3, M[R1]
		ADD	R3, R2
		MOV	R4, '#'
		MOV	R2, '&'
		MOV	M[R3], R2
		CMP	M[R3], R4
		JMP.Z	InserePassageiroIncrementa
		MOV	R4, 'O'
		CMP	M[R3], R4
		JMP.Z	InserePassageiroComboio1
		JMP	InserePassageiroContinua1
InserePassageiroComboio1:MOV	R4, M[POS_COMBOIO]
		CMP	M[R3], R4
		JMP.Z	InserePassageiroIncrementa
InserePassageiroContinua1:SUB	R3, 8000h		
		MOV	M[IO_CURSOR], R3
		MOV	R4, '&'
		MOV	M[IO_WRITE], R4
		JMP	InserePassageirofim
InserePassageiro2:MOV	R1, Estacao2
		MOV	R2, M[PassageirosEstacao2]
		CMP	R2, 8h
		JMP.Z	InserePassageirofim
		INC	M[PassageirosEstacao2]
		MOV	R3, M[R1]
		ADD	R3, R2
		MOV	R4, '#'
		MOV	R2, '&'
		MOV	M[R3], R2
		CMP	M[R3], R4
		JMP.Z	InserePassageiroIncrementa
		MOV	R4, 'O'
		CMP	M[R3], R4
		JMP.Z	InserePassageiroComboio2
		JMP	InserePassageiroContinua2
InserePassageiroComboio2:MOV	R4, M[POS_COMBOIO]
		CMP	M[R3], R4
		JMP.Z	InserePassageiroIncrementa
InserePassageiroContinua2:SUB	R3, 8000h		
		MOV	M[IO_CURSOR], R3
		MOV	R4, '&'
		MOV	M[IO_WRITE], R4
		JMP	InserePassageirofim
InserePassageiro3:		MOV	R1, Estacao3
		MOV	R2, M[PassageirosEstacao3]
		CMP	R2, 8h
		JMP.Z	InserePassageirofim
		INC	M[PassageirosEstacao3]
		MOV	R3, M[R1]
		ADD	R3, R2
		MOV	R4, '#'
		MOV	R2, '&'
		MOV	M[R3], R2
		CMP	M[R3], R4
		JMP.Z	InserePassageiroIncrementa
		MOV	R4, 'O'
		CMP	M[R3], R4
		JMP.Z	InserePassageiroComboio3
		JMP	InserePassageiroContinua3
InserePassageiroComboio3:MOV	R4, M[POS_COMBOIO]
		CMP	M[R3], R4
		JMP.Z	InserePassageiroIncrementa
InserePassageiroContinua3:SUB	R3, 8000h		
		MOV	M[IO_CURSOR], R3
		MOV	R4, '&'
		MOV	M[IO_WRITE], R4
		JMP	InserePassageirofim
InserePassageiroIncrementa: 	INC	M[Contador3]	
InserePassageirofim:	MOV	R1, CICLOS_PASSAGEIROS	
		MOV	M[CiclosPassageiros], R1
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- LimpaEstacoes
;; Rotina que permite limpar as estacoes, apagando todos os passageiros existentes
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
LimpaEstacoes:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		PUSH	R5
		MOV	R1, Estacao1
		MOV	R3, 4h
		MOV	R2, 8h
		MOV	R4, '='
LimpaEstacoes1:	MOV	R5, M[R1]
		MOV	M[R5], R4
		DEC	R2
		CMP	R2, R0
		BR.NZ	LimpaEstacoes1
		DEC	R3
		CMP	R3, 1h
		BR.Z	LimpaEstacoesUltima		
		INC	R1
		MOV	R2, 8h
		BR	LimpaEstacoes1
LimpaEstacoesUltima:	INC	R1	
		MOV	R2, 10h
LimpaEstacoes2:	MOV	R5, M[R1]
		MOV	M[R5], R4
		DEC	R2
		CMP	R2, R0
		BR.NZ	LimpaEstacoes2
		POP	R5
		POP	R4
		POP	R3
		POP	R2
		POP	R1		
		RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Agulhas ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- AnalisaAgulhas
;; Rotina que percorre os ChangedAg de modo a verificar se alguma agulha foi alterada
;; Caso isso aconteca, chama o MudaAgulha com o numero da agulha alterada
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
AnalisaAgulhas:     PUSH	R1
		PUSH	R2
                    MOV R1, M[ChangedAg0]
                    CMP R1, R0
                    BR.Z  AnalisaAgulhas1
		    PUSH  R0
                    CALL  MudaAgulha
		    POP	  R0
                    JMP  fim_AnalisaAgulhas
AnalisaAgulhas1:     MOV R1,M[ChangedAg1] 
                    CMP R1, R0
                    BR.Z  AnalisaAgulhas2
		MOV	R2, 1
		PUSH	R2    
		CALL  MudaAgulha
		POP	R2                 
   		JMP  fim_AnalisaAgulhas
AnalisaAgulhas2:     MOV R1, M[ChangedAg2]
                    CMP R1, R0
                    BR.Z  AnalisaAgulhas3
                    MOV	R2, 2
		PUSH	R2    
		CALL  MudaAgulha
		POP	R2  
                    JMP  fim_AnalisaAgulhas
AnalisaAgulhas3:     MOV R1,M[ChangedAg3] 
                    CMP R1, R0
                    BR.Z  AnalisaAgulhas4
                    MOV	R2, 3
		PUSH	R2    
		CALL  MudaAgulha
		POP	R2  
                    JMP  fim_AnalisaAgulhas
AnalisaAgulhas4:     MOV R1,M[ChangedAg4]
                    CMP R1, R0
                    BR.Z  AnalisaAgulhas5
                    MOV	R2, 4
		PUSH	R2    
		CALL  MudaAgulha
		POP	R2  
                    JMP  fim_AnalisaAgulhas
AnalisaAgulhas5:     MOV R1,M[ChangedAg5] 
                    CMP R1, R0
                    BR.Z  AnalisaAgulhas6
                    MOV	R2, 5
		PUSH	R2    
		CALL  MudaAgulha
		POP	R2  
                    JMP  fim_AnalisaAgulhas
AnalisaAgulhas6:     MOV R1, M[ChangedAg6]
                    CMP R1, R0
                    BR.Z  AnalisaAgulhas7
                    MOV	R2, 6
		PUSH	R2    
		CALL  MudaAgulha
		POP	R2  
                    JMP  fim_AnalisaAgulhas
AnalisaAgulhas7:     MOV R1,M[ChangedAg7]
                    CMP R1, R0
                    BR.Z  AnalisaAgulhas8
                    MOV	R2, 7
		PUSH	R2    
		CALL  MudaAgulha
		POP	R2  
                    BR  fim_AnalisaAgulhas
AnalisaAgulhas8:     MOV R1, M[ChangedAg8]
                    CMP R1, R0
                    BR.Z  AnalisaAgulhas9
                    MOV	R2, 8
		PUSH	R2    
		CALL  MudaAgulha
		POP	R2  
                    BR  fim_AnalisaAgulhas
AnalisaAgulhas9:     MOV R1,M[ChangedAg9] 
                    CMP R1, R0
                    BR.Z  fim_AnalisaAgulhas
                    MOV	R2, 9
		PUSH	R2    
		CALL  MudaAgulha
		POP	R2  
fim_AnalisaAgulhas: POP	R2
		    POP	R1
                    RET



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- MudaAgulha
;; Rotina que consoante a agulha mudada altera o seu caracter para o seu proximo estado
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
MudaAgulha:  PUSH	R1
	PUSH	R2
	PUSH	R3
	PUSH	R4
	MOV	R2, M[SP+6]
              MOV   R4, Ag0
	ADD	R4,R2
	MOV	R3,M[R4]
              MOV   R1, M[R3]
              CMP   R1, '-'
              BR.Z  MudaCaso01
              CMP   R1, '\'
              BR.Z  MudaCaso02
              CMP   R1, '|'
              BR.Z  MudaCaso03
              CMP   R1, '/'
              BR.Z  MudaCaso04
MudaCaso01:    MOV   R1, '\'
              MOV   R2, R3
              MOV   M[R2], R1
              BR    fim_MudaAgulha
MudaCaso02:    MOV   R1, '|'
              MOV   R2, R3
              MOV   M[R2], R1
              BR    fim_MudaAgulha
MudaCaso03:    MOV   R1, '/'
              MOV   R2, R3
              MOV   M[R2], R1
              BR    fim_MudaAgulha
MudaCaso04:    MOV   R1, '-'
              MOV   R2, R3
              MOV   M[R2], R1
              BR    fim_MudaAgulha
fim_MudaAgulha: POP	R4
		POP	R3
		POP	R2
		POP	R1
                RET



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ActualizaAgulhas
;; Rotina que percorre os ChangedAg e procura se alguma agulha foi alterada.
;; Caso exista uma agulha alterada, escreve o seu novo caracter na janela de texto.
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
ActualizaAgulhas: PUSH	R1
		  PUSH	R2
                  MOV R1, M[ChangedAg0]
                  CMP R1, R0
                  BR.Z  ActAg1
                  MOV R1,M[Ag0]
                  SUB R1, 8000h
                  MOV M[IO_CURSOR], R1
                  ADD R1, 8000h
                  MOV R2, M[R1]
                  MOV M[IO_WRITE],R2
                  MOV M[ChangedAg0],R0
                  JMP fimActAg
ActAg1:            MOV R1, M[ChangedAg1]
                  CMP R1, R0
                  BR.Z  ActAg2
                  MOV R1,M[Ag1]
                  SUB R1, 8000h
                  MOV M[IO_CURSOR], R1
                  ADD R1, 8000h
                  MOV R2, M[R1]
                  MOV M[IO_WRITE],R2
                  MOV M[ChangedAg1],R0
                  JMP fimActAg
ActAg2: MOV R1, M[ChangedAg2]
                  CMP R1, R0
                  BR.Z  ActAg3
                  MOV R1,M[Ag2]
                  SUB R1, 8000h
                  MOV M[IO_CURSOR], R1
                  ADD R1, 8000h
                  MOV R2, M[R1]
                  MOV M[IO_WRITE],R2
                  MOV M[ChangedAg2],R0
                  BR fimActAg
ActAg3: MOV R1, M[ChangedAg3]
                  CMP R1, R0
                  BR.Z  ActAg4
                  MOV R1,M[Ag3]
                  SUB R1, 8000h
                  MOV M[IO_CURSOR], R1
                  ADD R1, 8000h
                  MOV R2, M[R1]
                  MOV M[IO_WRITE],R2
                  MOV M[ChangedAg3],R0
                  JMP fimActAg
ActAg4: MOV R1, M[ChangedAg4]
                  CMP R1, R0
                  BR.Z  ActAg5
                  MOV R1,M[Ag4]
                  SUB R1, 8000h
                  MOV M[IO_CURSOR], R1
                  ADD R1, 8000h
                  MOV R2, M[R1]
                  MOV M[IO_WRITE],R2
                  MOV M[ChangedAg4],R0
                  JMP fimActAg
ActAg5: MOV R1, M[ChangedAg5]
                  CMP R1, R0
                  BR.Z  ActAg6
                  MOV R1,M[Ag5]
                  SUB R1, 8000h
                  MOV M[IO_CURSOR], R1
                  ADD R1, 8000h
                  MOV R2, M[R1]
                  MOV M[IO_WRITE],R2
                  MOV M[ChangedAg5],R0
                  JMP fimActAg
ActAg6: MOV R1, M[ChangedAg6]
                  CMP R1, R0
                  BR.Z  ActAg7
                  MOV R1,M[Ag6]
                  SUB R1, 8000h
                  MOV M[IO_CURSOR], R1
                  ADD R1, 8000h
                  MOV R2, M[R1]
                  MOV M[IO_WRITE],R2
                  MOV M[ChangedAg6],R0
                  JMP fimActAg
ActAg7: MOV R1, M[ChangedAg7]
                  CMP R1, R0
                  BR.Z  ActAg8
                  MOV R1,M[Ag7]
                  SUB R1, 8000h
                  MOV M[IO_CURSOR], R1
                  ADD R1, 8000h
                  MOV R2, M[R1]
                  MOV M[IO_WRITE],R2
                  MOV M[ChangedAg7],R0
                  JMP fimActAg
ActAg8: MOV R1, M[ChangedAg8]
                  CMP R1, R0
                  BR.Z  ActAg9
                  MOV R1,M[Ag8]
                  SUB R1, 8000h
                  MOV M[IO_CURSOR], R1
                  ADD R1, 8000h
                  MOV R2, M[R1]
                  MOV M[IO_WRITE],R2
                  MOV M[ChangedAg8],R0
                  JMP fimActAg
ActAg9: MOV R1, M[ChangedAg9]
                  CMP R1, R0
                  BR.Z  fimActAg
                  MOV R1,M[Ag9]
                  SUB R1, 8000h
                  MOV M[IO_CURSOR], R1
                  ADD R1, 8000h
                  MOV R2, M[R1]
                  MOV M[IO_WRITE],R2
                  MOV M[ChangedAg9],R0
fimActAg:         POP	R2
		  POP	R1
                  RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fim do jogo ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- VerificaFimJogo
;; Rotina que verifica o valor da posicao de memoria com o nome Colisao,
;; e caso tenha existido colisao, incrementa o FimJogo, de modo a ser detectado
;; o final do jogo.
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
VerificaFimJogo:PUSH	R1 
		MOV	R1, M[Colisao]
		 CMP	R1, R0
		 BR.Z	VerificaFimJogo1	
FimJogoEt:	 INC	M[FimJogo]
VerificaFimJogo1:POP	R1
		RET



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- EscrevePontuacaoMaxima
;; Rotina que faz a leitura da pontuacao atingida no jogo, e caso esta seja
;; superior ao valor maximo anteriormente registado, o actualiza para o novo
;; valor maximo.
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
EscrevePontuacaoMaxima:	PUSH	R1
			PUSH	R2
			MOV	R1, M[Contador1]
			MOV	R2, M[Contador2]
			SHL	R2, 4
			ADD	R1, R2
			MOV	R2, M[Contador3]
			SHL	R2, 8			
			ADD	R1, R2
			MOV	R2, M[Contador4]
			SHL	R2, 12
			ADD	R1, R2
			CMP	R1, M[PontuacaoMaxima]
			BR.NP	EscrevePontuacaoMaxima1
			MOV	M[PontuacaoMaxima], R1
			CALL	EscreveDisplayPontuacao			
EscrevePontuacaoMaxima1:CALL	LimpaContadores			
			POP 	R2
			POP 	R1			
			RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- LimpaContadores
;; Rotina que faz o reset dos contadores da pontuacao
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
LimpaContadores:	MOV	M[Contador1],R0
			MOV	M[Contador2],R0
			MOV	M[Contador3],R0
			MOV	M[Contador4],R0
			RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- EscreveMensagem
;; Rotina responsavel pela escrita na janela de texta da mensagem 
;; com instruccoes para comeco de um novo jogo
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
EscreveMensagem:	PUSH R1
			PUSH R2
			PUSH R3
			MOV	R1, ERR10
			SUB	R1, 8000h
			ADD	R1, 1h
			MOV	M[IO_CURSOR], R1
			MOV	R2, NOVOJOGOCEN1
EscreveMensagem2:	MOV	R3, M[R2]
			CMP	R3, '@'
			BR.Z	EscreveMensagem1
			MOV	M[IO_WRITE], R3
			INC	R1
			INC	R2
			MOV	M[IO_CURSOR],R1
			BR	EscreveMensagem2
EscreveMensagem1:	MOV	R1, ERR11
			SUB	R1, 8000h
			ADD	R1, 1h
			MOV	M[IO_CURSOR], R1
			MOV	R2, NOVOJOGOCEN2
EscreveMensagem3:	MOV	R3, M[R2]
			CMP	R3, '@'
			BR.Z	EscreveMensagem4
			MOV	M[IO_WRITE], R3
			INC	R1
			INC	R2
			MOV	M[IO_CURSOR],R1
			BR	EscreveMensagem3
EscreveMensagem4:	MOV	R1, ERR12
			SUB	R1, 8000h
			ADD	R1, 1h
			MOV	M[IO_CURSOR], R1
			MOV	R2, NOVOJOGOCEN3
EscreveMensagem5:	MOV	R3, M[R2]
			CMP	R3, '@'
			BR.Z	EscreveMensagemFim
			MOV	M[IO_WRITE], R3
			INC	R1
			INC	R2
			MOV	M[IO_CURSOR],R1
			BR	EscreveMensagem5
EscreveMensagemFim:POP R3
		POP R2
		POP R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Rotinas de geracao de novo jogo ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ApagarComboio
;; Rotina que apaga o comboio da posicao onde se encontra, colocando la os CAR_COMBOIO
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
ApagarComboio:	MOV	R1, CAR_COMBOIO
		MOV	R2, POS_COMBOIO
		MOV	R3, 6h
ApagarComboio1:	MOV	R4, M[R1]
		MOV	R5, M[R2]
		ADD	R5, 8000h
		MOV	M[R5], R4
		INC	R1
		INC	R2		
		DEC	R3
		CMP	R3, R0
		BR.NZ	ApagarComboio1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ApagarFantasma
;;  Rotina que apaga o comboio da posicao onde se encontra, colocando la os CAR_COMBOIO
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
ApagarFantasma:	MOV	R1, CAR_FANTASMA
		MOV	R2, POS_FANTASMA
		MOV	R3, 6h
ApagarFantasma1:MOV	R4, M[R1]
		MOV	R5, M[R2]
		ADD	R5, 8000h
		MOV	M[R5], R4
		INC	R1
		INC	R2
		DEC	R3
		CMP	R3, R0
		BR.NZ	ApagarFantasma1
		RET



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- Reinicia_Agulhas
;; Rotina responsavel pela reposicao das agulhas ao seu estado inicial
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
Reinicia_Agulhas:PUSH R1
		PUSH R2
		PUSH R4
		PUSH R5
		MOV R1, Ag0
		MOV R2, Ag0_INICIAL
Reinicia_Agulhas1:MOV R4, M[R2]
		MOV R5, M[R1]
		MOV M[R5], R4
		INC R1
		INC R2
		CMP R1,Ag9
		BR.NP Reinicia_Agulhas1
		CALL Escreve_Agulhas
		POP R5
		POP R4
		POP R2
		POP R1
		RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- Escreve_Agulhas
;; Rotina que faz a escrita das agulhas na janela de texto
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
Escreve_Agulhas:PUSH R1
		PUSH R2
		PUSH R3
		MOV R1, Ag0
Escreve_Agulhas1:MOV R2, M[R1]
		MOV R3, M[R2]
		SUB R2, 8000h
		MOV M[IO_CURSOR], R2
		MOV M[IO_WRITE], R3
		INC R1
		CMP R1, Ag9
		BR.NZ Escreve_Agulhas1
		POP R3
		POP R2
		POP R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- Reinicia_CAR_COMBOIO
;; Rotina que coloca os valores iniciais dos caracteres que se encontram
;; por baixo do comboio do utilizador
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
Reinicia_CAR_COMBOIO:MOV R1, CAR_COMBOIO
			MOV R4, 6h
			MOV R2, CAR_COMBOIO_INICIAL
Reinicia_CAR_COMBOIO1:	MOV R3, M[R2]
		MOV	M[R1], R3
		INC	R1
		INC	R2
		DEC	R4
		CMP	R4, R0
		BR.NZ	Reinicia_CAR_COMBOIO1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- Reinicia_CAR_FANTASMA
;; Rotina que coloca os valores iniciais dos caracteres que se encontram
;; por baixo da automotora fantasma
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
Reinicia_CAR_FANTASMA:MOV R1, CAR_FANTASMA
			MOV R4, 6h
			MOV R2, CAR_FANTASMA_INICIAL
Reinicia_CAR_FANTASMA1:	MOV R3, M[R2]
		MOV	M[R1], R3
		INC	R1
		INC	R2
		DEC	R4
		CMP	R4, R0
		BR.NZ	Reinicia_CAR_FANTASMA1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- Apaga_Mensagem
;; Rotina que remove a mensagem de apoio ao inicio de um novo jogo da janela de texto
;;
;; Entradas: Nenhuma
;; Saidas: Nenhuma
Apaga_Mensagem:		MOV	R1, ERR10
			SUB	R1, 8000h
			ADD	R1, 1h
			MOV	M[IO_CURSOR], R1
			MOV	R2, NOVOJOGOCEN1
Apaga_Mensagem2:	MOV	R3, M[R2]
			CMP	R3, FIM_TEXTO
			BR.Z	Apaga_Mensagem1
			MOV	R4, ' '
			MOV	M[IO_WRITE], R4
			INC	R1
			INC	R2
			MOV	M[IO_CURSOR],R1
			BR	Apaga_Mensagem2
Apaga_Mensagem1:	MOV	R1, ERR11
			SUB	R1, 8000h
			ADD	R1, 1h
			MOV	M[IO_CURSOR], R1
			MOV	R2, NOVOJOGOCEN2
Apaga_Mensagem3:	MOV	R3, M[R2]
			CMP	R3, FIM_TEXTO
			BR.Z	Apaga_Mensagem4
			MOV	R4, ' '
			MOV	M[IO_WRITE], R4
			INC	R1
			INC	R2
			MOV	M[IO_CURSOR],R1
			BR	Apaga_Mensagem3
Apaga_Mensagem4:	MOV	R1, ERR12
			SUB	R1, 8000h
			ADD	R1, 1h
			MOV	M[IO_CURSOR], R1
			MOV	R2, NOVOJOGOCEN3
Apaga_Mensagem5:	MOV	R3, M[R2]
			CMP	R3, FIM_TEXTO
			BR.Z	Apaga_MensagemFim
			MOV	R4, ' '
			MOV	M[IO_WRITE], R4
			INC	R1
			INC	R2
			MOV	M[IO_CURSOR],R1
			BR	Apaga_Mensagem5
Apaga_MensagemFim:	RET




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Programa Principal ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


inicio:   	MOV   	R7, SP_INICIAL
          	MOV   	SP,R7
          	MOV   	R7, FFFFh
          	MOV   	M[IO_CURSOR],R7
		MOV	R7, MASK
		MOV	M[INT_MASK],R7
		ENI
inicializacoes:	CALL	LimpaEstacoes
		CALL	Inicializa_Comboio
		CALL	Inicializa_Automotora
		CALL	Esc_Cenario
		CALL    Inicializa_Pontuacao
                CALL	Set_Timer
ciclo:		CALL	ActualizaVelocidade
		CALL	ActualizaLeds
		CMP	M[TEST_TEMP],R0
		BR.Z	ciclo
		MOV	M[TEST_TEMP],R0
		CALL	MoveComboio
		CMP	M[Colisao], R0
		BR.NZ	IgnoraFant
		CALL	MoveComboioFant
IgnoraFant:	CALL	VerificaFimJogo
		CALL    AnalisaAgulhas
                CALL    ActualizaAgulhas
                CALL    ActualizaPontuacao
		CMP	M[CiclosPassageiros], R0
		BR.NZ	NaoInserePassageiro
		CALL	InserePassageiro
NaoInserePassageiro:CMP	M[FimJogo],R0
		BR.Z	ciclo
NovoJogo:	CALL	EscrevePontuacaoMaxima
		CALL	EscreveMensagem
NovoJogo1:	CMP	M[IO_STATUS],R0
		BR.Z	NovoJogo1
		MOV	R1, M[IO_READ]
		CMP	R1, 'n'
		BR.NZ	NovoJogo
		MOV	M[Colisao],R0
		MOV	M[FimJogo],R0
		CALL	ApagarComboio
		CALL	ApagarFantasma
		CALL	Reinicia_Agulhas
		CALL	Reinicia_CAR_COMBOIO
		CALL	Reinicia_CAR_FANTASMA
		CALL	Apaga_Mensagem
		JMP	inicializacoes
