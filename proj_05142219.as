IO_READ     EQU   FFFFh
IO_WRITE    EQU   FFFEh
IO_STATUS   EQU   FFFDh
IO_CURSOR   EQU   FFFCh

INTERRUPTORES	EQU	FFF9h
LEDS		EQU	FFF8h

LCD		EQU	FFF5h
LCD_CONTROL	EQU	FFF4h

TimerValue  EQU   FFF6h
TimerControl EQU  FFF7h  
EnableTimer EQU   0001h

SP_INICIAL  EQU   FDFFh

MUDAR_LINHA EQU	  00C0h
FIM_TEXTO   EQU   '@'

INT_MASK    EQU	  FFFAh
MASK  	    EQU	  1000001111111111b

Display1    EQU   FFF0h
Display2    EQU   FFF1h
Display3    EQU   FFF2h
Display4    EQU   FFF3h

	


	ORIG 7000h
TEST_TEMP	WORD	0000h
POS_CURSOR      WORD 	0000h
POS_COMBOIO	TAB	6
POS_FANTASMA	TAB	6	
DIR_COMBOIO	WORD	0000h
DIR_FANTASMA	WORD	0000h
CAR_COMBOIO	STR	'||||||'
CAR_FANTASMA	STR	'------'
Ag0             WORD    8321h
Ag1             WORD    8629h
Ag2             WORD    863Eh
Ag3             WORD    8C3Eh
Ag4             WORD    9734h
Ag5             WORD    971Dh
Ag6             WORD    921Dh
Ag7             WORD    8D05h
Ag8             WORD    8A19h
Ag9             WORD    8619h
ChangedAg0      WORD    0h
ChangedAg1      WORD    0h
ChangedAg2      WORD    0h
ChangedAg3      WORD    0h
ChangedAg4      WORD    0h
ChangedAg5      WORD    0h
ChangedAg6      WORD    0h
ChangedAg7      WORD    0h
ChangedAg8      WORD    0h
ChangedAg9      WORD    0h
Contador1	WORD    0h
Contador2       WORD    0h
Contador3       WORD    0h
Contador4       WORD    0h
Colisao		WORD	0h
TimeLong    	WORD    0003h
FimJogo		WORD	0h
PontuacaoMaxima	WORD	0h

		ORIG	8000h
CEN0		STR	'---------------------------------$                              '
ERR0		TAB	00C0h
CEN1		STR	'                                 |                              '
ERR1		TAB	00C0h
CEN2		STR	'                                 |                              '
ERR2		TAB	00C0h
CEN3		STR	'     /--------========----------------------------------------$ ' 
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
CEN10		STR	'     |     $--========---/ 8             |                    | '
ERR10		TAB	00C0h
CEN11		STR	'     |     |             |               |                    | '
ERR11		TAB	00C0h
CEN12		STR	'     |     |             |               |          /---------| '
ERR12		TAB	00C0h
CEN13		STR	'  /--|7    |             |               |          |       3 | '
ERR13		TAB	00C0h
CEN14		STR	'  |  |     |             |               |          |         | '
ERR14		TAB	00C0h
CEN15		STR	'  #  |     $-------------/               |          |         | '
ERR15		TAB	00C0h
CEN16		STR	'  #  |                                   |          |         | '
ERR16		TAB	00C0h
CEN17		STR	'  #  |                       6           |          |         | '
ERR17		TAB	00C0h
CEN18		STR	'  #  $------========---------$-----------/          |           '
ERR18		TAB	00C0h
CEN19		STR	'  #                          |                      |           '
ERR19		TAB	00C0h
CEN20		STR	'  O                          |                      |           '
ERR20		TAB	00C0h
CEN21		STR	'  |                          |                      |           '  
ERR21		TAB	00C0h
CEN22		STR	'  |                        5 |                      |4          '
ERR22		TAB	00C0h
CEN23		STR	'  $--------------------------------==&=======-------/---------- '
ERR23		TAB	00C0h
NOVOJOGOCEN1	STR	'Prima tecla@'
NOVOJOGOCEN2	STR	'  N  para  @'
NOVOJOGOCEN3	STR	' novo jogo @'

