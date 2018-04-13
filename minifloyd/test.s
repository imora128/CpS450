	 .file "test.floyd" 
	# Line 4: z:boolean
 
	 .comm z,4,4 
	# Line 5: start() is 
.global main 
main: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	# Line 8: z:=(1>2)andtrue 
	 pushl $1 
	 pushl $2 
	 pushl $1 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	 call andOp 
	 addl $8, %esp 
	 pushl %eax 
	 popl z 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 10: end start 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
