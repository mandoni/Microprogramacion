.MODEL small ;tiny
.DATA ;segmento donde van las variables 
    cadena1 DB '. Total: $'
    cadena2 DB '. Diferencia: $'
    cadena3 DB '. Producto: $'
    cadena4 DB '. Cociente: $'
    cadena5 DB 'Ingrese el primer numero $'
    cadena6 DB '. Ingrese el segundo numero $'
    cadena7 DB '. Residuo: $'
    num1 DB ? 
    num2 DB ?
    result DB ?
.CODE 
    programa:
    ;inicializar el programa 
    
            MOV AX, @DATA   ;se obtiene la direccion de iniciodel segmento de datos 
        MOV DS, AX  ;asignamos al registro data segment la direccion de inicio de segmento 
            ;leer d?gito
            MOV DX, offset cadena5  
            MOV AH, 09h      
            INT 21h 
            XOR AX, AX
            MOV AH, 01h
            INT 21h
            SUB AL, 30H 
            MOV num1, AL
            MOV DX, offset cadena6   
            MOV AH, 09h      
            INT 21h 
            XOR AX, AX 
            MOV AH, 01h
            INT 21h
            SUB AL, 30h
            MOV num2, AL
            
            ;sumo los numeros 
            XOR AX, AX 
            ADD AL, num1
            ADD AL, num2
            MOV BL, AL
            
            ;muestro el resultado de la resta en pantalla. 
            MOV DX, offset cadena1  
            MOV AH, 09h      
            INT 21h 
            XOR AX, AX
            MOV AH, 02h 
            MOV DL, BL
            ADD DL, 30h
            INT 21h
            
            
            ;resto los n?meros 
            XOR AX, AX 
            MOV AL, num1
            SUB AL, num2
            MOV result, AL
            MOV BL, AL
            
            ;muestro el resultado de la resta en pantalla. 
            MOV DX, offset cadena2  
            MOV AH, 09h      
            INT 21h 
            XOR AX, AX
            MOV AH, 02h 
            MOV DL, BL
            ADD DL, 30h
            INT 21h
            
            ;multiplico 
            XOR AX, AX 
            XOR BX, BX
            MOV AL, num1
            MUL num2
            MOV BX, AX
            
            ;muestro el resultado de la multiplicar en pantalla. 
            MOV DX, offset cadena3   
            MOV AH, 09h      
            INT 21h 
            XOR AX, AX
            MOV AH, 02h 
            MOV DX, BX
            ADD DX, 30h
            INT 21h
            
            ;division
            XOR AX, AX 
            XOR BX, BX
            XOR DX, DX
            MOV AL, num1
            DIV num2
            MOV BL, AL
            MOV BH, AH
            
            ;muestro el resultado de la division en pantalla. 
            MOV DX, offset cadena4   
            MOV AH, 09h      
            INT 21h 
            XOR AX, AX
            MOV AH, 02h 
            MOV DL, BL
            ADD DL, 30h
            INT 21h
            
            ;Residuo en la pantalla
            MOV DX, offset cadena7   
            MOV AH, 09h      
            INT 21h 
            XOR AX, AX
            MOV AH, 02h 
            MOV DL, BH
            ADD DL, 30h
            INT 21h
            
    ;finalizar el programa 
        MOV AH, 4Ch 
        INT 21h 
        
.STACK 
END programa