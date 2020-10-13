INCLUDE Irvine32.inc
.DATA

	Edit   dword 9 dup(?)
		   dword 9 dup(?)
		   dword 9 dup(?)
		   dword 9 dup(?)
		   dword 9 dup(?) 
		   dword 9 dup(?)
		   dword 9 dup(?)
		   dword 9 dup(?)
		   dword 9 dup(?)


	Solved dword 9 dup(?)
		   dword 9 dup(?)
		   dword 9 dup(?)
		   dword 9 dup(?)
		   dword 9 dup(?) 
		   dword 9 dup(?)
		   dword 9 dup(?)
		   dword 9 dup(?)
		   dword 9 dup(?)


  Unsolved dword 9 dup(?)
		   dword 9 dup(?)
		   dword 9 dup(?)
		   dword 9 dup(?)
		   dword 9 dup(?) 
		   dword 9 dup(?)
		   dword 9 dup(?)
		   dword 9 dup(?)
		   dword 9 dup(?)


	board_size = 81
	board_size_WG = 99

	;***with_garbadge_array1
	board_1_unsolved_WG BYTE board_size_WG DUP(?) 
	board_1_unsolved byte board_size Dup(?)       

	;***without_garbadge_array1
	board_1_solved_WG BYTE board_size_WG  DUP(?)   
	board_1_solved byte board_size Dup(?) 

    tempout    dword ?
	temp       dword ?
	tempColor  dword ?
	count      dword 0
	correct    dword 0
	incorrect  dword 0

	str1 byte " Please Enter Row Number    : ",0
	str2 byte " Please Enter Column Number : ",0
	str3 byte " Please Enter The Value     : ",0 

	Row dword ?
	Column dword ?
	Num dword ?

	Counter     byte  "The Missing Number Of Steps	= ",0
	Correct_S   byte  "The Number Of Correct Solutions = ",0
	Incorrect_S byte  "The Number Of Incorrect Solutions  = ",0
	Duration    byte  "The Time to complete the entire board = ",0
	second    byte  " seconds",0

	Index   byte 0
	Numbers byte "   1 2 3   4 5 6   7 8 9",0 
	valid byte "                   ----   I N V A L I D     C H O I C E   ----",0 
	Bool_valid byte 0

	Choice  byte " Please Enter Your Choice : ",0
	string1 byte " Press [1] print the finished board.",0
	string2 byte " Press [2] to clear the board to the initial Sudoku board.",0
	string3 byte " Press [3] to edit a single cell in the board.",0
	string4 byte " Press [4] Save and exit.",0

	string5 byte "                  *  INCORRECT SOLUTION  *",0
	string6 byte "                  *   CORRECT SOLUTION  *",0
	msg byte 0
	
	stringwelc byte  "                         WELCOME TO SUDOKU GAME.",0
	stringend byte  "                   -   Y O U     A R E    W E L C O M E.  - ",0
	string7 byte  "                        1  -  to enter easy level",0
	string8 byte  "                        2  -  to enter medium level",0
	string9 byte  "                        3  -  to enter hard level",0
	string11 byte  "                        4  -  to continue last played game",0
	string10 byte "                        5  -  to exit",0
	Choice2  byte "                         Enter Your Choice  : ",0

	copyTo DWORD ?
	SKIP byte ?
	remaining byte 0

	files_unsolved  byte "diff_1_1.txt",0
				    byte "diff_1_2.txt",0
				    byte "diff_1_3.txt",0
				    byte "diff_2_1.txt",0
				    byte "diff_2_2.txt",0
				    byte "diff_2_3.txt",0
				    byte "diff_3_1.txt",0
				    byte "diff_3_2.txt",0
				    byte "diff_3_3.txt",0
		 
	files_solved   byte "diff_1_1_solved.txt",0
				   byte "diff_1_2_solved.txt",0
				   byte "diff_1_3_solved.txt",0
			       byte "diff_2_1_solved.txt",0
				   byte "diff_2_2_solved.txt",0
			       byte "diff_2_3_solved.txt",0
				   byte "diff_3_1_solved.txt",0
				   byte "diff_3_2_solved.txt",0
				   byte "diff_3_3_solved.txt",0


    boolarray dword 9 dup(0)
		      dword 9 dup(0)
		      dword 9 dup(0)
		      dword 9 dup(0)
	          dword 9 dup(0)
		      dword 9 dup(0)
		      dword 9 dup(0)
		      dword 9 dup(0)
		      dword 9 dup(0)
			
			bool_index dword ?
			startTime DWORD ?

			randomvalue dword ?
		