;;
;;
;;	ZONA DAS INTERRUPÇOES
;;
;;
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

;;
;;
;;	ZONA DO CODIGO
;;
;;
	
	ORIG	0000h
JMP		inicio

;;
;;	Escrita cenário
;;

Esc_Cenario:	MOV	R1, CEN0
		MOV	R2, R0
		MOV	R3, 24
Esc_Cenario_1:	I2OP	R1, R2
		ADD	R1, 100h
		ADD	R2, 100h
		DEC	R3
		CMP	R3, R0
		BR.Z	fim_Esc_Cenario
		BR	Esc_Cenario_1
fim_Esc_Cenario:RET

;;
;; Inicialização comboios
;;

Inicializa_Comboio:	MOV	R1, POS_COMBOIO
			MOV	R2, 1402h
			MOV	M[R1],R2
			INC	R1
			MOV	R2, 1302h
			MOV	M[R1],R2		
			INC	R1
			MOV	R2, 1202h
			MOV	M[R1],R2		
			INC	R1
			MOV	R2, 1102h
			MOV	M[R1],R2		
			INC	R1
			MOV	R2, 1002h
			MOV	M[R1],R2		
			INC	R1
			MOV	R2, 0F02h
			MOV	M[R1],R2		
			MOV	R3, 0100h
			MOV	R4, DIR_COMBOIO
			MOV	M[R4], R3
 			RET

Inicializa_Locomotiva:	MOV	R1, POS_FANTASMA
			MOV	R2, 062Fh
			MOV	M[R1],R2
			INC	R1
			MOV	R2, 0630h 
			MOV	M[R1],R2		
			INC	R1
			MOV	R2, 0631h
			MOV	M[R1],R2		
			INC	R1
			MOV	R2, 0632h
			MOV	M[R1],R2		
			INC	R1
			MOV	R2, 0633h
			MOV	M[R1],R2		
			INC	R1
			MOV	R2, 0634h
			MOV	M[R1],R2		
			MOV	R3, -1h
			MOV	R4, DIR_FANTASMA
			MOV	M[R4], R3
 			RET

Inicializa_Pontuacao:   MOV     M[Display1],R0
                        MOV     M[Display2],R0  
                        MOV     M[Display3],R0  
                        MOV     M[Display4],R0  
                        RET
;;
;; Rotinas do movimento do comboio do utilizador
;;

MoveComboio:	CALL	ApagarUltimaCarruagem
		CALL	ComutarComboioCar
		CALL	EscreveLocomotiva	; e primeira carruagem, e ler caracter
		CALL	ActualizaPosicoes
		CALL	VerificaCarril
		CALL	VerificaPassageiros
		INC	M[Contador1]
		RET


VerificaPassageiros:	DSI
			MOV	R1, CAR_COMBOIO
			MOV	R2, '&'			
			CMP	M[R1], R2
			BR.NZ	VerificaPassageirosFim
			INC	M[Contador3]
			MOV	R1, M[CAR_COMBOIO]
			MOV	R2, '='
			MOV	M[CAR_COMBOIO], R2
VerificaPassageirosFim:	ENI
			RET

ApagarUltimaCarruagem:	MOV	R1, CAR_COMBOIO
			MOV	R2, M[R1+5]	; devolve o caracter por baixo da ultima carruagem
			MOV	R1, POS_COMBOIO
			MOV	R3, M[R1+5]	; devolve posicao ultima carruagem
			MOV	M[IO_CURSOR], R3
			MOV	M[IO_WRITE], R2
			RET

ComutarComboioCar:	DSI
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
			ENI
                        RET

VerificaCarril:		DSI
                        MOV	R1, M[POS_COMBOIO]
			;ADD	R1, M[DIR_COMBOIO]	; posicao seguinte
			ADD	R1, 8000h
                        MOV	R2, M[R1]		; caracter da posicao seguinte
			CMP     R2, '$'
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
fim_verCarril:		ENI
                        RET

