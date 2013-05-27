;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ARQUITECTURA DE COMPUTADORES ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    2009/2010 - 2 SEMESTRE    ;;
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
IO_TEXT_READ	EQU	FFFFh	;; Porto de Leitura
IO_TEXT_WRITE	EQU	FFFEh	;; Porto de Escrita
IO_TEXT_STATUS	EQU	FFFDh	;; Porto de Leitura de Estado (foi escrito algum caracter)
IO_TEXT_CTRL	EQU	FFFCh	;; Porto para alterar a posicao do cursor
TEXT_ACTIVATE	EQU	FFFFh	;; Valor para activar Janela de Texto
NEXT_LINE	EQU	0100h	;; Valor a somar para incrementar a linha

;; I/O - Interruptores
IO_SWITCHES	EQU	FFF9h	;; Porto de Leitura do Estado dos Interruptores

;; I/O - LEDs
IO_LEDS		EQU	FFF8h	;; Porto de Escrita de Estado dos LEDs

;; I/O - Display de 7 segmentos
IO_DISP_SEG1	EQU	FFF0h	;; Porto de Escrita do Segmento 1
IO_DISP_SEG2	EQU	FFF1h	;; Porto de Escrita do Segmento 2
IO_DISP_SEG3	EQU	FFF2h	;; Porto de Escrita do Segmento 3
IO_DISP_SEG4	EQU	FFF3h	;; Porto de Escrita do Segmento 4

;; I/O - LCD
IO_LCD_WRITE	EQU	FFF5h	;; Porto para Escrita no LCD
IO_LCD_CTRL	EQU	FFF4h	;; Porto para alterar a Posicao do Cursor

;; I/O - Mascara de Interrupcoes
IO_INT_MASK	EQU	FFFAh	;; Porto para alterar Mascara de Interrupcoes

;; I/O - Temporizador
IO_TIMER_CTRL	EQU	FFF7h	;; Porto de Controlo
IO_TIMER_VALUE	EQU	FFF6h	;; Porto de Escrita com o valor a contabilizar (0.1x)
TIMER_BASE_TIME	EQU	3	;; 300ms Tempo Base
TIMER_ENABLE	EQU	1

;; Comboio do Utilizador
USR_TRAIN_CAR	EQU	'#'	;; Carruagem do Utilizador
USR_TRAIN_LOC	EQU	'O'	;; Locomotiva do Utilizador
USR_TRAIN_LENG	EQU	6	;; Locomotiva + 5 Carruagens
USR_TRAIN_IDIR	EQU	0100h	;; Direccao Inicial do Comboio (1, 0)
POS_USR_LOC	EQU	1402h	;; Posicao Inicial da Locomotiva
POS_USR_DIFF	EQU	FF00h	;; (-100h) Disposicao Inicial do Comboio (Vertical p Cima)

;; Automotora Fantasma
AI_TRAIN_CAR	EQU	'o'	;; Caracter da Carruagem
AI_TRAIN_LOC	EQU	'O'	;; Caracter das Locomotivas
AI_TRAIN_LENG	EQU	6	;; 2 Locomotivas + 4 Carruagens
AI_TRAIN_IDIR	EQU	FFFFh	;; Direccao Inicial do Comboio (0, -1)
POS_AI_LOC	EQU	062Fh	;; Posicao Inicial da Locomotiva
POS_AI_DIFF	EQU	0001h	;; Disposicao Inicial da Automotora (Horizontal p Direita)
AI_NUM_LOC	EQU	2	;; Numero de Locomotivas na Automotora

;; Estacoes
STATION_CAR	EQU	'='	;; Caracter da Estacao
STATION_PASSENG	EQU	'&'	;; Caracter que representa um Passageiro
NUM_STATIONS	EQU	4	;; Numero de Estacoes no Cenario
PASSENGER_FREQ	EQU	50	;; Frequencia com que sao colocados novos passageiros

;; Posicoes das Estacoes
POS_STATION1	EQU	030Eh
POS_STATION2	EQU	0A0Eh
POS_STATION3	EQU	120Ch
POS_STATION4	EQU	1723h

;; Tamanhos das Estacoes
STATION_SIZE1	EQU	8
STATION_SIZE2	EQU	8
STATION_SIZE3	EQU	8
STATION_SIZE4	EQU	10

;; Agulhas
NEEDLE_CAR_L	EQU	'\'	;; Curva a esquerda (visto de frente)
NEEDLE_CAR_R	EQU	'/'	;; Curva a direita (visto de frente)
NEEDLE_CAR_V	EQU	'|'	;; Linha vertical
NEEDLE_CAR_H	EQU	'-'	;; Linha horizontal
NUM_NEEDLES	EQU	10	;; Numero de Agulhas
NEEDLE_STATES	EQU	4	;; Numero de estados possiveis das agulhas

;; Cenario
NUM_LINES	EQU	24	;; Numero de linhas do cenario
NUM_COLS	EQU	64	;; Numero de colunas do cenario

;; Posicoes das 10 Agulhas
POS_NEEDLE0	EQU	0321h
POS_NEEDLE1	EQU	0629h
POS_NEEDLE2	EQU	063Eh
POS_NEEDLE3	EQU	0C3Eh
POS_NEEDLE4	EQU	1734h
POS_NEEDLE5	EQU	171Dh
POS_NEEDLE6	EQU	121Dh
POS_NEEDLE7	EQU	0D05h
POS_NEEDLE8	EQU	0A19h
POS_NEEDLE9	EQU	0619h

;; Diversos
STACK_TOP	EQU	FDFFh	;; Topo da Pilha
INT_MASK	EQU	1000001111111111b
RAND_MASK	EQU	8016h	;; Mascara usada na geracao de numeros aleatorios
RAND_INIT	EQU	CAFEh	;; Sequencia aleatoria inicial
DIGIT_OVERFLOW	EQU	10
END_STRING	EQU	'@'	;; Caracter limitador de Fim de String

;; Mensagem de Fim de Jogo
NEW_GAME_KEY	EQU	'n'	;; Tecla para Iniciar novo jogo
END_GAME_POS	EQU	0041h	;; Posicao onde escrever String de fim de jogo (L0, C65)

;; Boolean ADT
TRUE		EQU	1
FALSE		EQU	0

