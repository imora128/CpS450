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
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl getA 
	 popl -4(%ebp) 
	 
 
	# Line 16: out.writeint(a) 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 18: end getA 
	# Line 22: testFunc() is 
Testing_testFunc: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 push $0 
	# Line 24: out.writeint(5) 
	 pushl $5 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 26: end testFunc 
	# Line 27: start() is 
.global main 
main: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 push $0 
	# making space for 3 locals 
	 push $0 
	# making space for 3 locals 
	 push $0 
	# making space for 3 locals 
	 push $0 
	# Line 32: z:=123 
	 pushl $123 
	# popl z 
	 popl -16(%ebp) 
	 
 
	# Line 33: out.writeint(z) 
	# pushl z 
	 pushl -16(%ebp) 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 34: x:=newPoint 
	 pushl $16 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	 pushl %eax 
	# popl x 
	 popl -8(%ebp) 
	 
 
	# Line 35: p:=newPoint 
	 pushl $16 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	 pushl %eax 
	# popl p 
	 popl -12(%ebp) 
	 
 
	# Line 36: p.setA(2) 
	 pushl $2 
	# reference to the object 
	# pushl p 
	 pushl -12(%ebp) 
	 call Point_setA 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 37: x.setA(99) 
	 pushl $99 
	# reference to the object 
	# pushl x 
	 pushl -8(%ebp) 
	 call Point_setA 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 38: p.getA() 
	# reference to the object 
	# pushl p 
	 pushl -12(%ebp) 
	 call Point_getA 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 39: x.getA() 
	# reference to the object 
	# pushl x 
	 pushl -8(%ebp) 
	 call Point_getA 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 40: out.writeint(z) 
	# pushl z 
	 pushl -16(%ebp) 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 41: testFunc() 
	 call Testing_testFunc 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 42: end start 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
