	 .file "loopy.floyd" 
	# Line 2: x:int

 
	 .comm x,4,4 
	# Line 4: start() is 
.global main 
main: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	# Line 6: x:=3 
	 pushl $3 
	 popl x 
	 
 
	# Line 7: if (x>0) then 
	 pushl $0 
	 pushl x 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L1 
	 jmp .L3 
	 .L4: 
	# Line 9: out.writeint(x) 
	 pushl x 
	 call writeint 
	 addl $4, %esp 
	 
 
	# Line 10: x:=x-1 
	 pushl $1 
	 pushl x 
	 call minus 
	 addl $8, %esp 
	 pushl %eax 
	 popl x 
	 
 
	 .L3: 
	# Line 8: x>0 
	 pushl $0 
	 pushl x 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	 pop %eax 
	 cmpl $0, %eax 
	 jne .L4 
	# Line 11: end loop 
	 jmp .L2 
	 .L1: 
	# Line 12: Else 
	# Line 13: out.writeint(999) 
	 pushl $999 
	 call writeint 
	 addl $4, %esp 
	 
 
	 .L2: 
	# Line 15: end if 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 17: end start 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
