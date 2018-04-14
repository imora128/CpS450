	 .file "test.floyd" 
	# Line 2: a:int
 
	# Line 3: b:int




 
	# Line 8: setA() is 
Point_setA: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 push $0 
	# making space for 1 locals 
	 push $0 
	# Line 11: a:=newA 
	# pushl newA 
	 pushl 12(%ebp) 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 8(%ebx) 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 12: end setA 
	# Line 13: getA() is 
Point_getA: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 push $0 
	# Line 15: getA:=a 
	 pushl a 
	# popl getA 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 17: end getA 
	# Line 26: start() is 
.global main 
main: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 push $0 
	# making space for 1 locals 
	 push $0 
	# Line 29: x:=newPoint 
	 pushl $16 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	 pushl %eax 
	# popl x 
	 popl -8(%ebp) 
	 
 
	# Line 30: x.setA(55) 
	 pushl $55 
	# reference to the object 
	# pushl x 
	 pushl -8(%ebp) 
	 call Point_setA 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this pushed on last: 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 31: end start 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