;;;;;;;;;;;;;;;;;;;;;;;
;;   ZONA DE DADOS   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		ORIG	8000h
Test_Temp	WORD	FALSE	;; Verifica se temporizador foi activado
Pos_Comboio	TAB	USR_TRAIN_LENG	;; Vector com as 6 posicoes do comboio do usr
Pos_Fantasma	TAB	AI_TRAIN_LENG	;; Vector com as 6 posicoes da automotora fant
Dir_Comboio	WORD	0000h	;; Vector velocidade. 8b mais  sig: velocidade vertical
Dir_Fantasma	WORD	0000h	;; Vector velocidade. 8b menos sig: velocidade horizontal
Station_Pos	STR	POS_STATION1, POS_STATION2, POS_STATION3, POS_STATION4
Station_Size	STR	STATION_SIZE1, STATION_SIZE2, STATION_SIZE3, STATION_SIZE4
PassengerCheck	WORD	PASSENGER_FREQ	;; Contador de Ciclos ate inserir novo passageiro
Pos_Needle0 	WORD	POS_NEEDLE0
Pos_Needle1	WORD	POS_NEEDLE1	;; Posicao das agulhas
Pos_Needle2	WORD	POS_NEEDLE2	;; na janela de texto
Pos_Needle3	WORD	POS_NEEDLE3
Pos_Needle4	WORD	POS_NEEDLE4
Pos_Needle5	WORD	POS_NEEDLE5
Pos_Needle6	WORD	POS_NEEDLE6
Pos_Needle7	WORD	POS_NEEDLE7
Pos_Needle8	WORD	POS_NEEDLE8
Pos_Needle9	WORD	POS_NEEDLE9
NeedleChanged0	WORD	FALSE
NeedleChanged1	WORD	FALSE		;; Utilizador premiu na tecla para mudar
NeedleChanged2	WORD	FALSE		;; agulha de estado?
NeedleChanged3	WORD	FALSE
NeedleChanged4	WORD	FALSE
NeedleChanged5	WORD	FALSE
NeedleChanged6	WORD	FALSE
NeedleChanged7	WORD	FALSE
NeedleChanged8	WORD	FALSE
NeedleChanged9	WORD	FALSE
ScoreCounter1	WORD	0	;; Pontuacao - Unidades
ScoreCounter2	WORD	0	;; Pontuacao - Dezenas
ScoreCounter3	WORD	0	;; Pontuacao - Centenas
ScoreCounter4	WORD	0	;; Pontuacao - Milhares
RecordScore	WORD	0	;; Pontuacao recorde
RandNum		WORD	RAND_INIT
GameOver	WORD	FALSE	;; Verifica se se encontra em fim de jogo
Str_GameArea_01	STR	'---------------------------------\                              '
Str_GameArea_02	STR	'                                 |                              '
Str_GameArea_03	STR	'                                 |                              '
Str_GameArea_04	STR	'     /--------========----------------------------------------\ '
Str_GameArea_05	STR	'     |                           0                            | '
Str_GameArea_06	STR	'     |                   9               1                    | '
Str_GameArea_07	STR	'     |     --------------/------------------------------------/ '
Str_GameArea_08	STR	'     |                   |               |                  2 | '
Str_GameArea_09	STR	'     |                   |               |                    | '
Str_GameArea_10	STR	'     |                   |               |                    | '
Str_GameArea_11	STR	'     |     /--========---/ 8             |                    | '
Str_GameArea_12	STR	'     |     |             |               |                    | '
Str_GameArea_13	STR	'     |     |             |               |          /---------| '
Str_GameArea_14	STR	'  /--| 7   |             |               |          |       3 | '
Str_GameArea_15	STR	'  |  |     |             |               |          |         | '
Str_GameArea_16	STR	'  |  |     \-------------/               |          |         | '
Str_GameArea_17	STR	'  |  |                                   |          |         | '
Str_GameArea_18	STR	'  |  |                       6           |          |         | '
Str_GameArea_19	STR	'  |  \------========---------\-----------/          |           '
Str_GameArea_20	STR	'  |                          |                      |           '
Str_GameArea_21	STR	'  |                          |                      |           '
Str_GameArea_22	STR	'  |                          |                      |           '
Str_GameArea_23	STR	'  |                        5 |                      | 4         '
Str_GameArea_24	STR	'  \--------------------------------==========-------/---------- '
Str_NewGame_1	STR	'Prima tecla', END_STRING
Str_NewGame_2	STR	' "', NEW_GAME_KEY, '"  para', END_STRING
Str_NewGame_3	STR	' novo jogo', END_STRING


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TABELA DE INTERRUPCOES ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		ORIG	FE00h
Int0		WORD	Int_Needle0
Int1		WORD	Int_Needle1
Int2		WORD	Int_Needle2
Int3		WORD	Int_Needle3
Int4		WORD	Int_Needle4
Int5		WORD	Int_Needle5
Int6		WORD	Int_Needle6
Int7		WORD	Int_Needle7
Int8		WORD	Int_Needle8
Int9		WORD	Int_Needle9
IntA		TAB	1
IntB		TAB	1
IntC		TAB	1
IntD		TAB	1
IntE		TAB	1
IntF		WORD	Int_Timer

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  PROGRAMA PRINCIPAL  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		ORIG	0000h


Main:		MOV	R7, STACK_TOP	;; Inicializacao do StackPointer
		MOV	SP, R7
		MOV	R7, INT_MASK
		MOV	M[IO_INT_MASK], R7
		CALL	Initialize
MainLoop:	CALL	NewGame
		ENI
		CALL	StartTimer
		CALL	MidGame
		DSI
		CALL	EndGame
		BR	MainLoop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ROTINAS TRATAMENTO INTERRUPCOES ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Int_Needle0:	INC	M[NeedleChanged0]
		RTI

Int_Needle1:	INC	M[NeedleChanged1]
		RTI

Int_Needle2:	INC	M[NeedleChanged2]
		RTI

Int_Needle3:	INC	M[NeedleChanged3]
		RTI

Int_Needle4:	INC	M[NeedleChanged4]
		RTI

Int_Needle5:	INC	M[NeedleChanged5]
		RTI

Int_Needle6:	INC	M[NeedleChanged6]
		RTI

Int_Needle7:	INC	M[NeedleChanged7]
		RTI

Int_Needle8:	INC	M[NeedleChanged8]
		RTI

Int_Needle9:	INC	M[NeedleChanged9]
		RTI

Int_Timer:	PUSH	R1
		INC	M[Test_Temp]		; Permitir proximo ciclo
		MOV	R1, TIMER_BASE_TIME	; Tempo base
		ADD	R1, M[IO_SWITCHES]	; Mais switches
		MOV	M[IO_TIMER_VALUE], R1
		MOV	R1, TIMER_ENABLE	; Activar temporizador
		MOV	M[IO_TIMER_CTRL], R1
		POP	R1
		RTI

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- RandGen
;; Rotina que gera uma sequencia pseudo-aleatoria de numeros de 16 bits com distribuicao
;; uniforme, com passo de repeticao elevado.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da posicao de memoria RandNum
;;
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- StartTimer
;;
;; Rotina que inicializa o temporizador
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Activa o temporizador
;;
StartTimer:	PUSH	R1
		MOV	R1, TIMER_BASE_TIME
		ADD	R1, M[IO_SWITCHES]
		MOV	M[IO_TIMER_VALUE], R1
		MOV	R1, TIMER_ENABLE
		MOV	M[IO_TIMER_CTRL], R1
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 	- Initialize
;;
;; Efectua operacoes que preparam para o inicio do jogo.
;; 
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera Janela de Texto, altera posicoes de memoria (ver funcao ResetRecord)
;;
Initialize:	CALL	InitTextWindow		; Inicializar Janela de Texto
		CALL	WriteScenario		; Escrever Cenario de Jogo
		CALL	ResetRecord		; Recorde = 0
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- InitTextWindow
;;
;; Inicializa a Janela de Texto
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: nenhum
;;
InitTextWindow:	PUSH	R1
		MOV	R1, TEXT_ACTIVATE
		MOV	M[IO_TEXT_CTRL], R1
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- WriteScenario
;;
;; Escreve o cenario de jogo na janela de texto
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo na Janela de Texto
;;
WriteScenario:	PUSH	R1		; Endereco da String
		PUSH	R2		; Cursor da Janela de Texto
		PUSH	R3		; Contador de Linhas
		MOV	R1, Str_GameArea_01
		MOV	R2, R0
		MOV	R3, NUM_LINES
