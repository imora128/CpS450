	 .file "test.floyd" 
	# Line 8: x:int
 
	 .comm x,4,4 
	# Line 9: y:int
 
	 .comm y,4,4 
	# Line 10: f:Point
 
	 .comm f,4,4 
	# Line 11: b:boolean
 
	 .comm b,4,4 
	# Line 12: ComputeChange() is 
ComputeChange: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	 push $0 
	# Line 15: ComputeChange:=amt/denom 
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
	# Line 16: end ComputeChange 
	# Line 17: testing() is 
testing: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	# Line 19: x:=5 
	 pushl $5 
	 popl x 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 21: end testing 
	# Line 22: start() is 
.global main 
main: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	 push $0 
	# Line 25: testing() 
	 call testing 
	 
 
	# Line 26: x:=ComputeChange(1,1) 
	 pushl $1 
	 pushl $1 
	 call ComputeChange 
	 addl $8, %esp 
	 pushl %eax 
	 
 
	# popl x 
	 popl -8(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 28: end start 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
	 .file "test.floyd" 
	# Line 32: x:int
 
	 .comm x,4,4 
	# Line 33: y:Point
 
	 .comm y,4,4 
	# Line 34: start1() is 
start1: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	# Line 36: x:=in.readint() 
	 call readint 
	 pushl %eax 
	 
 
	 popl x 
	 
 
	# Line 37: x:=y.ComputeChange(1,1) 
	 pushl y 
	 pushl $1 
	 pushl $1 
	 call ComputeChange 
	 addl $8, %esp 
	 pushl %eax 
	 
 
	 popl x 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 38: end start1 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
