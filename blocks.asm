[org 0100h]
jmp start

;=========================================================
;;Data
;{
paddle_x: dw 35         
paddle_y: dw 23         
paddle_width: dw 7      
paddle_color: db 0x70   
paddle_speed_val: dw 2

ball_x: dw 0           
ball_y: dw 0          
ball_dx: dw 0          
ball_dy: dw -1          
ball_timer: dw 0 
ball_speed_limit: dw 10000 

score: dw 0             
lives: dw 3
bricks_left: dw 52      

row_colors: db 0x20, 0x50, 0x60, 0x30

msg_anykey:    db 'PRESS ANY KEY TO CONTINUE', 0
msg_header:    db '=== RULES & CONTROLS ===', 0
msg_ctrl_move: db 'Left / Right Arrow : Move Paddle', 0
msg_ctrl_pause:db '         P         : Pause Game', 0
msg_ctrl_exit: db '        ESC        : Exit Game', 0
msg_goal:      db '   Break all bricks to WIN!', 0
msg_lives_info:db '      You have 3 Lives', 0
msg_prompt:    db 'PRESS ENTER TO START GAME', 0
msg_footer:    db ' Atari Breakout ', 0

msg_score_ui:  db 'SCORE:', 0
msg_lives_ui:  db 'LIVES:', 0
msg_bricks_ui: db 'BRICKS:', 0

msg_gameover:  db 'PRESS R TO RESTART', 0
msg_win:       db 'PRESS R TO RESTART', 0

Title_Bitmap:
    db 1,1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,1,0,0,1,1,1,0,0,1,0,0,0,1,0,0,1,1,1,0,0,1,0,0,0,1,0,1,1,1,1,1,0
    db 1,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,0,0,1,0,0,0,1,0,1,0,0,1,0,0,1,0,0,0,1,0,1,0,0,0,1,0,0,0,1,0,0,0
    db 1,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,0,0,1,0,0,0,1,0,1,0,1,0,0,0,1,0,0,0,1,0,1,0,0,0,1,0,0,0,1,0,0,0
    db 1,1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,1,0,1,1,0,0,0,0,1,0,0,0,1,0,1,0,0,0,1,0,0,0,1,0,0,0
    db 1,0,0,0,1,0,1,0,1,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,1,0,1,0,0,0,1,0,0,0,1,0,1,0,0,0,1,0,0,0,1,0,0,0
    db 1,0,0,0,1,0,1,0,0,1,0,0,1,0,0,0,0,0,1,0,0,0,1,0,1,0,0,1,0,0,1,0,0,0,1,0,1,0,0,0,1,0,0,0,1,0,0,0
    db 1,1,1,1,0,0,1,0,0,0,1,0,1,1,1,1,1,0,1,0,0,0,1,0,1,0,0,0,1,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,1,0,0,0
GameOver_Bitmap:
    db 1,1,1,1,0,0,1,1,0,0,1,0,0,1,0,1,1,1,1,0,0,0,0,1,1,0,0,1,0,0,1,0,1,1,1,1,0,1,1,1,0
    db 1,0,0,0,0,1,0,0,1,0,1,1,1,1,0,1,0,0,0,0,0,0,1,0,0,1,0,1,0,0,1,0,1,0,0,0,0,1,0,0,1
    db 1,0,1,1,0,1,1,1,1,0,1,0,0,1,0,1,1,1,0,0,0,0,1,0,0,1,0,1,0,0,1,0,1,1,1,0,0,1,1,1,0
    db 1,0,0,1,0,1,0,0,1,0,1,0,0,1,0,1,0,0,0,0,0,0,1,0,0,1,0,0,1,1,0,0,1,0,0,0,0,1,0,1,0
    db 1,1,1,1,0,1,0,0,1,0,1,0,0,1,0,1,1,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,1,1,1,1,0,1,0,0,1
YouWin_Bitmap:
    db 1,0,0,1,0,0,1,1,0,0,1,0,0,1,0,0,0,1,0,0,0,1,0,1,1,1,0,1,0,0,1
    db 0,1,1,0,0,1,0,0,1,0,1,0,0,1,0,0,0,1,0,0,0,1,0,0,1,0,0,1,1,0,1
    db 0,0,1,0,0,1,0,0,1,0,1,0,0,1,0,0,0,1,0,1,0,1,0,0,1,0,0,1,0,1,1
    db 0,0,1,0,0,1,0,0,1,0,1,0,0,1,0,0,0,1,0,1,0,1,0,0,1,0,0,1,0,0,1
    db 0,0,1,0,0,0,1,1,0,0,0,1,1,0,0,0,0,0,1,0,1,0,0,1,1,1,0,1,0,0,1
msg_select:    db 'SELECT DIFFICULTY:', 0
msg_easy:      db '1. EASY   (Slow)', 0
msg_medium:    db '2. MEDIUM (Normal)', 0
msg_hard:      db '3. HARD   (Fast)', 0
;}
;=========================================================
;; CLEAR SCREEN
;{
clrscr:
	push es
	push ax
	push cx
	push di
	xor di,di
	mov ax, 0xB800
	mov es,ax
	mov ax,0720h
	mov cx,2000
	rep stosw
	mov ah, 02h     ; BIOS Function: Set Cursor Position
    mov bh, 00h     ; Page Number 0
    mov dh, 00h     ; Row 0
    mov dl, 00h     ; Column 0
    int 10h

	
	pop di
	pop cx
	pop ax
	pop es 
	
	ret
;}
;=========================================================
;; BOUNDARY
;{
Print_Boundary:
    push es
    push ax
    push di
    push cx  
    mov ax, 0xB800
    mov es, ax
    ;;top & bottom
    mov cx, 80          ;width of screen(x-axis)
    mov ax, 0x4020      ;red background
    mov di, 0           ;start from 0 
    rep stosw           ;top line
    mov di, 3840        ;24 * 160 = 3840
    mov cx, 80
    rep stosw           ;bottom Line

    ;;left & right
    mov cx, 23          ;height (1-23)
    mov di, 160         ;start from row 1
Left_Right_Loop:
    mov word [es:di], 0x4020      ;left wall
    mov word [es:di+158], 0x4020  ;rigth wall
    add di, 160                   ;next row
    loop Left_Right_Loop

    pop cx
    pop di
    pop ax
    pop es
    ret
;}
;=========================================================
;; BRICKS
;{
Print_Blocks:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push es
    mov ax, 0xB800
    mov es, ax

    mov ax, 1           ;start at Row 1 
    mov bx, 160         
    mul bx
    add ax, 2           ;col no*2
    mov di, ax          ;setting di

    xor si, si          ;it stores row number
Row_Loop:
    mov cx, 13          ;13 bricks per row
    
    mov bl, [row_colors + si] 
    mov bh, bl          
    mov bl, 0XB1         
    mov dx, bx          ;save attribute+char in dx
Brick_Loop:
    push cx     		;save 13        
    mov ax, dx         
    mov cx, 5           ;5 colored 
    rep stosw
    mov al, ' '
    mov ah, 00h         ;gap in bricks
    stosw              
    pop cx              ;restore 13
    loop Brick_Loop    
    inc si              ;row++
    cmp si, 4           
    je End_Print_Blocks

    add di, 4              
    jmp Row_Loop
End_Print_Blocks:
    pop es
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Main logic
Check_For_Brick:;(return zf=1-> safe || zf=0->call hit brick)
    push ax
    push bx
    push di
    push es
    cmp dx, 1
    jl Is_Safe          
    cmp dx, 4
    jg Is_Safe         

    mov ax, 0xB800
    mov es, ax

    mov ax, dx         ;ax=y  
    push dx           
    mov bx, 160
    mul bx              
    pop dx             
    mov di, ax 
    mov ax, cx    ;cx=x
    shl ax, 1           
    add di, ax 
    mov ax, [es:di]    
    cmp ah, 0x00     ;black
    je Is_Safe
    cmp ah, 0x07   ;grey
    je Is_Safe
    cmp ah, 0x40     ;red
    je Is_Safe
    mov ax, cx      ;x    
    mov bx, dx      ;y
    call Hit_Brick      
     call Sound_Brick
    or ah, 1     ;clear ZF
    jmp Check_Exit

Is_Safe:
    cmp ax, ax    ;set ZF

Check_Exit:
    pop es
    pop di
    pop bx
    pop ax
    ret
;;;;;;;;;;;;;;;;;;;;;	
Hit_Brick:
    push ax
    push bx
    push cx
    push dx
    push di
    push es
    
    ;start_X = ((X - 1) / 6) * 6 + 1
    sub ax, 1
    xor dx, dx
    mov cx, 6
    div cx              
    mul cx             
    add ax, 1         
    push ax             ;save start_X 
    mov ax, bx          ;get Y
    mov cx, 160
    mul cx                 
    pop bx              
    shl bx, 1           
    add ax, bx          
    mov di, ax  
    mov ax, 0xB800
    mov es, ax

    mov cx, 6
    mov ax, 0x0000      
    rep stosw
    
    inc word [score]   
	dec word [bricks_left] 
    call Update_UI  
    cmp word [score], 52
    je Win_Action_Label
    jmp End_Hit_Brick

Win_Action_Label:
    jmp Show_Win

End_Hit_Brick:    
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

;}
;=========================================================
;; PADDLE 
;{
Draw_Paddle:
    push ax
    push bx
    push cx
    push dx
    push di
    push es
    mov ax, 0xB800
    mov es, ax
    mov ax, [paddle_y]		;calc offset
    mov bx, 160
    mul bx
    mov di, ax
    mov ax, [paddle_x]
    shl ax, 1
    add di, ax
    mov cx, [paddle_width]
    mov ah, [paddle_color] ;blue
    mov al, ' '            
    rep stosw
    
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

Erase_Paddle:
    push ax
    push bx
    push cx
    push di
    push es   
    mov ax, 0xB800
    mov es, ax
    mov ax, [paddle_y]	;check starting index
    mov bx, 160
    mul bx
    mov di, ax
    mov ax, [paddle_x]
    shl ax, 1
    add di, ax
    mov cx, [paddle_width]
    mov ax, 0x0720     ;black
    rep stosw
    
    pop es
    pop di
    pop cx
    pop bx
    pop ax
    ret
;;;;;;;;;;;;;;;;;;;
;;INPUT
Check_Input:
    push ax 
    ;Check if key is available(using bios function)
    mov ah, 01h
    int 16h
    jz Input_Done       ;ZF=1 means no input in buffer
    mov ah, 00h			;key is availabe
    int 16h
    cmp ah, 0x4B        ;<-
    je Move_Left
    cmp ah, 0x4D        ;->
    je Move_Right
    cmp ah, 0x01        ;esc
    je Exit_Game
	cmp ah, 0x19        ; 'P' Key
    je Pause_Game
	jmp Input_Done
	Pause_Game:
		mov ah, 00h
		int 16h             
		jmp Input_Done
	
Move_Left:
    cmp word [paddle_x], 1		;if already on left most side
    jle Input_Done         
    call Erase_Paddle       
    mov ax, [paddle_speed_val] 
    sub [paddle_x], ax 
	
    cmp word [paddle_x], 1		;to stop paddle from eating left boundary
    jge Draw_L              
    mov word [paddle_x], 1 
Draw_L:
    call Draw_Paddle        
    jmp Input_Done
	
Move_Right:
    mov ax, 79
    sub ax, [paddle_width]
    cmp [paddle_x], ax		;wall check
    jge Input_Done
    call Erase_Paddle
	mov bx, [paddle_speed_val] 
    add [paddle_x], bx
	
	cmp word [paddle_x], ax
    jle Draw_R              ;for right collsision with wall
    mov word [paddle_x], ax 
Draw_R:
    call Draw_Paddle
    jmp Input_Done

Exit_Game:
	call clrscr
    mov ax, 4C00h
    int 21h

Input_Done:
    pop ax
    ret
;};;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;=========================================================
;; BALL 
;{
Draw_Ball:
    push ax
    push es
    push di
    mov ax, 0xB800
    mov es, ax
    mov ax, [ball_y]		;ball_y =row
    mov bx, 160
    mul bx
    mov di, ax

    mov ax, [ball_x]
    shl ax, 1
    add di, ax  
    mov word [es:di], 0x0F4F 
    pop di
    pop es
    pop ax
    ret
;;;;;;;;;;;;;;;;;;
Erase_Ball:
    push ax
    push es
    push di    
    mov ax, 0xB800
    mov es, ax 
    mov ax, [ball_y]
    mov bx, 160
    mul bx
    mov di, ax 
    mov ax, [ball_x]
    shl ax, 1
    add di, ax  
    ;clear
    mov word [es:di], 0x0720 
	
    pop di
    pop es
    pop ax
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Main Part
Move_Ball:
    call Erase_Ball
    call Handle_X 			;right/left(x axis)
    call Handle_Y			;y axis
    call Draw_Ball
    ret
Handle_X:
    mov ax, [ball_x]
    add ax, [ball_dx]   
    cmp ax, 1
    jle Left_hit	;left hit
    cmp ax, 78
    jge Right_hit  ;right hit 
    mov cx, ax          ;parameters(x)
    mov dx, [ball_y]    ;y
    call Check_For_Brick
    jnz Brick_hitten_x  
  
    mov [ball_x], ax
    ret
Left_hit:
    neg word [ball_dx]
    mov word [ball_x], 2
 call Sound_Wall	
    ret
Right_hit:
    neg word [ball_dx]
    mov word [ball_x], 77 
 call Sound_Wall
    ret
Brick_hitten_x:
    neg word [ball_dx]      
    ret
Handle_Y:
    mov ax, [ball_y]
    add ax, [ball_dy]   
    cmp ax, 24
    jge Jump_Reset	;live--
    cmp ax, 0
    jle Top_hit		;top hit
    cmp ax, 22
    je Paddle_Check
    mov cx, [ball_x]    ;parameters(x)
    mov dx, ax          ;y
    call Check_For_Brick
    jnz Brick_hitten_y     
  
    ; Safe
    mov [ball_y], ax
    ret
Jump_Reset:
    jmp Reset_Ball
Top_hit:
    neg word [ball_dy]
    mov word [ball_y], 1
 call Sound_Wall    
    ret
Brick_hitten_y:
    neg word [ball_dy]      ;reverse
    ret
Paddle_Check:
    mov cx, ax          ;saving ball y
    mov ax, [ball_x]
    mov bx, [paddle_x]  
    cmp ax, bx
    jl Miss
    add bx, [paddle_width]
    cmp ax, bx
    jge Miss
    
    mov bx, [paddle_x]
    sub ax, bx
    cmp ax, 2
    jl Left_bounce
    cmp ax, 4
    jg Right_bounce
    jmp Do_bounce
Miss:
    mov ax, cx          ;restore ball y
    mov [ball_y], ax    ;move
    ret
Left_bounce:
    mov word [ball_dx], -1
	call Sound_Paddle
    jmp Do_bounce
Right_bounce:
    mov word [ball_dx], 1
	call Sound_Paddle
    jmp Do_bounce
Do_bounce:
    neg word [ball_dy]
    mov word [ball_y], 22
	 call Sound_Paddle
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;
Reset_Ball:
	call Screen_Flash_Invert 
    call Erase_Ball
    dec word [lives]
    call Update_UI      
    cmp word [lives], 0
    je Game_Over_Action 
    
    mov ax, [paddle_x]
    add ax, 3
    mov [ball_x], ax
    mov word [ball_y], 22
    mov word [ball_dx], 0
    mov word [ball_dy], -1
    call Draw_Ball
    ret

Game_Over_Action:
    jmp Show_GameOver  
;}
;=========================================================
;; PRINT SCORE & LIVES(UI)
;{
Update_UI:
    push ax
    push es
    push di
    push si    
    mov ax, 0xB800
    mov es, ax
    
    mov si, msg_score_ui
    mov di, 3844
    mov ah, 0x4F       ;reg BG
    call Print_String    
    mov ax, [score]
    mov di, 3858
    call Print_Num

    mov si, msg_bricks_ui
    mov di,  3906      
    mov ah, 0x4F      
    call Print_String
    mov ax, [bricks_left]
    mov di, 3922
    call Print_Num

    mov si, msg_lives_ui
    mov di, 3980
    mov ah, 0x4F
    call Print_String
    
    mov ax, [lives]
    mov di, 3994
    call Print_Num
    
    pop si
    pop di
    pop es
    pop ax
    ret
;;;;;;;;;;;;;;;;;
Print_Num:
    push ax
    push bx
    push cx
    push dx
    push di
    
    mov cx, 0          
    mov bx, 10            
Get_digits:
    xor dx, dx
    div bx            
    push dx             
    inc cx
    cmp ax, 0
    jne Get_digits
Draw_digits:
    pop dx
    add dl, '0'        
    mov dh, 0x4F       
    mov [es:di], dx
    add di, 2
    loop Draw_digits 
    mov word [es:di], 0x4F20 ; optional
    
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

;Input: SI = Offset of String, DI = Screen Offset, AH = Color
Print_String:
    push ax
    push bx
    push es
    push di
    push si
    mov bx, 0xB800
    mov es, bx  
Next_Char:
    mov al, [si]        
    cmp al, 0           ;check terminater
    je Print_Done
    mov [es:di], ax    
    inc si              
    add di, 2           
    jmp Next_Char  
Print_Done:
    pop si
    pop di
    pop es
    pop bx
    pop ax
    ret
;}
;=========================================================
;; Game end
;{
Show_GameOver:
	call Screen_Flash_Invert
	call Screen_Flash_Invert
    call clrscr
    call Draw_Fancy_Border
    mov si, msg_footer
    mov di, 3870        
    mov ah, 0x0F
    call Print_String
    
    mov bx, GameOver_Bitmap
    mov cx, 41          ; width = 41
    mov dx, 5           ; height = 5
    
    mov di, 1638        
    mov si, 0x44        ;attribute
    call Draw_Generic_Bitmap
    
    mov si, msg_gameover
    mov di, 3260
    mov ah, 0x07        
    call Print_String
    
    jmp Wait_Restart

Show_Win:
    call clrscr
    call Draw_Fancy_Border
     mov si, msg_footer
    mov di, 3870        
    mov ah, 0x0F
    call Print_String
   
    mov bx, YouWin_Bitmap
    mov cx, 31          ;width=31
    mov dx, 5           ;height = 5
    
    mov di, 1648
    mov si, 0x22        ;attribute
    call Draw_Generic_Bitmap

    mov si, msg_win
    mov di, 3260
    mov ah, 0x07        
    call Print_String    
    jmp Wait_Restart

Wait_Restart:
    mov ah, 00h
    int 16h
    cmp ah, 0x13        ;'r'
    je Restart_Game_Jump
    cmp ah, 0x01        ; ESC
    je Exit_Action1
    jmp Wait_Restart

Restart_Game_Jump:
    mov word [lives], 3
    mov word [score], 0
    mov word [bricks_left], 52
    jmp start
Exit_Action1:
	call clrscr
	mov ax,4C00h
	int 21h
	
Draw_Generic_Bitmap:
    push ax
    push bx
    push cx
    push dx
    push di
    push es
    push bp         
    mov bp, sp     
    mov ax, 0xB800
    mov es, ax

    push dx         ; [bp-2] 
    
    mov dx, di      
    xor di, di      
Row_Gen_Loop:
    push cx         
Col_Gen_Loop:
    mov al, [bx+di] 
    cmp al, 1
    jne Skip_Gen_Pixel
    
    push di         ;save bitmap index
    mov di, dx      
    mov ax, si      ;attribute
    mov ah, al      
    mov al, 0xDB    ;block
    mov [es:di], ax 
    
    pop di          
Skip_Gen_Pixel:
    inc di          ;next byte
    add dx, 2       
    loop Col_Gen_Loop

    pop cx          ;width

    sub dx, cx
    sub dx, cx      ;next line
    add dx, 160     ; DX is now at Start of Next Line
    
    dec word [bp-2] 
    jnz Row_Gen_Loop

    pop dx          
    pop bp          
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
;}
; =========================================================
;; Page 1 & 2 & 3
;{
Draw_Page1:
    call clrscr
    call Draw_Fancy_Border  
    
    ;  (25-7)/2 = 9(row number) ...7 is bitmap height
    ; (80-48)/2 = 16(col number)
    ; (9 * 160) + (16 * 2) = 1440 + 32 = 1472
    mov di, 1472
    call Draw_Bitmap_Pattern   
    mov si, msg_anykey
    mov di, 3250        ; Row 19 (approx)
    mov ah, 0x07        
    call Print_String
    
    mov ah, 00h	;let user press any key
    int 16h
    ret

Draw_Page2:
    call clrscr
    call Draw_Fancy_Border
    
    mov si, msg_header
    mov di, 850       ;5th row
    mov ah, 0x0E        ;golden
    call Print_String
	mov ah, 0x0B        ;sky blue
	;Controls 
    mov si, msg_ctrl_move
    mov di, 1322        ;8th row
    call Print_String 
    mov si, msg_ctrl_pause
    mov di, 1642        ;10th row
    call Print_String
    mov si, msg_ctrl_exit
    mov di, 1962        ;12th row
    call Print_String
    ;Rules
    mov si, msg_goal
    mov di, 2286        ;14th row
   mov ah, 0x0C        ; Light Green
    call Print_String
    mov si, msg_lives_info
    mov di, 2608       ;16th row
    mov ah, 0x0C
    call Print_String
    
    mov si, msg_prompt
    mov di, 3250        ;19th row
    mov ah, 0x07
    call Print_String
    
    mov si, msg_footer
    mov di, 3870        
    mov ah, 0x0F
    call Print_String
    
Page2_Loop:
    mov ah, 00h
    int 16h
    
    cmp ah, 0x1C        ;enter
    je Start_game
    cmp ah, 0x01        ;esc
    je Exit_game
    jmp Page2_Loop
Start_game:
    ret
Exit_game:
	call clrscr
    mov ax, 4C00h
    int 21h
	
Draw_Page3:
    call clrscr
    call Draw_Fancy_Border
	mov si, msg_footer
    mov di, 3870        
    mov ah, 0x0F
    call Print_String
	
    mov si, msg_select
    mov di, 1658       
    mov ah, 0x0E        ;golden
    call Print_String
    
    mov si, msg_easy
    mov di, 2140
    mov ah, 0x0B        ;sky blue
    call Print_String
    mov si, msg_medium
    mov di, 2460
    mov ah, 0x0B       
    call Print_String
    mov si, msg_hard
    mov di, 2780
    mov ah, 0x0B        
    call Print_String
    
Input_Loop3:
    mov ah, 00h
    int 16h             ;let user press 1 2 or 3

    cmp al, '1'
    je Set_Easy
    cmp al, '2'
    je Set_Medium
    cmp al, '3'
    je Set_Hard
    cmp ah, 0x01	;esc
    je Exit_game1 
	
    jmp Input_Loop3 
Set_Easy:
    mov word [ball_speed_limit], 20000 ;high delay
    ret
Set_Medium:
    mov word [ball_speed_limit], 10000  
    ret
Set_Hard:
    mov word [ball_speed_limit], 8000  
    ret
Exit_game1:
	call clrscr
    mov ax, 4C00h
    int 21h

Draw_Bitmap_Pattern:
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push es
    mov ax, 0xB800
    mov es, ax
    mov bx, Title_Bitmap
    mov si, 0
    
    mov dx, di         
    mov cx, 0           
Map_Row_Loop:
    push cx
    mov cx, 48          
Map_Col_Loop:
    mov al, [bx+si]
    cmp al, 1
    jne Draw_Space
    mov word [es:di], 0x0FDB ;white Block
    jmp Next_Map_Pixel
Draw_Space:
    mov word [es:di], 0x0020 ;black Space
Next_Map_Pixel:
    inc si
    add di, 2
    loop Map_Col_Loop

    pop cx
    add dx, 160         ;next line
    mov di, dx
    inc cx
    cmp cx, 7
    jl Map_Row_Loop  
    pop es
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

Draw_Fancy_Border:
    push ax
    push bx
    push cx
    push di
    push es
    mov ax, 0xB800
    mov es, ax
    
    mov ah, 0x0E    ;golden
    mov cx, 80
    mov di, 0       ;top
    mov al, 0xCD    ;double line(horizontal)
    rep stosw   
    mov cx, 80
    mov di, 3840    ;bottom
    rep stosw

    mov cx, 24      ;sides
    mov di, 160     
    mov al, 0xBA    ;(vertical)
Side_Loop1:
    mov [es:di], ax         
    mov [es:di+158], ax     
    add di, 160
    loop Side_Loop1
	
    ;Corners
    mov byte [es:0], 0xC9       
    mov byte [es:158], 0xBB     
    mov byte [es:3840], 0xC8    
    mov byte [es:3998], 0xBC     
    pop es
    pop di
    pop cx
    pop bx
    pop ax
    ret


	;}
