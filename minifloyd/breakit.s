	 .file "breakit.floyd" 
	# Line 2: mov:int
 
	 .comm mov,4,4 
	# Line 3: x:int
 
	 .comm x,4,4 
	# Line 4: y:int

 
	 .comm y,4,4 
	# Line 6: start() is 
.global main 
main: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	# Line 9: mov:=12*in.readint() 
	 pushl $12 
	 call readint 
	 pushl %eax 
	 
 
	 call times 
	 addl $8, %esp 
	 pushl %eax 
	 popl mov 
	 
 
	# Line 10: out.writeint(mov) 
	 pushl mov 
	 call writeint 
	 addl $4, %esp 
	 
 
	# Line 12: mov:=mov/-1 
	 pushl $-1 
	 pushl mov 
	 call division 
	 addl $8, %esp 
	 pushl %eax 
	 popl mov 
	 
 
	# Line 13: out.writeint(mov) 
	 pushl mov 
	 call writeint 
	 addl $4, %esp 
	 
 
	# Line 15: mov:=mov*-1 
	 pushl mov 
	 pushl $-1 
	 call times 
	 addl $8, %esp 
	 pushl %eax 
	 popl mov 
	 
 
	# Line 16: out.writeint(mov) 
	 pushl mov 
	 call writeint 
	 addl $4, %esp 
	 
 
	# Line 18: if (true) then 
	 pushl $1 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L1 
	# Line 19: x:=1 
	 pushl $1 
	 popl x 
	 
 
	 jmp .L3 
	 .L4: 
	# Line 21: y:=2 
	 pushl $2 
	 popl y 
	 
 
	 jmp .L5 
	 .L6: 
	# Line 23: y:=y-1 
	 pushl $1 
	 pushl y 
	 call minus 
	 addl $8, %esp 
	 pushl %eax 
	 popl y 
	 
 
	# Line 24: if not(y>=0) then 
	 pushl $0 
	 pushl y 
	 call greaterEqual 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L7 
	# Line 25: out.writeint(y) 
	 pushl y 
	 call writeint 
	 addl $4, %esp 
	 
 
	 jmp .L8 
	 .L7: 
	 .L8: 
	# Line 26: end if 
	 .L5: 
	# Line 22: y>-2 
	 pushl $-2 
	 pushl y 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	 pop %eax 
	 cmpl $0, %eax 
	 jne .L6 
	# Line 27: end loop 
	# Line 28: out.writeint(x) 
	 pushl x 
	 call writeint 
	 addl $4, %esp 
	 
 
	# Line 29: x:=x+1 
	 pushl x 
	 pushl $1 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	 popl x 
	 
 
	 .L3: 
	# Line 20: not(x>3) 
	 pushl $3 
	 pushl x 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 pop %eax 
	 cmpl $0, %eax 
	 jne .L4 
	# Line 30: end loop 
	 jmp .L2 
	 .L1: 
	 .L2: 
	# Line 31: end if 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 33: end start 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