WriteScenarioL:	I2OP	R1, R2
		ADD	R1, NUM_COLS
		ADD	R2, NEXT_LINE
		DEC	R3
		BR.NZ	WriteScenarioL
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ResetRecord
;;
;; Coloca o valor da Pontuacao Recorde a zero e actualiza o LCD.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Coloca M[RecordScore] a zero
;;         Coloca posicoes de memoria relativas a pontuacao a zero (ScoreCounterN)
;;         Escreve o valor do Record no LCD
;;         Escreve o valor da pontuacao no Display de 7 Segmentos
;;
ResetRecord:	MOV	M[RecordScore], R0
		CALL	WriteNewRecord
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ResetScore
;;
;; Coloca o valor da Pontuacao a zero e actualiza o Display de 7 segmentos
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera posicoes de memoria ScoreCounter1, ScoreCounter2, ScoreCounter3,
;;        ScoreCounter4.
;;
ResetScore:	MOV	M[ScoreCounter4], R0
		MOV	M[ScoreCounter3], R0
		MOV	M[ScoreCounter2], R0
		MOV	M[ScoreCounter1], R0
		CALL	WriteScore
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- WriteNewRecord
;;
;; Escreve no LCD a pontuacao actual
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera LCD
;;
WriteNewRecord:	PUSH	R1	; Cursor LCD
		PUSH	R2	; Algarismo LCD
		PUSH	R3	; Endereco LCD_CTRL
		PUSH	R4	; Endereco LCD_WRITE
		MOV	R3, IO_LCD_CTRL
		MOV	R4, IO_LCD_WRITE
		MOV	R1, 8000h	; Linha 0 Coluna 0
		MOV	M[R3], R1	; Algarismo dos milhares
		MOV	R2, M[ScoreCounter4]
		ADD	R2, '0'
		MOV	M[R4], R2
		INC	R1		; Linha 0 Coluna 1
		MOV	M[R3], R1	; Algarismo das Centenas
		MOV	R2, M[ScoreCounter3]
		ADD	R2, '0'
		MOV	M[R4], R2
		INC	R1		; Linha 0 Coluna 2
		MOV	M[R3], R1	; Algarismo das Dezenas
		MOV	R2, M[ScoreCounter2]
		ADD	R2, '0'
		MOV	M[R4], R2
		INC	R1		; Linha 0 Coluna 3
		MOV	M[R3], R1	; Algarismo das Unidades
		MOV	R2, M[ScoreCounter1]
		ADD	R2, '0'
		MOV	M[R4], R2
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- WriteScore
;;
;; Escreve no Display de 7 Segmentos a pontuacao actual
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera Display 7 Segmentos
;;
WriteScore:	PUSH	R1
		MOV	R1, M[ScoreCounter1]	; Unidades
		MOV	M[IO_DISP_SEG1], R1
		MOV	R1, M[ScoreCounter2]	; Dezenas
		MOV	M[IO_DISP_SEG2], R1
		MOV	R1, M[ScoreCounter3]	; Centenas
		MOV	M[IO_DISP_SEG3], R1
		MOV	R1, M[ScoreCounter4]	; Milhares
		MOV	M[IO_DISP_SEG4], R1
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- NewGame
;;
;; Faz as inicializacoes necessarias para iniciar um novo jogo (reset ao jogo anterior)
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera Janela de Texto e posicoes de memoria (ver funcoes ResetUsrTrain, 
;;        ResetAITrain, ResetScore, ResetStations.
;;
NewGame:	CALL	ResetUsrTrain
		CALL	ResetAITrain
		CALL	ResetScore
		CALL	ResetStations
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ResetUsrTrain
;;
;; Coloca o comboio do utilizador na situacao inicial, apagando-o da sua posicao actual.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera Janela de Texto;
;;         Altera posicoes de memoria Dir_Comboio e vector Pos_Comboio
;;
ResetUsrTrain:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		CALL	EraseUsrTrain		; Apagar da Janela de Texto
		MOV	R1, Pos_Comboio		; Mover para posicao inicial
		MOV	R2, USR_TRAIN_LENG
		MOV	R3, POS_USR_LOC
		MOV	R4, POS_USR_DIFF
ResetUsrTrain2:	MOV	M[R1], R3
		INC	R1
		ADD	R3, R4
		DEC	R2
		BR.NZ	ResetUsrTrain2
		MOV	R1, USR_TRAIN_IDIR	; Repor velocidade inicial
		MOV	M[Dir_Comboio], R1
		CALL	WriteUsrTrain		; Escrever na Janela de Texto
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- EraseUsrTrain
;;
;; Apaga o comboio do utilizador da Janela de Texto
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto
;;
EraseUsrTrain:	PUSH	R1
		PUSH	R2
		MOV	R1, Pos_Comboio
		MOV	R2, USR_TRAIN_LENG
EraseUsrTrain1:	PUSH	M[R1]
		CALL	RestorePos
		INC	R1
		DEC	R2
		BR.NZ	EraseUsrTrain1
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- WriteUsrTrain
;;
;; Escreve o comboio do utilizador na Janela de Texto
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto
;;
WriteUsrTrain:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		PUSH	R5
		PUSH	R6
		PUSH	R7
		MOV	R1, Pos_Comboio		; Endereco Posicoes do Comboio
		MOV	R2, USR_TRAIN_LENG	; Comprimento do Comboio
		MOV	R3, IO_TEXT_CTRL	; Endereco IO Porto de Controlo
		MOV	R4, IO_TEXT_WRITE	; Endereco IO Porto de Escrita
		MOV	R5, USR_TRAIN_CAR	; Caracter das Carruagens
		MOV	R6, USR_TRAIN_LOC	; Caracter da Locomotiva
		MOV	R7, M[R1]	; Escrever Locomotiva
		MOV	M[R3], R7
		MOV	M[R4], R6
		INC	R1
		DEC	R2
WriteUsrTrain1:	MOV	R7, M[R1]	; Escrever Carruagens
		MOV	M[R3], R7
		MOV	M[R4], R5
		INC	R1
		DEC	R2
		BR.NZ	WriteUsrTrain1
		POP	R7
		POP	R6
		POP	R5
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ResetAITrain
;;
;; Coloca a automotora fantasma na situacao inicial, apagando-a da sua posicao actual. A
;; velocidade inicial e aleatoria.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto;
;;         Altera posicoes de memoria Dir_Fantasma e vector Pos_Fantasma
;;
ResetAITrain:	PUSH	R1
		CALL	EraseAITrain
		CALL	RandGen			; Decidir direccao inicial
		MOV	R1, M[RandNum]
		TEST	R1, 0001h	; Testar bit de menor peso
		CALL.Z	ResetAITrainL	; Caso seja 0, Automotora comeca para a esquerda
		TEST	R1, 0001h
		CALL.NZ	ResetAITrainR	; Caso seja 1, Automotora comeca para a direita
		CALL	WriteAITrain	; Escrever na Janela de Texto
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ResetAITrainL
;;
;; Rotina Auxiliar a Rotina ResetAITrain
;; Coloca a automotora na situacao inicial, com velocidade inicial para a esquerda.
;;
;; Entrad: Vector Velocidade Inicial
;; Saidas: nenhuma
;; Efeito: Altera posicao de memoria Dir_Fantasma e vector Pos_Fantasma
;;
ResetAITrainL:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		MOV	R1, Pos_Fantasma
		MOV	R2, AI_TRAIN_LENG
		MOV	R3, POS_AI_LOC
		MOV	R4, POS_AI_DIFF
ResetAITrainL1:	MOV	M[R1], R3
		INC	R1
		ADD	R3, R4
		DEC	R2
		BR.NZ	ResetAITrainL1
		MOV	R1, AI_TRAIN_IDIR	; Repor velocidade inicial
		MOV	M[Dir_Fantasma], R1
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ResetAITrainR
;;
;; Rotina Auxiliar a Rotina ResetAITrain.
;; Coloca a automotora na situacao inicial, com velocidade inicial para a direita.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera posicao de memoria Dir_Fantasma e vector Pos_Fantasma
;;
ResetAITrainR:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		MOV	R1, Pos_Fantasma
		MOV	R2, AI_TRAIN_LENG
		MOV	R3, POS_AI_LOC
		MOV	R4, POS_AI_DIFF
		ADD	R1, R2
		DEC	R1
ResetAITrainR1:	MOV	M[R1], R3
		DEC	R1
		ADD	R3, R4
		DEC	R2
		BR.NZ	ResetAITrainR1
		MOV	R1, AI_TRAIN_IDIR	; Repor velocidade inicial
		NEG	R1
		MOV	M[Dir_Fantasma], R1
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- EraseAITrain
;;
;; Apaga a automotora fantasma da Janela de Texto
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto
;;
EraseAITrain:	PUSH	R1
		PUSH	R2
		MOV	R1, Pos_Fantasma
		MOV	R2, AI_TRAIN_LENG
EraseAITrain1:	PUSH	M[R1]
		CALL	RestorePos
		INC	R1
		DEC	R2
		BR.NZ	EraseAITrain1
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- WriteAITrain
;;
;; Escreve a automotora fantasma na Janela de Texto
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto
;;
WriteAITrain:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		PUSH	R5
		PUSH	R6
		PUSH	R7
		MOV	R1, Pos_Fantasma	; Endereco Posicoes da Automotora
		MOV	R2, AI_TRAIN_LENG	; Comprimento da Automotora
		MOV	R3, IO_TEXT_CTRL	; Endereco IO Porto de Controlo
		MOV	R4, IO_TEXT_WRITE	; Endereco IO Porto de Escrita
		MOV	R5, AI_TRAIN_CAR	; Caracter das Carruagens
		MOV	R6, AI_TRAIN_LOC	; Caracter das Locomotivas
		MOV	R7, M[R1]	; Escrever Locomotiva da Frente
		MOV	M[R3], R7
		MOV	M[R4], R6
		INC	R1
		SUB	R2, AI_NUM_LOC	; Subtrair numero de carruagens
WriteAITrain1:	MOV	R7, M[R1]	; Escrever Carruagens
		MOV	M[R3], R7
		MOV	M[R4], R5
		INC	R1
		DEC	R2
		BR.NZ	WriteAITrain1
		MOV	R7, M[R1]	; Escrever Locomotiva Traseira
		MOV	M[R3], R7
		MOV	M[R4], R6
		POP	R7
		POP	R6
		POP	R5
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- RestorePos
;;
;; Reescreve na Janela de Texto o conteudo original da area de jogo da posicao
;; especificada.
;;
;; Entrad: Pilha - Posicao a restaurar (Coordenadas J. Texto)
;; Saidas: nenhuma
;; Efeito: Altera uma posicao da Janela de Texto
;;
RestorePos:	PUSH	R1	; Linha
		PUSH	R2	; Coluna
		PUSH	R3	; Endereco do Caracter
		PUSH	M[SP+5]
		CALL	ConvertPos
		POP	R3
		MOV	R1, M[R3]	; Caracter
		MOV	R2, M[SP+5]	; Posicao a Escrever
		MOV	M[IO_TEXT_CTRL], R2
		MOV	M[IO_TEXT_WRITE], R1
		POP	R3
		POP	R2
		POP	R1
		RETN	1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ReadPos
;;
;; Recebe uma posicao em coordenadas da Janela de Texto e devolve o conteudo do cenario
;; nessa posicao (excluindo comboios)
;;
;; Entrad: Pilha - Posicao a ler
;; Saidas: Pilha - Conteudo da posicao pedida
;; Efeito: Altera Pilha
;;
ReadPos:	PUSH	R1
		PUSH	R2
		PUSH	M[SP+4]
		CALL	ConvertPos
		POP	R2
		MOV	R1, M[R2]
		MOV	M[SP+4], R1
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- IsTrainPos
;;
;; Funcao que recebe uma posicao e devolve TRUE caso esteja algum comboio naquela posicao
;; e devolve FALSE caso contrario
;;
;; Entrad: Pilha - Posicao a verificar
;; Saidas: Pilha - Predicado
;; Efeito: Altera Pilha
;;
IsTrainPos:	PUSH	R1
		PUSH	R2
		MOV	R1, M[SP+4]
		PUSH	R1		; Verificar se coincide Comboio Utilizador
		CALL	IsTrainPosUsr
		POP	R2
		CMP	R2, TRUE
		BR.Z	IsTrainPosEnd
		PUSH	R1
		CALL	IsTrainPosAI
		POP	R2
IsTrainPosEnd:	MOV	M[SP+4], R2
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ConvertPos
;;
;; Funcao que recebe uma posicao em coordenadas da janela de texto, e devolve a posicao
;; de memoria correspondente aquela posicao da Area de Jogo
;;
;; Entrad: Pilha - Posicao em Coord Janela Texto
;; Saidas: Pilha - Posicao da Area de Jogo
;; Efeito: Altera Pilha
;;
ConvertPos:	PUSH	R1		; Coluna
		PUSH	R2		; Linha
		PUSH	R3		; Resultado
		MOV	R1, M[SP+5]
		MVBH	R2, R1		; Obter componente Linha
		SHR	R2, 8
		AND	R1, 00FFh	; Apagar componente Linha do R1
		MOV	R3, NUM_COLS
		MUL	R2, R3
		ADD	R3, R1
		ADD	R3, Str_GameArea_01
		MOV	M[SP+5], R3
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- IsTrainPosUsr
;;
;; Funcao que recebe uma posicao e devolve TRUE caso coincida com uma posicao ocupada
;; pelo comboio do utilizador
;;
;; Entrad: Pilha - Posicao a verificar
;; Saidas: Pilha - Predicado
;; Efeito: Altera Pilha
;;
IsTrainPosUsr:	PUSH	R1
		PUSH	R2
		PUSH	R3
		MOV	R1, Pos_Comboio		; Verificar Posicao a Posicao
		MOV	R2, USR_TRAIN_LENG
IsTrainPosUsr1:	MOV	R3, M[R1]
		CMP	R3, M[SP+5]
		BR.Z	IsTrainPosUsrT		; Caso coincida, TRUE
		INC	R1
		DEC	R2
		BR.NZ	IsTrainPosUsr1
		BR	IsTrainPosUsrF		; Caso nenhuma coincida, FALSE
IsTrainPosUsrT:	MOV	R3, TRUE
		BR.Z	IsTrainPosUsrE
IsTrainPosUsrF:	MOV	R3, FALSE
IsTrainPosUsrE:	MOV	M[SP+5], R3
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- IsTrainPosAI
;;
;; Funcao que recebe uma posicao e devolve TRUE caso coincida com uma posicao ocupada
;; pela automotora fantasma
;;
;; Entrad: Pilha - Posicao a verificar
;; Saidas: Pilha - Predicado
;; Efeito: Altera Pilha
;;
IsTrainPosAI:	PUSH	R1
		PUSH	R2
		PUSH	R3
		MOV	R1, Pos_Fantasma
		MOV	R2, AI_TRAIN_LENG
IsTrainPosAI1:	MOV	R3, M[R1]
		CMP	R3, M[SP+5]
		BR.Z	IsTrainPosAIT
		INC	R1
		DEC	R2
		BR.NZ	IsTrainPosAI1
		BR	IsTrainPosAIF
IsTrainPosAIT:	MOV	R3, TRUE
		BR.Z	IsTrainPosAIE
IsTrainPosAIF:	MOV	R3, FALSE
IsTrainPosAIE:	MOV	M[SP+5], R3
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- IsNeedlePos
;;
;; Funcao que recebe uma posicao e devolve TRUE caso coincida com uma posicao ocupada por
;; uma agulha
;;
;; Entrad: Pilha - Posicao a verificar
;; Saidas: Pilha - Predicado
;; Efeito: Altera Pilha
;;
IsNeedlePos:	PUSH	R1
		PUSH	R2
		PUSH	R3
		MOV	R1, Pos_Needle0
		MOV	R2, NUM_NEEDLES
IsNeedlePos1:	MOV	R3, M[R1]
		CMP	R3, M[SP+5]
		BR.Z	IsNeedlePosT
		INC	R1
		DEC	R2
		BR.NZ	IsNeedlePos1
		BR	IsNeedlePosF
IsNeedlePosT:	MOV	R3, TRUE
		BR.Z	IsNeedlePosEnd
IsNeedlePosF:	MOV	R3, FALSE
IsNeedlePosEnd:	MOV	M[SP+5], R3
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- MidGame
;;
;; Rotina que fica em loop enquanto o jogo nao terminar. E responsavel por chamar outras
;; sub-rotinas, as quais sao responsaveis pelo movimento dos comboios, deteccao de
;; colisoes, etc.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera Janela de Texto, Display 7 Segmentos, LEDs, Posicoes de Memoria
;;

MidGame:	CMP	M[Test_Temp], R0
		BR.Z	MidGame
		MOV	M[Test_Temp], R0
		CALL	RefreshNeedle	; Actualizar Agulhas
		CALL	MoveAITrain	; Mover Automotora Fantasma
		CALL	MoveUsrTrain	; Mover Comboio do Utilizador
		CALL	RefreshLeds	; Actualizar Dificuldade de Jogo
		CALL	GenPassenger	; Gerar Novo Passageiro
		CALL	CheckPassUsr	; Verificar Passagens do Comboio Utilizador
		CALL	CheckPassAI	; e Automotora Fantasma nas Estacoes
		CALL	RefreshScore	; Actualizar pontuacao
		CMP	M[GameOver], R0	; Verificar Fim de Jogo
		BR.Z	MidGame
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- NextNeedleCar
;;
;; Rotina que recebe a posicao actual de uma agulha e devolve a posicao seguinte.
;;
;; Entrad: Pilha - Posicao Actual
;; Saidas: Pilha - Posicao Seguinte
;; Efeito: Altera Pilha
;;
NextNeedleCar:	PUSH	R1
		MOV	R1, M[SP+3]
NextNeedleCar1:	CMP	R1, NEEDLE_CAR_V	; | -> /
		BR.NZ	NextNeedleCar2
		MOV	R1, NEEDLE_CAR_R
		BR	NextNeedleCarF
NextNeedleCar2:	CMP	R1, NEEDLE_CAR_R	; / -> -
		BR.NZ	NextNeedleCar3
		MOV	R1, NEEDLE_CAR_H
		BR	NextNeedleCarF
NextNeedleCar3:	CMP	R1, NEEDLE_CAR_H	; - -> \
		BR.NZ	NextNeedleCar4
		MOV	R1, NEEDLE_CAR_L
		BR	NextNeedleCarF
NextNeedleCar4:	MOV	R1, NEEDLE_CAR_V	; \ -> |
NextNeedleCarF:	MOV	M[SP+3], R1
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- SwitchNeedle
;;
;; Rotina que recebe uma posicao de uma agulha em coordenadas da janela de texto e
;; muda-a para a sua permutacao seguinte.
;;
;; Entrad: Pilha - Posicao da Agulha a Mudar
;; Saidas: nenhuma
;; Efeito: Altera uma posicao da Janela de Texto
;;         Altera conteudo de um endereco de memoria
;;
SwitchNeedle:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	M[SP+5]
		CALL	ConvertPos
		POP	R1
		MOV	R2, M[R1]
		PUSH	R2
		CALL	NextNeedleCar
		POP	R2
		MOV	M[R1], R2
		PUSH	M[SP+5]	; Posicao
		CALL	IsTrainPos
		POP	R2	; Predicado
		CMP	R2, TRUE
		BR.Z	SwitchNeedleE
		PUSH	M[SP+5]
		CALL	RestorePos
SwitchNeedleE:	POP	R3
		POP	R2
		POP	R1
		RETN	1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- RefreshNeedle
;;
;; Rotina que efectua a mudanca das agulhas para o seu proximo estado
;; 
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera Janela de Texto
;;         Altera vector NeedleChanged e String com a area de jogo
;;
RefreshNeedle:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		MOV	R1, NeedleChanged0
		MOV	R2, Pos_Needle0
		MOV	R3, NUM_NEEDLES
		MOV	R4, NEEDLE_STATES
RefreshNeedle1:	CMP	M[R1], R0		; Verificar se nao e preciso mudar
		BR.Z	RefreshNeedleN
RefreshNeedle2:	CMP	M[R1], R4		; Verificar se troca 4 ou mais vezes
		BR.N	RefreshNeedle3		; Caso troque, simplesmente subtrair 4
		SUB	M[R1], R4
		BR	RefreshNeedle2
RefreshNeedle3:	PUSH	M[R2]
		CALL	SwitchNeedle		; Efectuar a mudanca da agulha
		DEC	M[R1]
		BR	RefreshNeedle1
RefreshNeedleN:	INC	R1
		INC	R2
		DEC	R3			; Verificar se ja percorreu todas
		BR.NZ	RefreshNeedle1
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- MoveUsrTrain
;;
;; Responsavel por deslocar o comboio do utilizador
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto
;;         Altera posicao 3 do vector ScoreCounter
;;         Altera posicoes de memoria relativos a String com a Area de Jogo
;;         Altera vector Pos_Comboio e posicao Dir_Comboio
;;         Altera posicao GameOver
;;
MoveUsrTrain:	CALL	EraseUsrLast	; Apagar ultima carruagem
		CALL	RefreshUsrPos	; Mover comboio para novas posicoes
		CALL	WriteUsrFirst	; Escrever locomotiva no novo sitio
		CALL	CheckUsrLine	; Verificar se muda direccao do movimento
		CALL	CheckCollision	; Verifica colisao
		CALL	CheckUsrOut	; Verifica descarrilamento
		CALL	CheckUsrCross	; Verifica se passou por uma interseccao valida
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- CheckUsrCross
;;
;; Verifica se o utilizador passou por um troco de linha valida, mas nao compativel com a
;; velocidade do comboio. Exemplo: Passar por um troco '|' enquanto com velocidade
;; horizontal.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera valor da posicao de memoria GameOver
;;
CheckUsrCross:	PUSH	R1
		PUSH	R2
		PUSH	R3
		MOV	R1, M[Pos_Comboio]
		PUSH	R1
		CALL	ReadPos			; Obter troco de linha a ser pisada
		POP	R1
		MOV	R2, M[Dir_Comboio]	; Velocidade do comboio
CheckUsrCrossV:	CMP	R1, NEEDLE_CAR_V	; Tipo '|'
		BR.NZ	CheckUsrCrossH
		AND	R2, FF00h		; Obter componente vertical
		BR.NZ	CheckUsrCrossE		; Se for diferente de zero, nao fazer nada
		INC	M[GameOver]		; Senao, descarrilar!
CheckUsrCrossH:	CMP	R1, NEEDLE_CAR_H	; Tipo '-'
		BR.NZ	CheckUsrCrossE
		AND	R2, 00FFh		; Obter componente horizontal
		BR.NZ	CheckUsrCrossE		; Se for diferente de zero, nao fazer nada
		INC	M[GameOver]		; Senao, descarrilar!
CheckUsrCrossE:	POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- CheckUsrOut
;;
;; Verifica se o comboio do utilizador vai descarrilar. Em caso afirmativo, coloca o valor
;; da posicao de memoria GameOver a TRUE
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera valor da posicao de memoria GameOver
;;
CheckUsrOut:	PUSH	R1
		PUSH	R2
		PUSH	M[Pos_Comboio]
		CALL	ReadPos
		CALL	ValidLine
		POP	R1
		CMP	R1, FALSE
		BR.NZ	CheckUsrOutEnd	; Caso nao descarrile, sair
		INC	M[GameOver]	; Caso descarrile, fim de jogo
CheckUsrOutEnd:	POP	R2
		POP	R1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- CheckCollision
;;
;; Verifica se houve colisao do comboio do jogador com a locomotiva fantasma
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera valor da posicao de memoria GameOver
;;
CheckCollision:	PUSH	R1
		MOV	R1, M[Pos_Comboio]	; Verificar se Comboio do Utilizador
		PUSH	R1			; Colidiu com Automotora Fantasma
		CALL	IsTrainPosAI
		POP	R1
		CMP	R1, TRUE
		BR.Z	CheckCollisioT
		MOV	R1, M[Pos_Fantasma]	; Verificar se Automotora Fantasma
		PUSH	R1			; Colidiu com Comboio do Utilizador
		CALL	IsTrainPosUsr
		POP	R1
		CMP	R1, FALSE
		BR.Z	CheckCollisEnd
CheckCollisioT:	INC	M[GameOver]
CheckCollisEnd:	POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- EraseUsrLast
;;
;; Apaga a ultima carruagem do comboio do utilizador da janela de texto
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera uma posicao da Janela de Texto
;;
EraseUsrLast:	PUSH	R1
		MOV	R1, Pos_Comboio
		ADD	R1, USR_TRAIN_LENG
		DEC	R1
		PUSH	M[R1]
		CALL	RestorePos
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- RefreshUsrPos
;;
;; Actualiza as posicoes de todas as carruagens do comboio do utilizador
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo do vecto Pos_Comboio
;;
RefreshUsrPos:	PUSH	R1
		PUSH	R2
		PUSH	R3
		MOV	R1, Pos_Comboio	; Ponteiro para o vector
		MOV	R2, USR_TRAIN_LENG
		DEC	R2		; So faz n-1 trocas, n e o comprimento do comboio
		ADD	R1, R2
		DEC	R1		; Apontar para penultima posicao
RefreshUsrPos1:	MOV	R3, M[R1]
		MOV	M[R1+1], R3	; Trocar posicao N com N+1
		DEC	R1
		DEC	R2
		BR.NZ	RefreshUsrPos1
		MOV	R1, M[Pos_Comboio]	; Modificar Posicao da Locomotiva
		ADD	R1, M[Dir_Comboio]	; (Somar vector velocidade)
		MOV	M[Pos_Comboio], R1
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- WriteUsrFirst
;;
;; Escreve na Janela de Texto a locomotiva (e substitui a antiga locomotiva por uma
;; carruagem normal.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto
;;
WriteUsrFirst:	PUSH	R1
		PUSH	R2
		PUSH	R3
		MOV	R1, Pos_Comboio
		MOV	R2, M[R1]
		MOV	R3, USR_TRAIN_LOC
		MOV	M[IO_TEXT_CTRL], R2	; Escrever Locomotiva
		MOV	M[IO_TEXT_WRITE], R3
		MOV	R2, M[R1+1]
		MOV	R3, USR_TRAIN_CAR
		MOV	M[IO_TEXT_CTRL], R2	; Substituir Loc. antiga por carruagem
		MOV	M[IO_TEXT_WRITE], R3
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- NeedleCurveL
;;
;; Recebe um vector velocidade e aplica-lhe uma transformacao de forma a dar o vector
;; velocidade depois de passar por uma curva do caracter NEEDLE_CAR_L
;;
;; Entrad: Pilha - Vector Velocidade Actual
;; Saidas: Pilha - Vector Velocidade Alterado
;; Efeito: Altera conteudo da Pilha
;;
NeedleCurveL:	PUSH	R1
		MOV	R1, M[SP+3]
		TEST	R1, 8000h	; Testar bit mais significativo
		BR.Z	NeedleCurveLP
		NEG	R1		; Caso seja 1, Complementar
		ROR	R1, 8		; Trocar componentes
		NEG	R1		; e Complementar de novo
		BR	NeedleCurveLF
NeedleCurveLP:	ROR	R1, 8		; Caso seja 0, apenas trocar componentes
NeedleCurveLF:	MOV	M[SP+3], R1
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- NeedleCurveR
;;
;; Recebe um vector velocidade e aplica-lhe uma transformacao de forma a dar o vector
;; velocidade depois de passar por uma curva do caracter NEEDLE_CAR_R
;;
;; Entrad: Pilha - Vector Velocidade Actual
;; Saidas: Pilha - Vector Velocidade Alterado
;; Efeito: Altera conteudo da Pilha
;;
NeedleCurveR:	PUSH	R1
		MOV	R1, M[SP+3]
		TEST	R1, 8000h	; Testar bit mais significativo
		BR.Z	NeedleCurveR1
		NEG	R1		; Caso seja 1, complementar
		ROR	R1, 8		; e trocar as componentes
		BR	NeedleCurveRF
NeedleCurveR1:	ROR	R1, 8		; Caso seja 0, trocar componentes
		NEG	R1
NeedleCurveRF:	MOV	M[SP+3], R1
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- CheckUsrLine
;;
;; Verifica a linha a ser pisada pela locomotiva. Caso seja uma curva, muda o sentido.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera posicao de memoria Pos_Comboio
;;
CheckUsrLine:	PUSH	R1
		PUSH	M[Pos_Comboio]
		CALL	ReadPos		; Ler caracter por baixo da locomotiva
		POP	R1
		PUSH	M[Dir_Comboio]
		CMP	R1, NEEDLE_CAR_L	; Curva a esquerda
		CALL.Z	NeedleCurveL
		CMP	R1, NEEDLE_CAR_R	; Curva a direita
		CALL.Z	NeedleCurveR
		POP	M[Dir_Comboio]		; Guardar nova velocidade (se alterada)
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- MoveAITrain
;;
;; Responsavel por deslocar a automotora fantasma
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto
;;         Altera vector Pos_Fantasma e posicao de memoria Dir_Fantasma
;;
MoveAITrain:	CALL	EraseAILast	; Apagar ultima carruagem
		CALL	CheckAILine	; Verificar se esta numa agulha
		CALL	RefreshAIPos	; Mover automotora para novas posicoes
		CALL	CheckAINextP	; Verificar se automotora vai descarrilar
		CALL	WriteAIFirst	; Escrever locomotiva no novo sitio
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- CheckAINextP
;;
;; Verifica se a Automotora vai descarrilar. Em caso afirmativo, inverte o sentido do
;; movimento
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo do vector Pos_Fantasma e posicao de memoria Dir_Fantasma
;;
CheckAINextP:	PUSH	R1
		PUSH	M[Pos_Fantasma]
		CALL	ReadPos
		CALL	ValidLine
		POP	R1
		CMP	R1, TRUE
		BR.Z	CheckAINextEnd
		PUSH	M[Pos_Fantasma]
		CALL	ReadPos
		POP	R1
		CMP	R1, NEEDLE_CAR_L
		BR.Z	CheckAINextEnd
		CMP	R1, NEEDLE_CAR_R
		BR.Z	CheckAINextEnd
		CALL	InvertAIDir
		CALL	RefreshAIPos
CheckAINextEnd:	POP	R7
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- InvertAIDir
;;
;; Inverte o sentido do movimento da automotora fantasma
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo do vector Pos_Fantasma e posicao de memoria Dir_Fantasma
;;
InvertAIDir:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		PUSH	R5
		PUSH	R6
		PUSH	R7
		MOV	R1, Pos_Fantasma
		MOV	R2, M[R1+5]
		MOV	R3, M[R1+4]
		SUB	R2, R3
		MOV	M[Dir_Fantasma], R2	; Inverter velocidade
		MOV	R7, Pos_Fantasma	; Trocar posicoes
		MOV	R1, M[R7]
		MOV	R2, M[R7+1]
		MOV	R3, M[R7+2]
		MOV	R4, M[R7+3]
		MOV	R5, M[R7+4]
		MOV	R6, M[R7+5]
		MOV	M[R7], R6
		MOV	M[R7+1], R5
		MOV	M[R7+2], R4
		MOV	M[R7+3], R3
		MOV	M[R7+4], R2
		MOV	M[R7+5], R1
		POP	R7
		POP	R6
		POP	R5
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ValidLine
;;
;; Recebe um caracter e devolve TRUE caso seja um troco de linha, FALSE caso contrario
;;
;; Entrad: Pilha - Caracter a verificar
;; Saidas: Pilha - Predicado
;; Efeito: Altera conteudo da Pilha
;;
ValidLine:	PUSH	R1
		PUSH	R2
		MOV	R1, M[SP+4]
		MOV	R2, TRUE
ValidLine1:	CMP	R1, NEEDLE_CAR_L	; Curva a esq?
		BR.NZ	ValidLine2
		MOV	M[SP+4], R2
		JMP	ValidLineEnd
ValidLine2:	CMP	R1, NEEDLE_CAR_R	; Curva a dir?
		BR.NZ	ValidLine3
		MOV	M[SP+4], R2
		BR	ValidLineEnd
ValidLine3:	CMP	R1, NEEDLE_CAR_V	; Linha vertical?
		BR.NZ	ValidLine4
		MOV	M[SP+4], R2
		BR	ValidLineEnd
ValidLine4:	CMP	R1, NEEDLE_CAR_H	; Linha horizontal?
		BR.NZ	ValidLineS
		MOV	M[SP+4], R2
		BR	ValidLineEnd
ValidLineS:	CMP	R1, STATION_CAR		; Estacao?
		BR.NZ	ValidLineP
		MOV	M[SP+4], R2
		BR	ValidLineEnd
ValidLineP:	CMP	R1, STATION_PASSENG	; Passageiro?
		BR.NZ	ValidLineFalse
		MOV	M[SP+4], R2
		BR	ValidLineEnd
ValidLineFalse:	MOV	M[SP+4], R0		; R0 = False
ValidLineEnd:	POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- EraseAILast
;;
;; Apaga a ultima carruagem da automotora fantasma, e coloca na penultima carruagem o
;; caracter da locomotiva traseira
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto
;;
EraseAILast:	PUSH	R1
		PUSH	R2
		MOV	R1, Pos_Fantasma
		ADD	R1, USR_TRAIN_LENG
		DEC	R1
		PUSH	M[R1]
		CALL	RestorePos
		DEC	R1
		MOV	R2, M[R1]
		MOV	R1, AI_TRAIN_LOC
		MOV	M[IO_TEXT_CTRL], R2
		MOV	M[IO_TEXT_WRITE], R1
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- RefreshAIPos
;;
;; Actualiza as posicoes de todas as carruagens da automotora fantasma
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo do vector Pos_Fantasma
RefreshAIPos:	PUSH	R1
		PUSH	R2
		PUSH	R3
		MOV	R1, Pos_Fantasma
		MOV	R2, AI_TRAIN_LENG
		DEC	R2
		ADD	R1, R2
		DEC	R1
RefreshAIPos1:	MOV	R3, M[R1]
		MOV	M[R1+1], R3
		DEC	R1
		DEC	R2
		BR.NZ	RefreshAIPos1
		MOV	R1, M[Pos_Fantasma]
		ADD	R1, M[Dir_Fantasma]
		MOV	M[Pos_Fantasma], R1
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- WriteAIFirst
;;
;; Escreve na Janela de Texto a locomotiva da frente (e substitui a locomotiva antiga por
;; uma carruagem normal.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto
;;
WriteAIFirst:	PUSH	R1
		PUSH	R2
		PUSH	R3
		MOV	R1, Pos_Fantasma
		MOV	R2, M[R1]
		MOV	R3, AI_TRAIN_LOC
		MOV	M[IO_TEXT_CTRL], R2	; Escreve nova locomotiva
		MOV	M[IO_TEXT_WRITE], R3
		MOV	R2, M[R1+1]
		MOV	R3, AI_TRAIN_CAR
		MOV	M[IO_TEXT_CTRL], R2	; Substitui antiga locomotiva por
		MOV	M[IO_TEXT_WRITE], R3	; uma carruagem
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- CheckAILine
;;
;; Verifica a linha a ser pisada pela locomotiva. Caso seja uma curva, muda o sentido.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da posicao de memoria Dir_Fantasma
;;
CheckAILine:	PUSH	R1
		PUSH	M[Pos_Fantasma]		;
		CALL	ReadPos			; Ler posicao
		POP	R1			;
CheckAILineL:	CMP	R1, NEEDLE_CAR_L
		BR.NZ	CheckAILineR
		PUSH	M[Dir_Fantasma]
		CALL	NeedleCurveL		; Curva a esquerda
		CALL	CheckAICurve
		POP	M[Dir_Fantasma]
CheckAILineR:	CMP	R1, NEEDLE_CAR_R
		BR.NZ	CheckAILineEnd
		PUSH	M[Dir_Fantasma]
		CALL	NeedleCurveR		; Curva a direita
		CALL	CheckAICurve
		POP	M[Dir_Fantasma]
CheckAILineEnd:	POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- CheckAICurve
;;
;; Verifica se a automotora vai seguir um caminho valido depois de trocar de direccao
;; numa agulha. Esta funcao e recursiva. Ira chamar-se a ela propria enquanto a direccao
;; nao for valida.
;;
;; Entrad: Pilha - vector velocidade
;; Saidas: Pilha - vector velocidade sem descarrilar
;; Efeito: Altera conteudo da Pilha
;;
CheckAICurve:	PUSH	R1
		MOV	R1, M[Pos_Fantasma]	; Velocidade depois da curva
		ADD	R1, M[SP+3]
		PUSH	R1
		CALL	ReadPos		; Ler caracter daquela posicao
		CALL	ValidLine	; Verificar se e valida
		POP	R1		; Predicado se aquela posicao e valida
		CMP	R1, TRUE	; Caso seja, nao fazer nada
		BR.Z	CheckAICurveOK
		PUSH	M[Dir_Fantasma]	; Se chegou aqui, e porque vai descarrilar!
		CALL	RandomCurve	; Gerar uma direccao aleatoriamente
		CALL	CheckAICurve	; e verificar se esta e valida
		POP	M[SP+4]
CheckAICurveOK:	POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- RandomCurve
;;
;; Rotina que recebe um vector velocidade e devolve um outro vector velocidade,
;; correspondente a uma mudanca de direccao a esquerda, a direita, ou nenhuma. Este
;; vector e escolhido pseudo-aleatoriamente
;;
;; Entrad: Pilha - vector velocidade actual
;; Saidas: Pilha - vector velocidade aleatorio
;; Efeito: Altera conteudo da Pilha
;;
RandomCurve:	PUSH	R1
		PUSH	R2
		PUSH	M[SP+4]		; Colocar ja o vector na pilha p enviar as funcoes
		CALL	RandGen
		MOV	R1, M[RandNum]
		MOV	R2, 3		; Numero de opcoes a seguir
		DIV	R1, R2		; R2 = {0, 1, 2}
		CMP	R2, R0		; 0 = Inverter Direccao (pois ja foi invertida)
		BR.NZ	RandomCurveL
		BR	RandomCurveEnd
RandomCurveL:	CMP	R2, 1		; 1 = Curva do tipo \
		BR.NZ	RandomCurveR
		CALL	NeedleCurveL
		BR	RandomCurveEnd
RandomCurveR:	CALL	NeedleCurveR	; 2 = Curva do tipo /
RandomCurveEnd:	POP	M[SP+5]
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- RefreshScore
;;
;; Soma um ponto (a funcao e chamada em cada ciclo de jogo), actualiza os contadores de
;; pontuacao e escreve a nova pontuacao no Display de 7 Segmentos. Impoe um limite de
;; 9999 pontos, visto apenas ter 4 digitos para guardar o resultado.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo do Display de 7 Segmentos
;;         Altera vector ScoreCounter
;;
RefreshScore:	PUSH	R1
		INC	M[ScoreCounter1]	; Somar um ponto
		MOV	R1, DIGIT_OVERFLOW
RefreshScore1:	CMP	M[ScoreCounter1], R1	; Verificar Unidades
		BR.N	RefreshScore2
		INC	M[ScoreCounter2]
		SUB	M[ScoreCounter1], R1
RefreshScore2:	CMP	M[ScoreCounter2], R1	; Verificar Dezenas
		BR.N	RefreshScore3
		INC	M[ScoreCounter3]
		SUB	M[ScoreCounter2], R1
RefreshScore3:	CMP	M[ScoreCounter3], R1
		BR.N	RefreshScore4
		INC	M[ScoreCounter4]
		SUB	M[ScoreCounter3], R1
RefreshScore4:	CMP	M[ScoreCounter4], R1
		BR.N	RefreshScoreE
		MOV	R1, 9			; Limitar a 9999 pontos
		MOV	M[ScoreCounter1], R1
		MOV	M[ScoreCounter2], R1
		MOV	M[ScoreCounter3], R1
		MOV	M[ScoreCounter4], R1
RefreshScoreE:	CALL	WriteScore
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- RefreshLeds
;;
;; Actualiza os LEDs de acordo com a dificuldade actual de jogo
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera LEDs acesos
;;
RefreshLeds:	PUSH	R1
		PUSH	R2
		MOV	R1, M[IO_SWITCHES]
		MOV	R2, R0
RefreshLeds1:	CMP	R1, R0
		BR.Z	RefreshLedsEnd
		SHL	R2, 1
		INC	R2
		DEC	R1
		BR	RefreshLeds1
RefreshLedsEnd:	MOV	M[IO_LEDS], R2
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- GenPassenger
;;
;; Rotina que verifica se e altura de gerar um novo passageiro. Em caso afirmativo, ela
;; insere o passageiro na String e na Janela de Texto. Caso a estacao escolhida esteja
;; cheia, o processo de insercao e abortado. Caso o passageiro seja inserido numa posicao
;; ocupada pela locomotiva fantasma, o processo e abortado. Caso o passageiro seja
;; inserido numa posicao ocupada pelo comboio do utilizador, simplesmente soma 100 pontos.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto
;;         Altera conteudo do vector de Strings com a Area de Jogo
;;         Altera vector ScoreCounter e Display de 7 Segmentos
;;
GenPassenger:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		DEC	M[PassengerCheck]	; Verificar se e para Inserir
		JMP.NZ	GenPassengerF		; Em caso negativo, nao fazer nada
		MOV	R1, PASSENGER_FREQ	; Reset contador de ciclos
		MOV	M[PassengerCheck], R1
		CALL	RandGen			; Gerar Numero Aleatorio
		MOV	R2, M[RandNum]
		MOV	R1, NUM_STATIONS
		DIV	R2, R1			; R1 = Numero da estacao (aleatorio)
		MOV	R2, M[R1+Station_Pos]	; Posicao da Estacao (Janela Texto)
		MOV	R3, M[R1+Station_Size]	; Tamanho da Estacao
GenPassenger1:	PUSH	R2
		CALL	ReadPos			; Ler aquela posicao da String
		POP	R4
		CMP	R4, STATION_CAR		; Verificar se estacao esta livre
		BR.Z	GenPassengerOK		; Se estiver livre, inserir passageiro
		INC	R2
		DEC	R3
		BR.NZ	GenPassenger1		; Verificar se prox posicao esta livre
		BR.Z	GenPassengerF		; Estacao cheia, abortar
GenPassengerOK:	PUSH	R2
		CALL	InsPassenger
GenPassengerF:	POP	R4
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- InsPassenger
;;
;; Funcao que recebe uma posicao da Janela de Texto e insere nessa posicao um passageiro.
;; Esta funcao evita que se escreva o passageiro por cima dos comboios.
;;
;; Entrad: Pilha - Posicao Janela de Texto
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto
;;         Altera conteudo do vector de Strings da Area de Jogo
;;
InsPassenger:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		PUSH	R5
		MOV	R1, M[SP+7]		; Posicao onde inserir passageiro
InsPassengerUs:	PUSH	R1
		CALL	IsTrainPosUsr		; Verificar se esta la comboio utilizador
		POP	R2
		CMP	R2, R0			; False?
		BR.Z	InsPassengerAI		; Caso seja falso, passar a frente
		INC	M[ScoreCounter3]	; Caso seja verdade, aumentar 100 pontos
		BR	InsPassengerF		; e nao inserir passageiro
InsPassengerAI:	PUSH	R1
		CALL	IsTrainPosAI		; Verificar se esta la locomotiva fantasma
		POP	R2
		CMP	R2, R0			; False?
		BR.NZ	InsPassengerF		; Caso seja verdade, nao fazer nada!
InsPassengerOK:	PUSH	R1			; Se chegou ate aqui, e porque esta livre
		CALL	ConvertPos		; Obter endereco na String onde colocar
		POP	R2
		MOV	R3, STATION_PASSENG
		MOV	M[R2], R3		; Escrever Passageiro na String
		PUSH	R1
		CALL	RestorePos		; Escrever Passageiro na Janela de Texto
InsPassengerF:	POP	R5
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		RETN	1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- CheckPassUsr
;;
;; Rotina que verifica a passagem do comboio do utilizador pelas estacoes, recolhendo 
;; passageiros
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera posicao 3 do vector ScoreCounter
;;         Altera vector de Strings da Area de Jogo
;;
CheckPassUsr:	PUSH	R1
		PUSH	R2
		MOV	R1, M[Pos_Comboio]	; Posicao da locomotiva
		PUSH	R1
		CALL	ReadPos
		POP	R2			; Caracter por baixo da locomotiva
		CMP	R2, STATION_PASSENG	; Verificar se e um passageiro
		BR.NZ	CheckPassUsrE		; Caso nao seja, nao fazer nada
		PUSH	R1
		CALL	ConvertPos
		POP	R2			; Obter posicao da String
		MOV	R1, STATION_CAR
		MOV	M[R2], R1		; Apagar passageiro na String
		INC	M[ScoreCounter3]	; Adicionar 100 pontos
CheckPassUsrE:	POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- CheckPassAI
;;
;; Rotina que verifica a passagem da locomotiva fantasma pelas estacoes, recolhendo
;; passageiros.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera vector de Strings da Area de Jogo
;;
CheckPassAI:	PUSH	R1
		PUSH	R2
		MOV	R1, M[Pos_Fantasma]	; Posicao da automotora
		PUSH	R1
		CALL	ReadPos
		POP	R2			; Caracter por baixo da automotora
		CMP	R2, STATION_PASSENG	; Verificar se e um passageiro
		BR.NZ	CheckPassAIE		; Caso seja, nao fazer nada
		PUSH	R1
		CALL	ConvertPos
		POP	R2			; Obter posicao da String
		MOV	R1, STATION_CAR
		MOV	M[R2], R1		; Apagar passageiro da String
CheckPassAIE:	POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- ResetStations
;;
;; Remove todos os passageiros das estacoes e reescreve-as na Janela de Texto e na String.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto
;;         Altera vector de Strings da Area de Jogo
;;         Altera conteudo da posicao de memoria PassengerCheck
;;
ResetStations:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		PUSH	R5
		MOV	R1, R0	; Numero da Estacao
		MOV	R2, STATION_CAR
ResetStations1:	MOV	R3, M[R1+Station_Pos]	; Posicao da Estacao (Janela de Texto)
		MOV	R4, M[R1+Station_Size]	; Tamanho da Estacao
		PUSH	R3
		CALL	ConvertPos		; Posicao da Estacao (End. String)
		POP	R5
ResetStations2:	MOV	M[R5], R2		; Escrever na String
		PUSH	R3
		CALL	RestorePos		; Escrever na Janela de Texto
		INC	R3
		INC	R5
		DEC	R4
		BR.NZ	ResetStations2		; Verifica se ja escreveu a estacao toda
		INC	R1
		CMP	R1, NUM_STATIONS
		JMP.NZ	ResetStations1
		MOV	R1, PASSENGER_FREQ
		MOV	M[PassengerCheck], R1
		POP	R5
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- EndGame
;;
;; Chama as rotinas necessarias de forma a finalizar o jogo.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto, LCD, Display 7 Segmentos
;;         Altera vector de Strings da Area de Jogo
;;         Altera posicoes de memoria relativas a pontuacao, comboios, estacoes.
;;         Altera posicao de memoria GameOver
;;
EndGame:	MOV	M[GameOver], R0
		CALL	CheckNewRecord
		CALL	WriteEndMsg
		MOV	R0, M[IO_TEXT_READ]
EndGameWait:	CMP	M[IO_TEXT_STATUS], R0
		BR.Z	EndGameWait
		MOV	R1, M[IO_TEXT_READ]
		CMP	R1, NEW_GAME_KEY
		BR.NZ	EndGameWait
		CALL	DeleteEndMsg
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- CheckNewRecord
;;
;; Verifica se a pontuacao actual e superior a pontuacao recorde. Caso seja, escreve um
;; novo recorde.
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo do LCD.
;;         Altera posicao de memoria RecordScore
;;
CheckNewRecord:	PUSH	R1
		PUSH	R2
		MOV	R1, M[ScoreCounter1]
		MOV	R2, M[ScoreCounter2]
		SHL	R2, 4
		ADD	R1, R2
		MOV	R2, M[ScoreCounter3]
		SHL	R2, 8
		ADD	R1, R2
		MOV	R2, M[ScoreCounter4]
		SHL	R2, 12
		ADD	R1, R2
		CMP	R1, M[RecordScore]
		BR.NP	CheckNewRecEnd
		MOV	M[RecordScore], R1
		CALL	WriteNewRecord
CheckNewRecEnd:	POP	R2
		POP	R1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- WriteEndMsg
;;
;; Escreve no ecra a mensagem de fim de jogo, ao lado da area de jogo
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto
;;
WriteEndMsg:	PUSH	R1
		PUSH	R2
		MOV	R1, Str_NewGame_1	; Endereco da String 1
		MOV	R2, END_GAME_POS	; Posicao onde escrever String 1
		PUSH	R1			;;;;;;;;;;;;;;;;;;;;;;;
		PUSH	R2			;; Escrever String 1 ;;
		CALL	WriteStr		;;;;;;;;;;;;;;;;;;;;;;;
		MOV	R1, Str_NewGame_2	; Endereco da String 2
		ADD	R2, NEXT_LINE		; Posicao onde escrever String 2
		PUSH	R1			;;;;;;;;;;;;;;;;;;;;;;;
		PUSH	R2			;; Escrever String 2 ;;
		CALL	WriteStr		;;;;;;;;;;;;;;;;;;;;;;;
		MOV	R1, Str_NewGame_3	; Endereco da String 3
		ADD	R2, NEXT_LINE		; Posicao onde escrever String 3
		PUSH	R1			;;;;;;;;;;;;;;;;;;;;;;;
		PUSH	R2			;; Escrever String 3 ;;
		CALL	WriteStr		;;;;;;;;;;;;;;;;;;;;;;;
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- DeleteEndMsg
;;
;; Apaga da Janela de Texto a mensagem de fim de jogo
;;
;; Entrad: nenhuma
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Janela de Texto
;;
DeleteEndMsg:	PUSH	R1
		PUSH	R2
		MOV	R1, Str_NewGame_1	; Endereco da String 1
		MOV	R2, END_GAME_POS	; Posicao onde apagar String 1
		PUSH	R1
		PUSH	R2
		CALL	EraseStr		; Apagar String 3
		MOV	R1, Str_NewGame_2	; Endereco da String 2
		ADD	R2, NEXT_LINE		; Posicao onde apagar String 2
		PUSH	R1
		PUSH	R2
		CALL	EraseStr		; Apagar String 3
		MOV	R1, Str_NewGame_3	; Endereco da String 3
		ADD	R2, NEXT_LINE		; Posicao onde apagar String 3
		PUSH	R1
		PUSH	R2
		CALL	EraseStr		; Apagar String 3
		POP	R2
		POP	R1
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- WriteStr
;;
;; Funcao que escreve na Janela de Texto uma String. Recebe como argumento o endereco de
;; memoria do inicio da String e a posicao da Janela de Texto onde comeca a escrever.
;;
;; Entrad: Pilha - Endereco da String (Primeiro Argumento)
;;         Pilha - Posicao da Janela de Texto (Segundo Argumento)
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Pilha
;;         Altera conteudo da Janela de Texto
;;
WriteStr:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		MOV	R1, M[SP+7]		; Endereco de Memoria da String
		MOV	R2, M[SP+6]		; Posicao Janela de Texto
		MOV	R3, END_STRING
WriteStrLoop:	MOV	R4, M[R1]
		CMP	R4, R3			; Verificar se atingiu fim da string
		BR.Z	WriteStrEnd		; Se chegou ao fim, nao escrever mais
		MOV	M[IO_TEXT_CTRL], R2	; Posicionar cursor
		MOV	M[IO_TEXT_WRITE], R4	; Escrever caracter
		INC	R1			; Proxima posicao da String
		INC	R2			; Proxima posicao na Janela de Texto
		BR	WriteStrLoop
WriteStrEnd:	POP	R4
		POP	R3
		POP	R2
		POP	R1
		RETN	2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	- EraseStr
;;
;; Funcao que apaga da Janela de Texto uma String. Recebe como argumento o endereco de
;; memoria do inicio da String e a posicao da Janela de Texto onde comeca a apagar.
;;
;; Entrad: Pilha - Endereco da String (Primeiro Argumento)
;;         Pilha - Posicao da Janela de Texto (Segundo Argumento)
;; Saidas: nenhuma
;; Efeito: Altera conteudo da Pilha
;;         Altera conteudo da Janela de Texto
;;
EraseStr:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		PUSH	R5
		MOV	R1, M[SP+8]		; Endereco de Memoria da String
		MOV	R2, M[SP+7]		; Posicao Janela de Texto
		MOV	R3, END_STRING
		MOV	R4, ' '
EraseStrLoop:	MOV	R5, M[R1]
		CMP	R5, R3			; Verificar se ja apagou tudo
		BR.Z	EraseStrEnd		; Se apagou tudo, nao fazer mais nada
		MOV	M[IO_TEXT_CTRL], R2	; Posicionar cursor
		MOV	M[IO_TEXT_WRITE], R4	; Apagar aquela posicao
		INC	R1			; Proxima posicao na String
		INC	R2			; Proxima posicao na Janela de Texto
		BR	EraseStrLoop
EraseStrEnd:	POP	R5
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		RETN	2