EscreveLocomotiva:	DSI
			MOV	R1, M[POS_COMBOIO]
			MOV	M[IO_CURSOR], R1
			MOV	R2, '#'
			MOV	M[IO_WRITE], R2		; apagar locomotiva, escrever cardinal
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
			ENI	
			RET

VerificaDescarrilamento:DSI
			MOV	R1, M[SP+3]
			MOV	R2, M[SP+2]
			CMP	R2, ' '
			BR.Z	Descarrila
			CMP	R2, '9'
			BR.N	Verifica1
			BR	Verifica2
Verifica1:		CMP	R2, '0'
			BR.P	Descarrila
Verifica2:		CMP	R1, 8000h
			BR.N	Descarrila
			CMP	R1, 9740h
			BR.P	Descarrila
			AND	R1, 00FFh
			CMP	R1, 0040h
			BR.P	Descarrila
			BR	VerificaDescarrilamentoFim
Descarrila:		INC	M[Colisao]
VerificaDescarrilamentoFim:ENI
			RET


ActualizaPosicoes:	DSI
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
                        ENI
                        RET

;;
;; Rotinas Movimento do Comboio Fantasma
;;

MoveComboioFant:CALL	ApagarUltimaCarruagemFant
		CALL	ComutarFantasmaCar
		CALL	EscreveFantasma	; e primeira carruagem, e ler caracter
		CALL	ActualizaPosicoesFant
		CALL	VerificaCarrilFant
		RET

ApagarUltimaCarruagemFant:DSI	
			MOV	R1, CAR_FANTASMA
			MOV	R2, M[R1+5]	; devolve o caracter por baixo da ultima carruagem
			MOV	R1, POS_FANTASMA
			MOV	R3, M[R1+5]	; devolve posicao ultima carruagem
			MOV	M[IO_CURSOR], R3
			MOV	M[IO_WRITE], R2
			MOV	R3, M[R1+4]
			MOV	M[IO_CURSOR], R3
			MOV	R4, 'O'
			MOV	M[IO_WRITE], R4
			ENI
			RET

ComutarFantasmaCar:	DSI
                        MOV	R1, 5
ComutarFantasmaCarCiclo:	MOV	R2, CAR_FANTASMA
			ADD	R2, R1
			DEC	R2
			MOV	R3, M[R2]
			INC	R2
			MOV	M[R2], R3
			DEC	R1
			CMP	R1, R0
			BR.NZ	ComutarFantasmaCarCiclo
			ENI
                        RET

VerificaCarrilFant:		DSI
                        MOV	R1, M[POS_FANTASMA]
			;ADD	R1, M[DIR_FANTASMA]	; posicao seguinte
			ADD	R1, 8000h
                        MOV	R2, M[R1]		; caracter da posicao seguinte
			CMP     R2, '$'
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
fim_verCarrilFant:		ENI
                        RET

EscreveFantasma:	DSI
			MOV	R1, M[POS_FANTASMA]
			MOV	M[IO_CURSOR], R1
			MOV	R2, 'o'
			MOV	M[IO_WRITE], R2		; apagar locomotiva, escrever cardinal
			ADD	R1, M[DIR_FANTASMA]
			MOV	M[IO_CURSOR], R1
			ADD	R1, 8000h			
			MOV	R2, M[R1]		; ler caracter seguinte (da linha)
			PUSH	R1
			PUSH	R2
			CALL	VerificaDescarrilamentoFant
			POP	R2
			POP	R1
			MOV	M[CAR_FANTASMA], R2
			MOV	R2, 'O'
			MOV	M[IO_WRITE], R2		; escrever nova locomotiva
			ENI
			RET

VerificaDescarrilamentoFant:DSI
			MOV	R1, M[SP+3]
			MOV	R2, M[SP+2]
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
VerificaDescarrilamentoFantFim:ENI
			RET

ActualizaPosicoesFant:	DSI
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
                        ENI
                        RET

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

