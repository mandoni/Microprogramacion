.MODEL small ;tiny
.DATA ;segmento donde van las variables 
    cadena1 DB 'Ingrese el primer numero $'
    cadena2 DB '. Ingrese el segundo numero $'
    cadena3 DB '. Los numeros son iguales.$'
    cadena4 DB '. El primer numreo es mayor.$'
    cadena5 DB '. El primer numero es menor.$'
    cadena6 DB ' La multipllicacion sucesiva da: $'
    cadena7 DB '. El cociente de la division es: $'
    cadena8 DB '. El residuo de la division es: $'
    num1 DB ?
    num2 DB ?
.CODE 
    programa:
    ;inicializar el programa 
    MOV AX, @DATA   ;se obtiene la direccion de iniciodel segmento de datos 
        MOV DS, AX  ;asignamos al registro data segment la direccion de inicio de segmento 
    
    ;leer d?gito
    MOV DX, offset cadena1  
    MOV AH, 09h      
    INT 21h 
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    SUB AL, 30H 
    MOV num1, AL
    MOV DX, offset cadena2   
    MOV AH, 09h      
    INT 21h 
    XOR AX, AX 
    MOV AH, 01h
    INT 21h
    SUB AL, 30h
    MOV num2, AL
      
    ;resto los numeros para ver mayor, menor e igual
    MOV AL, num1
    MOV AH, num2
    XOR AL, AH    
    
    ;iguales 
    JE iguales
    SUB AL, AH
    JL menor
    JMP mayor
    
    ;etiquetas
    iguales:
    MOV DX, offset cadena3 
    MOV AH, 09h      
    INT 21h 
    JMP dos
    
    mayor:
    MOV DX, offset cadena4  
    MOV AH, 09h      
    INT 21h 
    JMP dos
    
    
    menor: 
    MOV DX, offset cadena5
    MOV AH, 09h      
    INT 21h 
    JMP dos
    
    ;segundo programa 
    dos:
    MOV BH, num1
    MOV BL, num2
    MOV CL, 00d
    MOV CH, 00d
    
    ;sumas sucesivas 
    mult:
    MOV BL, num2
    ADD CL, BH
    ADD CH, 01d
    XOR BL, CH
    JNE mult
    
    ;resultado
    MOV DX, offset cadena6
    MOV AH, 09h      
    INT 21h 
    ;XOR AX, AX
    XOR BX, BX
    MOV BL, CL
    ;MOV AH, 02h 
    ;MOV DX, BX
    ;ADD DX, 30h
    ;INT 21h
    ;el resultado se divide dentro de 10
    MOV AX, BX
    MOV BL, 10d
    DIV BL
    MOV BX, AX 
    
    ;se imprime cociente 
    XOR DX, DX
    MOV AH, 02h 
    MOV DL, BL
    ADD DL, 30h
    INT 21h
    
    ;se imprime reciduo
    XOR DX, DX 
    MOV AH, 02h 
    MOV DL, BH
    ADD DL, 30h
    INT 21h
           
    ;limpiar
    XOR AX, AX
    XOR BX, BX
    XOR CX, CX
    XOR DX, DX
    
    ;lado de division 
    MOV AL, num1
    MOV AH, num2
    SUB AL, AH
    JL menord
    JMP mayord
    
    menord:
    MOV BH, num2
    MOV BL, num1
    MOV CL, 00d
    MOV CH, 00d
    
    diviD:
    ADD CL, 01h
    SUB BH, BL
    MOV AH, BH
    SUB AH, BL
    JGE divi
    
    MOV DX, offset cadena7
    MOV AH, 09h      
    INT 21h 
    XOR DX, DX
    MOV AH, 02h 
    MOV DX, CX
    ADD DX, 30h
    INT 21h
    
    MOV DX, offset cadena8
    MOV AH, 09h      
    INT 21h 
    XOR DX, DX
    MOV AH, 02h 
    MOV DL, BH
    ADD DL, 30h
    INT 21h
    JMP fin
    
    mayord:
    MOV BH, num1
    MOV BL, num2
    MOV CL, 00d
    MOV CH, 00d
    
    divi:
    ADD CL, 01h
    SUB BH, BL
    MOV AH, BH
    SUB AH, BL
    JGE divi
    
    MOV DX, offset cadena7
    MOV AH, 09h      
    INT 21h 
    XOR DX, DX
    MOV AH, 02h 
    MOV DX, CX
    ADD DX, 30h
    INT 21h
    
    MOV DX, offset cadena8
    MOV AH, 09h      
    INT 21h 
    XOR DX, DX
    MOV AH, 02h 
    MOV DL, BH
    ADD DL, 30h
    INT 21h
    ;finalizar el programa
    fin:
    MOV AH, 4Ch 
    INT 21h 
        
.STACK 
END programa