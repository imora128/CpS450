	 .file "test.floyd" 
	# Line 2: yo:Test

 
	 .comm yo,4,4 
	# Line 4: boo() is 
boo: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	# Line 6: a:=5 
	 pushl $5 
	# popl a 
	 popl 12(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 7: end boo 
	# Line 8: start() is 
.global main 
main: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	# Line 11: yo:=newTest 
	 pushl $12 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	 pushl %eax 
	 popl yo 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 13: end start 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