;;
;;  Agulhas
;;

AnalisaAgulhas:     DSI
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
fim_AnalisaAgulhas: ENI
                    RET

MudaAgulha:  DSI
	MOV	R2, M[SP+2]
              MOV   R4, Ag0
	ADD	R4,R2
	MOV	R3,M[R4]
              MOV   R1, M[R3]
              CMP   R1, '-'
              BR.Z  MudaCaso01
              CMP   R1, '$'
              BR.Z  MudaCaso02
              CMP   R1, '|'
              BR.Z  MudaCaso03
              CMP   R1, '/'
              BR.Z  MudaCaso04
MudaCaso01:    MOV   R1, '$'
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
fim_MudaAgulha: ENI
                RET




ActualizaAgulhas: DSI
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
fimActAg:         ENI
                  RET


;;
;;
;; FIM JOGO
;;
;;


VerificaFimJogo: MOV	R1, M[Colisao]
		 CMP	R1, R0
		 BR.Z	VerificaFimJogo1	
FimJogoEt:	 INC	M[FimJogo]
VerificaFimJogo1:RET




ActualizaLeds:	MOV	R7, M[INTERRUPTORES]
			MOV	R6, R0
ActualizaLeds1:	CMP	R7, R0
			BR.Z	ActualizaLedsFim
ActualizaLeds2:	SHL	R6, 1
			INC	R6			
			DEC	R7
			BR	ActualizaLeds1
ActualizaLedsFim:	MOV	M[LEDS], R6
			RET
			

ActualizaVelocidade:	PUSH	R7
			MOV	R7, M[INTERRUPTORES]
			ADD	R7, 3h
			MOV	M[TimeLong], R7
			CALL	Set_Timer
			POP	R7
			RET	

EscrevePontuacaoMaxima:	MOV	R1, M[Contador1]
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
			PUSH	R1
			CALL	EscreveDisplayPontuacao
			POP	R1			
EscrevePontuacaoMaxima1:CALL	LimpaContadores			
			RET

EscreveDisplayPontuacao:MOV	R1, M[SP+2]
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
			RET



LimpaContadores:	MOV	M[Contador1],R0
			MOV	M[Contador2],R0
			MOV	M[Contador3],R0
			MOV	M[Contador4],R0
			RET

EscreveMensagem:	MOV	R1, ERR10
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
EscreveMensagemFim:	RET



Set_Timer:	PUSH	R7
		MOV	R7, M[TimeLong]
		MOV	M[TimerValue],R7
		MOV	R7, EnableTimer
		MOV	M[TimerControl],R7
		POP	R7
		RET

inicio:   	MOV   	R7, SP_INICIAL
          	MOV   	SP,R7
          	MOV   	R7, FFFFh
          	MOV   	M[IO_CURSOR],R7
		MOV	R7, MASK
		MOV	M[INT_MASK],R7
		ENI
inicializacoes:	CALL	Esc_Cenario
		CALL	Inicializa_Comboio
		CALL	Inicializa_Locomotiva
		CALL    Inicializa_Pontuacao
                CALL	Set_Timer
ciclo:		CMP	M[TEST_TEMP],R0
		BR.Z	ciclo
		MOV	M[TEST_TEMP],R0
		CALL	MoveComboio
		CALL	MoveComboioFant
		CALL	VerificaFimJogo
		CALL    AnalisaAgulhas
                CALL    ActualizaAgulhas
                CALL    ActualizaPontuacao
		CALL	ActualizaLeds
		CALL	ActualizaVelocidade
		CMP	M[FimJogo],R0
		BR.Z	ciclo
NovoJogo:	CALL	EscrevePontuacaoMaxima
		CALL	EscreveMensagem
NovoJogo1:	CMP	M[IO_STATUS],R0
		BR.Z	NovoJogo1
		MOV	R1, M[IO_READ]
		CMP	R1, 'N'
		BR.NZ	NovoJogo
		MOV	M[Colisao],R0
		MOV	M[FimJogo],R0
		JMP	inicializacoes