.code
main PROC

	CALL STARTGAME 
	CALL endgame

    exit
main ENDP

toRed PROC
	
	mov tempColor,eax
	mov eax,red
	CALL SetTextColor
	mov eax,tempColor
RET
toRed ENDP

toGreen PROC
	mov tempColor,eax
	mov eax,green
	CALL SetTextColor
	mov eax,tempColor
RET
toGreen ENDP

toBlue PROC
	mov tempColor,eax
	mov eax,blue
	CALL SetTextColor
	mov eax,tempColor
RET
toBlue ENDP

toWhite PROC
mov tempColor,eax
	mov eax,white
	CALL SetTextColor
	mov eax,tempColor
RET
toWhite ENDP

MENU PROC

	BeginWhile :
	      cmp remaining , 0
		  jne cont1
		     jmp endwhile
		  cont1:
	      CALL CLRSCR
		  CALL DISPLAY 
		  CALL CRLF 
		  cmp msg, 1
		  jne two 
		    CALL toGreen
		    mov edx ,offset string6
			INC Correct 
		    CALL WriteString   
			jmp cont
		  two:
		  cmp msg , 2
		  jne cont
		    CALL toRed
		    mov edx ,offset string5
			INC Incorrect  
		    CALL WriteString
          cont :
		  CALL toWhite
		  CALL CRLF 
		  CALL CRLF
		  mov edx ,offset string1 
		  CALL WriteString 
		  CALL CRLF
		  mov edx ,offset string2 
		  CALL WriteString 
		  CALL CRLF
		  mov edx ,offset string3 
		  CALL WriteString 
		  CALL CRLF
		  mov edx ,offset string4
		  CALL WriteString 
		  CALL CRLF
		  mov edx ,offset choice 
		  CALL WriteString 
		  CALL ReadInt
		  CALL CRLF
	      
		  cmp eax , 1
		  jne lab1 
			CALL FINAL_BOARD
		  jmp EndWhile
		  lab1 :

		  cmp eax , 2
		  jne lab2
			CALL StartOver
		  jmp BeginWhile
		  lab2 :

		  cmp eax , 3
		  jne lab3
		    CALL CRLF
			CALL Input
		  jmp BeginWhile
		  lab3 :

		  cmp eax , 4
		  jmp endwhile   

	endwhile :
	
RET
MENU ENDP

input PROC 

   mov edx ,offset str1 
   CALL writeString 
   CALL ReadInt
   mov row,eax
   mov edx ,offset str2 
   CALL writeString 
   CALL ReadInt
   mov column ,eax
   mov edx ,offset str3 
   CALL writeString 
   CALL ReadInt
   mov num ,eax

   mov eax  , lengthof Solved
   dec row
   mul row 
   add eax,column
   dec eax
   mov temp ,eax
   
   ;EAX carry index value
   
   mov esi , offset Edit
   mov edx , type Edit
   mul edx
   add esi,eax

   mov eax ,temp
   mov edi , offset Solved
   mov edx , type Solved
   mul edx
   add edi,eax
  
   mov edx,[edi]
   cmp edx , num
   jne notequal
	  	mov msg , 1
		mov eax ,num
	    mov [esi],eax
		dec remaining
		jmp cont
   notequal:
        mov ecx , offset Solved
        sub edi , ecx
		mov msg , 2
		mov boolarray[edi], 1
   cont :
   
RET
INPUT ENDP


DISPLAY PROC 

	mov index , 0  
    mov ecx,lengthof Edit
    mov eax,0 
	mov esi,offset Edit
    mov edx ,offset Numbers
    CALL WriteString
    CALL CRLF

    outer:
	  
	    mov tempout,ecx
		mov ecx , lengthof Edit	
		CALL DISPLAY_SPACES

			inner:
				mov eax , [esi]  
				CALL writeDec
				mov al, '|'
				CALL writechar
				add esi,type Solved
		    	mov ebx , 7
		    	cmp ebx, ecx
			    jne space2
				CALL spaceboard
		        space2 :
			    mov ebx , 4
			    cmp ebx, ecx
			    jne space1
		        cmp ebx, ecx
			    jne space1
				CALL spaceboard
		        space1 :
		   	loop inner
			
		CALL crlf
		mov ecx,tempout
		mov ebx , 7
		cmp ebx, ecx
		jne space3
		CALL crlf
		space3 :
		mov ebx , 4
		cmp ebx, ecx
		jne space4
		CALL crlf
		space4 :

	loop outer
	CALL CRLF

