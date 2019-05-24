;MUHAMMAD HAMZA ANEES
;AC REMOTE PROJECT
;MICROPROCESSOR AND ASSEMBLY LANGUAGE

.MODEL SMALL
.STACK 100H
.DATA
    START_MSG     DB ' ',10,13
                  DB ' ',10,13
                  DB '                     +-----------------------------+',10,13
                  DB '                     |                             |',10,13 
                  DB '                     |          AC REMOTE          |',10,13
                  DB '                     |_____________________________|',10,13
                  DB '                     |                             |',10,13
                  DB '                     |         1.ON  2.OFF         |',10,13
                  DB '                     |                             |',10,13
                  DB '                     +-----------------------------+ $',10,13
    
    SPACE_LINE    DB '                                   $'
    
    EXIT_PROGRAM  DB '                           YOUR PROGRAM IS EXIT $'
    
    MENU          DB ' ',10,13
                  DB ' ',10,13
                  DB '                     +-----------------------------+',10,13
                  DB '                     |        MAIN MENU            |',10,13 
                  DB '                     |                             |',10,13
                  DB '                     |        1.MODE               |',10,13
                  DB '                     |        2.TIMER              |',10,13
                  DB '                     |        3.SWING              |',10,13
                  DB '                     |        4.TEMP               |',10,13
                  DB '                     |        5.REMOTE CHILD LOCK  |',10,13
                  DB '                     |                             |',10,13
                  DB '                     +-----------------------------+ $',10,13
               
    MODE          DB ' ',10,13
                  DB ' ',10,13
                  DB '                     +-----------------------------+',10,13
                  DB '                     |            MODE             |',10,13 
                  DB '                     |                             |',10,13
                  DB '                     |           1.AUTO            |',10,13
                  DB '                     |           2.COOL            |',10,13
                  DB '                     |           3.DRY             |',10,13
                  DB '                     |           4.HEAT            |',10,13
                  DB '                     |           5.FAN             |',10,13
                  DB '                     |                             |',10,13
                  DB '                     +-----------------------------+ $',10,13
    INVALID_INPUT DB 'INVALID INPUT $'
    SHUTDOWN      DB 'PROGRAM IS SHUTDOWN $'
    AUTO          DB 'AC IS AUTO MODE $'
    COOL          DB 'AC IS COOL MODE $'
    DRY           DB 'AC IS DRY MODE $'
    HEAT          DB 'AC IS HEAT MODE $'
    FAN           DB 'AC IS FAN MODE $'
    SPEED_MODE    DB 'ENTER SPEED i,e, 1,2,3 $'
    TIMER_MODE    DB 'CHOOSE TIME ',10,13
                  DB  '                                   1. 10 SECONDS',10,13
                  DB  '                                   2. 30 SECONDS',10,13 
                  DB  '                                   3. 1 MINUTE $',10,13
    AC_TURN_OFF   DB 'AC IS TURN OFF $'
    SPEED         DB 'SPEED SET TO 1','SPEED SET TO 2','SPEED SET TO 3'
    TEMP          DW 16 ;16~30
    INCREASE_     DB 'INCREASE $'
    DECREASE_     DB 'DECREASE $'
    TEMP_MSG      DB 'TEMP NOT MORE INCREASE $'
    TEMP_MSG1     DB 'TEMP NOT MORE DECREASE $'
    TEMP_CHOOSE   DB '1.INCREASE   2.DECREASE   3. EXIT$'
    SWING_A_D     DB 'SWING ACTIVATED/DEACTIVATED $'
    REMOTE_LOCKED DB 'REMOTE IS LOCKED $'
    UN_LOCKED     DB 'REMOTE IS UN LOCKED $'           
                          
.CODE

NEW_LINE PROC
    MOV DX,13 ; CARRIAGE RETURN
    MOV AH,2H ; SHOW OUTPUT
    INT 21H   ; INTRUPT 
    
    MOV DX,10 ; NEW FEED LINE
    MOV AH,2H ; SHOW OUTPUT
    INT 21H   ; INTRUPT
    
    LEA DX,SPACE_LINE
    MOV AH,9H ; SHOW STRING AS OUTPUT
    INT 21H
