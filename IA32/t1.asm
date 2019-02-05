.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive
.data
public g
g      DWORD   4
.code


public      min                     ; min(p0, p1, p2)

min:        push    ebp             ; push frame pointer
            mov     ebp, esp        ; update ebp
			mov 	eax, [ebp + 8]  ; eax = p0
			cmp		eax, [ebp + 12] ; p0 <= p1
			jle		jump
			mov		eax, [ebp + 12] ; eax = p1
			cmp		eax, [ebp + 16] ; p1 <= p2
			jle		done
			mov		eax, [ebp + 16] ; eax = p2
			jmp		done
	jump:	cmp 	eax, [ebp + 16] ; p0 <= p2
			jle		done
			mov		eax, [ebp + 16] ; eax = p2
	done:   mov		esp, ebp     	; restore esp
			pop     eax
			pop		ebp				; restore ebp 
			ret		0				; return
            

    
	
public      p

p:  		push 	ebp
			mov		ebp, esp	
			push	[ebp+8]         ;push value at location ebp+8
			push	[ebp+12]		;push value at location ebp+12
			push 	g				;push value of g
			call	min				;feed into function min
			push	[ebp+16]		;push value at location ebp+16
			push	[ebp+20]		;push value at location ebp+20
			push	eax				;push value outputted from first call of min
			call	min				;feed values into min
			mov		esp,ebp
			pop		ebp		
			ret		0
			


public      gcd

gcd:	   push		ebp
		   mov		ebp, esp
		   sub		esp, 8
		   mov		eax, [edp+12] ; eax = b
		   mov		ecx, [edp+8]  ; ecx = a
		   cmp		eax, 0        ; if b == 0
		   je		done
		   idiv		ecx, eax      ; ecx = a% b
		   mov		[edp-4], edx  ; EDP - 4 = A % B
		   mov		[edp-8], eax  ; edp-8 = B
	       mov		ecx, [edp+12] ; ecx = I
    redo:  sub      ecx, 1		  ; I--
		   mov		eax, [edp-8]  ; STORE B INTO EAX FOR DIVISION
		   idiv     ecx           ; DIVIDE B BY I
		   cmp		edx, 0        ; IF REMAINDER IS 0, IT MEANS ITS DIVISIBLE SO JUMP TO SECOND CHECK
		   je		succ1
		   jmp		redo
	succ1: mov		eax, [edp-4]  ;STIRE A%B INTO EAX FOR DIVISION
	       idiv	    ecx          ; DIVIDE A BY I
		   cmp      edx, 0
		   jne		redo         ;GO AGAIN IF NO MATCH OR CONTINUE IF DIVISIBLE, GCD IS FOUND
	done   mov		eax, ecx
		   mov		esp, ebp
		   pop      eax
		   pop      ecx
		   pop      edx
		   pop 		ebp
		   ret 		0 




end
