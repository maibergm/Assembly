option casemap:none             ; case sensitive
includelib legacy_stdio_definitions.lib	
extrn printf:near
.data
fq db "a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d sum = %I64d\n"
.code

public  min, p, gcd, q                   ; export function name

min:		mov rax, rcx ; RAX = P0
			cmp rax, rdx ; compare p0 to p1
			jle jump     ; jump if p0 <= p1
			mov rax, rdx         ; if p1 <= p0
			cmp rax, r8  ;compare p1 to p2
			jle done     ; 
			mov rax, r8  ; if p2 is smallest, store in rax to output
			jmp done     ; jump to finish
	jump:	cmp rax, r8  ; compare p0 to p2
			jle done     ; finish if p0 is smallest
			mov rax, r8  ; if p2 is lowest move into rax and finish
	done:	ret		
		
p:			
			sub rsp, 32
			mov rbx, r8
            mov r8, 4 
			call min
			mov r8, rbx
			mov rcx, r9
			mov rdx, rax
			call min
			add rsp, 32
			ret

gcd:		mov r10, rcx ; r10 = A
			mov rax, rdx ; rax = B
			mov r12, rdx
			cmp rax, 0 ; if B == 0, end	
			je fin
			mov r11, rax ; R11 = B
			mov rax, r10 ; rax = A
			xor rdx, rdx
			idiv r11 ;  a % b = RDX = A%B
			mov rcx, rdx ; rcx = i = a % b 
			mov r10, rdx ; r10 = a%b
			mov r11, r12 ; r11 = B
			;R11 = B, R10 = A%B, RCX = I
	redo:	sub rcx, 1 ; i--
			mov rax, r11
			xor rdx, rdx
			idiv rcx ; b / i
			cmp rdx, 0 ; if remainder = 0 = divisor
			je succ1
			jmp redo  ; if not divisor, decrement i and go again
	succ1:  mov rax, r10
			idiv rcx ; a%b / i
			cmp rdx, 0 ; if remainder != 0 , go again
			jne redo   ; if not equal to 0, then not divisor, go again, otherwise store i into rax (its the gcd)
			mov rax, rcx
	fin:	ret
	
q:			push rbx
			push rbp
			mov rbp, rsp
			sub rsp, 56  ; 7 parameters, 7*8=56
			xor r12,r12
			xor r11, r11
			mov r11, [rbp+56]
			add r12, rcx ; a -> r12
			add r12, rdx ; a+b-> r12
			add r12, r8  ; a+b+c -> r12
			add r12, r9  ; a+b+c+d -> r12
			add r12, [rbp+56] ; a+b+c+d+e -> r12
			mov rbx, r12 ; sum -> rbx to peserve across function call
			mov [rsp+48], rbx ; sum -> rsp+48
			mov [rsp+40], r11 ; e->rsp+40
			mov [rsp+32], r9  ; d->rsp+32
			mov r9, r8   ; c->r9
			mov r8,rdx   ; b->r8
			mov rdx, rcx ; a->rdx
			lea rcx, fq  ; fq->rcx
			call printf
			mov rax, rbx ; sum -> rax to output
			add rsp, 56 ; deallocate shadow space
			pop rbx
			pop rbp
			ret
			
			end
		
		