RET
NEW_LINE ENDP

NEW_LINE_INPUT PROC
    CALL NEW_LINE ; FUNCTION CALL
    
    MOV AH,1H     ; INPUT VIA KEYBOARD
    INT 21H       ; INTRUPT
    SUB AL,30H    ; SUBTRACT 30H ASCII CODES 1 = 31
RET
NEW_LINE_INPUT ENDP

RETURN_ PROC
    DEFAULT: 
    CALL NEW_LINE
    CALL NEW_LINE
    LEA DX,INVALID_INPUT
    MOV AH,9H
    INT 21H
    JMP EXIT_REMOTE
RETURN_ ENDP

STARTING PROC
    LEA DX,START_MSG
    MOV AH,9H
    INT 21H
    
    CALL NEW_LINE_INPUT ;FUNCTION CALLING
    
    CMP AL,1
    JE MAIN_MENU
    
    CMP AL,2
    JE TERMINATE_PROGRAM
    
    CALL RETURN_
STARTING ENDP

TIMER PROC
    ;MOV CX,15 
    MOV AH,86H
    INT 15H
    
    CALL NEW_LINE
    CALL NEW_LINE
    LEA DX,AC_TURN_OFF
    MOV AH,9H
    INT 21H
    JMP EXIT_REMOTE
