	 .file "test.floyd" 
	# Line 2: a:int
 
	# Line 3: b:int
 
	# Line 4: testFunc() is 
Point_testFunc: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 6: out.writeint(1) 
	 pushl $1 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 7: end testFunc 
	# Line 8: setA() is 
Point_setA: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 1 locals 
	 pushl $0 
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
	# Line 13: end setA 
	# Line 14: getA() is 
Point_getA: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 1 locals 
	 pushl $0 
	# Line 17: getA:=a 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl getA 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 19: end getA 
	# Line 20: getB() is 
Point_getB: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 1 locals 
	 pushl $0 
	# Line 23: getB:=b 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 12(%ebx) 
	# popl getB 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 25: end getB 
	# Line 29: a:int
 
	# Line 30: b:int
 
	# Line 31: c:int
 
	# Line 32: d:int
 
	# Line 33: start1() is 
Another_start1: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 35: out.writeint(5) 
	 pushl $5 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 36: end start1 
	# Line 41: testFunc() is 
Testing_testFunc: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 43: testFunc:=1337 
	 pushl $1337 
	# popl testFunc 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 45: end testFunc 
	# Line 46: boo() is 
Testing_boo: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 48: testFunc:=12 
	 pushl $12 
	# popl testFunc 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 50: end boo 
	# Line 51: start() is 
.global main 
main: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 4 locals 
	 pushl $0 
	# making space for 4 locals 
	 pushl $0 
	# making space for 4 locals 
	 pushl $0 
	# making space for 4 locals 
	 pushl $0 
	# Line 58: poo:=newAnother 
	 pushl $24 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 4 instance vars to 0 
	 movl $0, 8(%eax) 
	 movl $0, 12(%eax) 
	 movl $0, 16(%eax) 
	 movl $0, 20(%eax) 
	 pushl %eax 
	# popl poo 
	 popl -16(%ebp) 
	 
 
	# Line 59: x:=newPoint 
	 pushl $16 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 2 instance vars to 0 
	 movl $0, 8(%eax) 
	 movl $0, 12(%eax) 
	 pushl %eax 
	# popl x 
	 popl -8(%ebp) 
	 
 
	# Line 60: out.writeint(x.getA()) 
	# pushl x 
	 pushl -8(%ebp) 
	 call Point_getA 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 61: out.writeint(x.getB()) 
	# pushl x 
	 pushl -8(%ebp) 
	 call Point_getB 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 62: x.setA(5) 
	 pushl $5 
	# reference to the object 
	# pushl x 
	 pushl -8(%ebp) 
	 call Point_setA 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 63: out.writeint(x.getA()) 
	# pushl x 
	 pushl -8(%ebp) 
	 call Point_getA 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 65: end start 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