; =========================================================
;; Sound
;{
Play_Tone:
    push ax
    push cx
    
    out 42h, al		;load divisor
    mov al, ah
    out 42h, al
    
    in al, 61h		;speaker on
    or al, 3
    out 61h, al  
Wait_Tone:
    loop Wait_Tone
    in al, 61h		;speaker off
    and al, 0FCh
    out 61h, al
    
    pop cx
    pop ax
    ret

Sound_Brick:
    mov ax, 0x0300      ;pitch(high)
    mov cx, 0x1000      ;duration
    call Play_Tone
    ret
Sound_Paddle:
    mov ax, 0x0900      
    mov cx, 0x1500
    call Play_Tone
    ret
Sound_Wall:
    mov ax, 0x0600      
    mov cx, 0x1000
    call Play_Tone
    ret

Screen_Flash_Invert:
    push ax
    push cx
    push di
    push es  
    mov ax, 0xB800
    mov es, ax

    xor di, di
    mov cx, 2000
Flash_On:
    xor byte [es:di+1], 0x40 
    add di, 2
    loop Flash_On
    
    mov cx, 5
    mov ax, 0x1000	;tone
Death_Noise:
    push cx
    mov cx, 0x2000
    call Play_Tone
    add ax, 200
    pop cx
    loop Death_Noise
    
	;reverse now
    xor di, di
    mov cx, 2000
Flash_Off:
    xor byte [es:di+1], 0x40
    add di, 2
    loop Flash_Off
    
    pop es
    pop di
    pop cx
    pop ax
    ret
;}
start:
    call Draw_Page1
	call Draw_Page2
    call Draw_Page3

    call clrscr
    call Print_Boundary
    call Print_Blocks
    call Update_UI

    mov ax, [paddle_x]
    add ax, 3           
    mov [ball_x], ax
    mov word [ball_y], 22
    mov word [ball_dx], 0  
    mov word [ball_dy], -1 ;upward
    call Draw_Paddle
    call Draw_Ball

Game_Loop:
    call Check_Input 
    inc word [ball_timer]
    mov ax, [ball_speed_limit]  
    cmp word [ball_timer], ax   
    jl Game_Loop
    
    mov word [ball_timer], 0
    call Move_Ball
    jmp Game_Loop
	call clrscr
	mov ax,4c00h
	int 21h
	
	
	