RET 
DISPLAY ENDP

DISPLAY_SPACES PROC   	    
		
		inc index 
		mov al ,index 
		CALL WriteDec 
		mov al, ' '
	    CALL writechar 
		mov al, '|'
	    CALL writechar 
RET
DISPLAY_SPACES ENDP 

FINAL_BOARD PROC 
  

	CALL CLRSCR
	mov count ,0
	mov Index , 0
	mov ecx,lengthof Edit
	mov eax,0
   
	mov esi,offset Edit
	mov edi,offset Solved
   
	mov edx ,offset Numbers
	CALL WriteString
	CALL CRLF
    
    outer:
	  
	    mov tempout,ecx
		mov ecx , lengthof Edit	
		CALL DISPLAY_SPACES

			inner: 
			    CALL CHECK
				mov al, '|'
				CALL writechar
				add edi,type Solved
				add esi,type Solved
			    mov ebx , 7
				cmp ebx, ecx
				jne space2
				CALL spaceboard
		    space2 :
			    mov ebx , 4
			    cmp ebx, ecx
			    jne space1
		    cmp ebx, ecx
			jne space1
				CALL spaceboard
		    space1 :
		   	loop inner
			;
			CALL crlf
			mov ecx,tempout
			mov ebx , 7
			cmp ebx, ecx
			jne space3
				CALL crlf
		    space3 :

			mov ebx , 4
			cmp ebx, ecx
			jne space4
				CALL crlf
		    space4 :

		loop outer
		CALL SPACELINE
	mov edx ,offset counter
	CALL WriteString
	mov edx ,81
	sub  edx,count 
	mov eax ,edx
	CALL writeDec
	CALL SPACELINE

	mov edx ,Offset Correct_S
	CALL WriteString
    mov eax ,Correct
	CALL writeDec
	CALL SPACELINE
    mov edx ,Offset Incorrect_S
	CALL WriteString
    mov eax ,Incorrect
	CALL writeDec
	
	mov Correct,0
	mov Incorrect ,0
	INVOKE GetTickCount
    sub eax , startTime
 	mov ecx , 1000
	mov edx , 0 
	div ecx
	CALL SPACELINE
	mov edx ,offset Duration
	CALL WriteString
    CALL WriteDec 
	mov edx , offset second
	CALL WriteString
	CALL SPACELINE
	CALL Waitmsg

RET
FINAL_BOARD  ENDP

CHECK PROC	
 
    mov eax,[edi] 
	cmp eax,[esi]
	jne equal
		add count,1
		jmp Next					
	equal:

    mov bool_index , esi
	sub bool_index , offset Edit

	mov ebx,0
	cmp [esi],ebx
	jne next
	    
		mov edx ,bool_index
	    cmp boolarray[edx] , 1
		jne cont
		   CALL toRed
		   jmp next
        cont :
		CALL toBlue
		jmp notBlue
	Next:
	notBlue:
	mov eax , [edi]
	
	CALL writeDec
	CALL toWhite

RET 
CHECK ENDP

SPACEBOARD PROC

	mov al, ' '
	CALL writechar
	mov al, '|'
    CALL writechar

RET 
SPACEBOARD ENDP

SPACELINE PROC

	CALL CRLF
	CALL CRLF
	CALL CRLF

RET 
SPACELINE ENDP

STARTOVER PROC
    
	mov ecx , lengthof Unsolved	
	mov esi , offset Edit
	mov edi ,  0
	outer :
	   
		mov ebx , ecx
		mov ecx , lengthof Unsolved

		inner :
			 mov edx   , Unsolved [edi]
			 cmp edx , 0
			 jne cont
			    inc remaining
			 cont :
		     mov [esi] , edx 
	         add esi , type Edit
	         add edi , type Unsolved
		loop inner
		
		mov ecx , ebx

	loop outer
RET
STARTOVER ENDP