TIMER ENDP

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    CALL STARTING
    
    MAIN_MENU:
        LEA DX,MENU
        MOV AH,9H
        INT 21H
    
        CALL NEW_LINE_INPUT ;FUNCTION CALLING 
    
        CMP AL,1H
        JE MODE_
    
        CMP AL,2H
        JE TIMER_
    
        CMP AL,3H
        JE SWING_ 
    
        CMP AL,4H
        JE TEMP_
    
        CMP AL,5H
        JE REMOTE_CHILD_
    
        CALL RETURN_

    
        MODE_:
            LEA DX,MODE
            MOV AH,9H
            INT 21H
    
            CALL NEW_LINE_INPUT ;FUNCTION CALLING
    
            CMP AL,1H
            JE AUTO_
    
            CMP AL,2H
            JE COOL_
    
            CMP AL,3H
            JE DRY_
    
            CMP AL,4H
            JE HEAT_

            CMP AL,5H
            JE FAN_
            
            CALL RETURN_
    
            AUTO_:
                CALL NEW_LINE
                LEA DX,AUTO
                MOV AH,9H
                INT 21H
                JMP STARTING
            
            COOL_:
                CALL NEW_LINE
                LEA DX,COOL
                MOV AH,9H
                INT 21H
                JMP STARTING
    
            DRY_:
                CALL NEW_LINE
                LEA DX,DRY
                MOV AH,9H
                INT 21H
                JMP STARTING
    
            HEAT_:
                CALL NEW_LINE
                LEA DX,HEAT
                MOV AH,9H
                INT 21H
                JMP STARTING
    
            FAN_:
                CALL NEW_LINE
                LEA DX,FAN
                MOV AH,9H
                INT 21H
                
                
                CALL NEW_LINE
                LEA DX,SPEED_MODE
                MOV AH,9H
                INT 21H
                               
                CALL NEW_LINE_INPUT
                
                CMP AL,1H
                JE SPEED_1_
                
                CMP AL,2H
                JE SPEED_2_
                
                CMP AL,3H
                JE SPEED_3_
                    
                CALL RETURN_
                
                SPEED_1_:
                    CALL NEW_LINE
                    LEA SI,SPEED
                    MOV CX,14                   
                    L1:
                        MOV DX,[SI]
                        MOV AH,2
                        INT 21H
                        INC SI
                        LOOP L1
                        JMP STARTING
                
                SPEED_2_:
                    CALL NEW_LINE
                    LEA SI,SPEED
                    MOV CX,14
                    L2:
                        MOV DX,[SI + 14]
                        MOV AH,2
                        INT 21H
                        INC SI
                        LOOP L2
                        JMP STARTING
                
                SPEED_3_:
                    CALL NEW_LINE
                    LEA SI,SPEED
                    MOV CX,14
                    L3:
                        MOV DX,[SI + 28]
                        MOV AH,2
                        INT 21H
                        INC SI
                        LOOP L3
                        JMP STARTING       
        TIMER_:
            CALL NEW_LINE
            LEA DX,TIMER_MODE
            MOV AH,9H
            INT 21H
            
            CALL NEW_LINE
            CALL NEW_LINE_INPUT
            
            CMP AL,1
            JE TIMER_1_
            
            CMP AL,2
            JE TIMER_2_
            
            CMP AL,3
            JE TIMER_3_
            
            CALL RETURN_
            
            TIMER_1_:
                MOV CX,150 ; 10 SECONDS HEX-96
                CALL TIMER
                
            TIMER_2_:
                MOV CX,450 ; 30 SECONDS HEX-1C2
                CALL TIMER
                
            TIMER_3_:
                MOV CX,900 ; 1 MINUTE HEX-384
                CALL TIMER    
                
        SWING_:
            CALL NEW_LINE
            
            LEA DX,SWING_A_D
            MOV AH,9H
            INT 21H
            CALL STARTING            
        
        REMOTE_CHILD_:    
            CALL NEW_LINE
            LEA DX,REMOTE_LOCKED
            MOV AH,9H
            INT 21H
            
            CALL NEW_LINE
            
            MOV AH,1H
            INT 21H 
            SUB AL,30H
            
            CMP AL,1H
            JE UN_LOCKED_
            
            RETURN__:
                CALL REMOTE_CHILD_
            
            UN_LOCKED_:
                CALL NEW_LINE
                LEA DX,UN_LOCKED
                MOV AH,9H
                INT 21H
                CALL STARTING 
    
        TEMP_:
            TEMPERATURE:
            CALL NEW_LINE
            
            LEA DX,TEMP_CHOOSE
            MOV AH,9H
            INT 21H
            
            CALL NEW_LINE
            
            MOV AH,1H
            INT 21H 
            SUB AL,30H
            
            CMP AL,1H
            JE INCREASE__
    
            CMP AL,2H
            JE DECREASE__
            
            CMP AL,3H
            JE EXIT_MAIN
    
            JMP RETURN_
            
            INCREASE__:
                MOV BX,TEMP
                CMP BX,16
                JG INCREASE
    
                DEFAULT_1:
                    CALL NEW_LINE
                    LEA DX,TEMP_MSG
                    MOV AH,9H
                    INT 21H
                    JMP TEMPERATURE:
            
        
                INCREASE:
                    MOV BX,TEMP
                    DEC BX
                    MOV TEMP,BX
                    
                    CALL NEW_LINE
                    LEA DX,INCREASE_
                    MOV AH,9H
                    INT 21H
                    JMP TEMPERATURE:
        
        
            DECREASE__:
                MOV BX,TEMP
        
                CMP BX,30
                JL DECREASE
    
                DEFAULT_2:
                    CALL NEW_LINE
                    LEA DX,TEMP_MSG1
                    MOV AH,9H
                    INT 21H
                    JMP TEMPERATURE:
    
                DECREASE:
                    MOV BX,TEMP
                    INC BX
                    MOV TEMP,BX
                    
                    CALL NEW_LINE
                    LEA DX,DECREASE_
                    MOV AH,9H
                    INT 21H
                    JMP TEMPERATURE:
                
                EXIT_MAIN:
                  JMP STARTING      
    
    TERMINATE_PROGRAM:
    CALL NEW_LINE
    CALL NEW_LINE
    LEA DX,SHUTDOWN
    MOV AH,9H
    INT 21H
    
    EXIT_REMOTE: ;EXIT PROGRAM
ENDP
END MAIN