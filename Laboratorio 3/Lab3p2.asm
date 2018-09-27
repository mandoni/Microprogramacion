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
    result DB 10
.CODE 
    programa:
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
            
            ;muestro el resultado de la suma en pantalla. 
            MOV DX, offset cadena1  
            MOV AH, 09h      
            INT 21h 
            
            ;el resultado se divide dentro de 10 para obtener decenas en el cociente
            ;y unidades en el reciduo
            MOV AX, BX
            MOV BL, result
            DIV BX
            MOV BX, AX 
            MOV CX, DX 
            
            ;se imprime cociente 
            MOV AH, 02h 
            MOV DX, BX
            ADD DX, 30h
            INT 21h
            
            ;se imprime reciduo
            MOV AH, 02h 
            MOV DX, CX
            ADD DX, 30h
            INT 21h
            
            ;resto 
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
            
            ;limpio
            XOR AX, AX 
            XOR BX, BX
            XOR DX, DX 
            XOR CX, CX
            
            ;multiplico 
            MOV AL, num1
            MUL num2
            MOV BX, AX
            
            ;muestro el resultado de la multiplicacion en pantalla. 
            MOV DX, offset cadena3  
            MOV AH, 09h      
            INT 21h 
            
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
    ;finalizar el programa 
        MOV AH, 4Ch 
        INT 21h 
        
.STACK 
END programa