SOlVED_BOARD_1 proc

    call openinputfile
	mov edx,offset board_1_solved_WG
	mov ecx, board_size_WG
	call readfromfile

	mov ecx,9
	mov ebx,0
	mov edx,0
	mov esi,0
    outer_loop_2:

    push ecx
	mov ecx,9

	inner_loop_2:

	mov al,board_1_solved_WG[edx]
	and al,11001111b

	push edx
	mov edx,copyTo
	mov  [edx],eax
	pop edx
	add   Copyto  ,4

	mov board_1_solved[ebx],al
	inc ebx
	add esi,4

	inc edx

	loop inner_loop_2
	cmp skip,1 
	je skipLine
		add edx,2
	skipLine:
	pop ecx

	loop outer_loop_2
	
RET
SOlVED_BOARD_1 ENDP

STARTGAME PROC

	BeginWhile :
	
	    CALL clrscr    
		mov eax , 3h
		CALL settextcolor
		CALL SPACELINE
		mov edx ,offset stringwelc 
		CALL WriteString 
		CALL SPACELINE
		mov edx ,offset string7 
		CALL WriteString 
		CALL SPACELINE
		mov edx ,offset string8 
		CALL WriteString 
		CALL SPACELINE
		mov edx ,offset string9 
		CALL WriteString 
		CALL SPACELINE
		mov edx ,offset string11
		CALL WriteString 
		CALL SPACELINE
		mov edx ,offset string10 
		CALL WriteString 
		CALL SPACELINE
		cmp bool_valid , 1
		jne cont
		mov edx ,offset valid 
		CALL WriteString 
		CALL SPACELINE
		cont :
		mov edx ,offset Choice2 
		CALL WriteString 
		CALL ReadInt
	    CALL toWhite
		cmp al, 1
		jne two


		   mov randomvalue , eax
		   call randomize
		   mov eax , 3
		   call randomrange
		   mov randomvalue , eax
		   mov edi , 13
		   mul edi  
		   mov edx , offset files_unsolved
		   add edx , eax
		   mov Copyto ,offset UnSolved
		   CALL SOlVED_BOARD_1
		   mov edi , 20
		   mul edi  
		   mov edx , offset files_solved
		   add edx , eax
		   mov Copyto ,offset solved 
		   CALL SOlVED_BOARD_1

		   CALL STARTOVER
		   INVOKE GetTickCount 
		   mov startTime,eax
		   CALL MENU
		   call final_board
		   jmp endwhile	
		two :
		cmp al, 2
		jne three
		   
		   mov randomvalue , eax
		   call randomize
		   mov eax , 3
		   call randomrange
		   mov randomvalue , eax
		   mov edi , 13
		   mul edi
		   add edi , 39
		   mov edx , offset files_unsolved
		   add edx , eax
		   mov Copyto ,offset UnSolved
		   CALL SOlVED_BOARD_1
		   mov edi , 19
		   mul edi  
		   add edi , 60
		   mov edx , offset files_solved
		   add edx , eax
		   mov Copyto ,offset solved 
		   CALL SOlVED_BOARD_1
		  
		   CALL STARTOVER
		   INVOKE GetTickCount 
		   mov startTime,eax
		   CALL MENU	
		   call final_board
		   jmp endwhile	
		three :
		cmp al,3 
		jne four
		   mov randomvalue , eax
		   call randomize
		   mov eax , 3
		   call randomrange
		   mov randomvalue , eax
		   mov edi , 13
		   mul edi
		   add edi , 78
		   mov edx , offset files_unsolved
		   add edx , eax
		   mov Copyto ,offset UnSolved
		   CALL SOlVED_BOARD_1
		   mov edi , 19
		   mul edi  
		   add edi , 120
		   mov edx , offset files_solved
		   add edx , eax
		   mov Copyto ,offset solved 
		   CALL SOlVED_BOARD_1

		   CALL STARTOVER
		   INVOKE GetTickCount 
		   mov startTime,eax
		   CALL MENU
		   call final_board
		   jmp endwhile	
		four :
		cmp al,4 
		jne five
			;kiro
			CALL STARTOVER
			INVOKE GetTickCount 
			mov startTime,eax
		    CALL MENU
			jmp endwhile
		five :
		cmp al,5 
		    jne invalid
	        jmp endwhile	 
		invalid:
		   mov bool_valid , 1 
		jmp beginwhile

  endwhile:

	
RET
STARTGAME ENDP

ENDGAME PROC

    CALL CLRSCR
	CALL SPACELINE
	CALL SPACELINE
	CALL toGreen
	mov edx ,offset stringend
	CALL WriteString
	CALL toWhite
	CALL SPACELINE
	CALL SPACELINE
	CALL SPACELINE
	CALL SPACELINE

RET
ENDGAME ENDP
END main