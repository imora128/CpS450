	 .file "test.floyd" 
	# Line 6: x:int

 
	 .comm x,4,4 
	# Line 8: start1() is 
start1: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	# Line 10: x:=in.readint() 
	 call readint 
	 pushl %eax 
	 
 
	 popl x 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 11: end start1 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
	 .file "test.floyd" 
	# Line 15: x:int
 
	 .comm x,4,4 
	# Line 16: y:int
 
	 .comm y,4,4 
	# Line 17: f:Point
 
	 .comm f,4,4 
	# Line 18: ComputeChange() is 
ComputeChange: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	 push $0 
	# Line 21: ComputeChange:=amt/denom 
	# pushl denom 
	 pushl 12(%ebp) 
	# pushl amt 
	 pushl 8(%ebp) 
	 call division 
	 addl $8, %esp 
	 pushl %eax 
	# popl ComputeChange 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 23: end ComputeChange 
	# Line 24: start() is 
.global main 
main: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	 push $0 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 29: end start 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
