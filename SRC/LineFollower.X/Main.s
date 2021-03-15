;******************************************************************************
;   This file is a basic template for assembly code for a PIC16F877A. Copy    *
;   this file into your project directory and modify or add to it as needed.  *
;   This file is a basic code template for assembly code generation	      *
;   on the PIC PIC16F877A. This file contains the basic code		      *
;   building blocks to build upon.					      *  
;                                                                             *
;                                                                             *
;                                                                             *
;                                                                             *
;   Refer to the MPLAB User's Guide for additional information on the         *
;   features of the assembler.                                                *
;                                                                             *
;   Refer to the PIC16F877A Data Sheet for additional information on the     *
;   architecture and instruction set.                                         *
;                                                                             *
;******************************************************************************
;                                                                             *
;    Filename:        LineFollower                                       *
;    Date:                     09/03/2021                                     *
;    File Version:                  v5.40                                         *
;                                                                             *
;    Author:           Diego Alejandro Torres Urrego   
;		       Luis Fernando Gomez Diaz
;    Company:               Universidad de Ibagué                                                 *
;                                                                             * 
;******************************************************************************
;                                                                             *
;    Files required:         PIC16F877A DATASHEET                             *
;                       MPASM_to_MPLAB_XC8_PIC_Assembler_Migration_Guide      *
;                                                                             *
;******************************************************************************
    
    PROCESSOR 16F877A
#include <xc.inc>

;****CONFIGURACION***    
                                                      
CONFIG CP=OFF ; PFM and Data EEPROM code protection disabled
CONFIG DEBUG=OFF ; Background debugger disabled
CONFIG WRT=OFF
CONFIG CPD=OFF
CONFIG WDTE=OFF ; WDT Disabled; SWDTEN is ignored
CONFIG LVP=ON ; Low voltage programming enabled, MCLR pin, MCLRE ignored
CONFIG FOSC=XT
CONFIG PWRTE=ON
CONFIG BOREN=OFF

;                            ****MEMORIA Y BANCOS****
PSECT udata_bank0
max:
 DS 1 ;reserve 1 byte for max
tmp:
 DS 1 ;reserve 1 byte for tmp
PSECT resetVec,class=CODE,delta=2

INISYS:
    ;CAMBIO A BANCO 1
    BCF STATUS, 6
    BSF STATUS, 5 ; Bank1
    
    ;                             ****DECLARACION DE ENTRADAS****
    
    ;BITS DE ENTRADA QUE SE USARAN
    BSF TRISC, 0
    BSF TRISC, 1
    BSF TRISC, 2
    BSF TRISC, 3
    BSF TRISC, 4
    ;BITS DE SALIDA QUE SE USARAN
    
    BCF TRISD, 7  ;SALIDA0
    BCF TRISD, 6  ;SALIDA1
    BCF TRISD, 5  ;SALIDA2
    BCF TRISD, 4  ;SALIDA3
    BCF TRISD, 1  ;LED ROJO
    BCF TRISD, 2  ;LED DERECHO AMARILLO
    BCF TRISD, 3  ;LED IZQUIERDO AMARILLO
    
    
    ;REGRESAR A BANCO 0
    BCF STATUS, 5 
    
    
     ;                                ****CODIGO****
     
     MAIN:
    
   
    
;COMIENZA A LEER LOS BITS DE ENTRADA DE IZQUIERDA A DERECHA
    
    BTFSS PORTC,0
    GOTO INSTRUCCION1 ;0
    GOTO INSTRUCCION2 ;1
    
    INSTRUCCION1:
    
    BTFSS PORTC,1
    GOTO INSTRUCCION8 ;00
    GOTO INSTRUCCION9 ;01
    
    INSTRUCCION9:
    
    MOVLW 00101000B ;GIRO SUAVE A LA IZQUIERDA
    MOVWF PORTD  ;Y LED AMARILLO IZQUIERDO SE ENCIENDE
    GOTO MAIN
        
    
    INSTRUCCION8:
    
    BTFSS PORTC,2
    GOTO INSTRUCCION10 ;000
    GOTO INSTRUCCION11 ;001 
    
    INSTRUCCION11:
    
    BTFSS PORTC,3
    GOTO INSTRUCCION16 ;0010
    GOTO INSTRUCCION15 ;0011
    
    INSTRUCCION16:
    
    MOVLW 10100000B ; EN MARCHA
    MOVWF PORTD    ; NO SE ENCIENDE NINGUN LED EN ESTE ESTADO
    GOTO MAIN
    
    INSTRUCCION10:
    
    BTFSS PORTC,3
    GOTO INSTRUCCION12 ;0000
    GOTO INSTRUCCION13 ;0001 
     
    INSTRUCCION12:
    
    BTFSS PORTC,4 
    GOTO INSTRUCCION7 ;00000
    GOTO INSTRUCCION14 ;00001
    
    INSTRUCCION14:
    
    MOVLW 10010100B ;GIRO FUERTE A LA DERECHA
    MOVWF PORTD    ; Y LED AMARILLO DERECHO SE ENCIENDE
    GOTO MAIN
    
    INSTRUCCION13:
    
    BTFSS PORTC,4
    GOTO INSTRUCCION15 ;00010
    GOTO INSTRUCCION14 ;00011 
    
    INSTRUCCION15:
    
    MOVLW 10000100B ; GIRO SUAVE A LA DERECHA
    MOVWF PORTD    ; Y LED AMARILLO DERECHO SE ENCIENDE
    GOTO MAIN
    
    INSTRUCCION2:
    
    BTFSS PORTC,1
    GOTO INSTRUCCION3 ;10
    GOTO INSTRUCCION4 ;11

    INSTRUCCION3:
    
    MOVLW 01101000B ;GIRO FUERTE A LA IZQUIERDA 
    MOVWF PORTD     ;Y LED AMARILLO IQUIERDO SE ENCIENDE 
    GOTO MAIN
    
    INSTRUCCION4:
    
    BTFSS PORTC,2
    GOTO INSTRUCCION3 ;110
    GOTO INSTRUCCION5 ;111
    
    INSTRUCCION5:
    
    BTFSS PORTC,3
    GOTO MAIN ;1110
    GOTO INSTRUCCION6 ;1111
    
    INSTRUCCION6:
    
    BTFSS PORTC,4
    GOTO MAIN ;11110
    GOTO INSTRUCCION7 ;11111
    
    INSTRUCCION7:
    
    MOVLW 11110010B ;DETENCION (STOP)
    MOVWF PORTD     ;Y LED ROJO SE ENCIENDE
    GOTO MAIN
    
    INSTRUCCION0:
    
    MOVLW 00000000B ; DEJA TODAS LAS SALIDAS EN 0 
    MOVWF PORTD     
    GOTO MAIN
    
     ;                      FIN DE CODIGO
    
    
    
