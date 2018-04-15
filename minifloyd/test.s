.global main 
	 .file "test.floyd" 
	# Main method. Creates obj instance of the last class and calls its start method 
main: 
	 pushl $8 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	 pushl %eax 
	 call Bobjbasics_start 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
	# CLASS BEGINNIGN HERE 
	# Line 5: x:int
 
	# Line 6: y:int

 
	# Line 8: init() is 
Point_init: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 10: x:=initX 
	# pushl initX 
	 pushl 12(%ebp) 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 8(%ebx) 
	 
 
	# Line 11: y:=initY 
	# pushl initY 
	 pushl 16(%ebp) 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 12(%ebx) 
	 
 
	# Line 12: init:=me 
	 pushl 8(%ebp) 
	# popl init 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 14: end init 
	# Line 15: getX() is 
Point_getX: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 17: getX:=x 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl getX 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 19: end getX 
	# Line 20: getY() is 
Point_getY: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 22: getY:=y 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 12(%ebx) 
	# popl getY 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 24: end getY 
	# Line 25: print() is 
Point_print: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 27: out.writeint(x) 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 28: out.writeint(y) 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 12(%ebx) 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 30: end print 
	# Line 31: setXY() is 
Point_setXY: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 33: out.writeint(newX) 
	# pushl newX 
	 pushl 12(%ebp) 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 34: out.writeint(newY) 
	# pushl newY 
	 pushl 16(%ebp) 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 35: x:=newX 
	# pushl newX 
	 pushl 12(%ebp) 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 8(%ebx) 
	 
 
	# Line 36: y:=newY 
	# pushl newY 
	 pushl 16(%ebp) 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 12(%ebx) 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 38: end setXY 
	# Line 39: setX() is 
Point_setX: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 41: setXY(newX,y) 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 12(%ebx) 
	# pushl newX 
	 pushl 12(%ebp) 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Point_setXY 
	# Clean up parameters: 2 * 4 
	 addl $8, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 43: end setX 
	# Line 44: setY() is 
Point_setY: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 46: y:=newY 
	# pushl newY 
	 pushl 12(%ebp) 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 12(%ebx) 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 48: end setY 
	# CLASS BEGINNIGN HERE 
	# Line 54: start() is 
Bobjbasics_start: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# Line 58: p1:=newPoint 
	 pushl $16 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 2 instance vars to 0 
	 movl $0, 8(%eax) 
	 movl $0, 12(%eax) 
	 pushl %eax 
	# popl p1 
	 popl -8(%ebp) 
	 
 
	# Line 59: p1.init(5,10) 
	 pushl $10 
	 pushl $5 
	# reference to the object 
	# pushl p1 
	 pushl -8(%ebp) 
	 call Point_init 
	# Clean up parameters: 2 * 4 
	 addl $8, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 61: p2:=(newPoint).init(100,200) 
	 pushl $200 
	 pushl $100 
	 pushl $16 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 2 instance vars to 0 
	 movl $0, 8(%eax) 
	 movl $0, 12(%eax) 
	 pushl %eax 
	 call Point_init 
	# Clean up parameters: (2 * 4) + 4 (this ptr) 
	 addl $12, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl p2 
	 popl -12(%ebp) 
	 
 
	# Line 63: p1.print() 
	# reference to the object 
	# pushl p1 
	 pushl -8(%ebp) 
	 call Point_print 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 64: p2.print() 
	# reference to the object 
	# pushl p2 
	 pushl -12(%ebp) 
	 call Point_print 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 66: p1.setX(-5) 
	 pushl $-5 
	# reference to the object 
	# pushl p1 
	 pushl -8(%ebp) 
	 call Point_setX 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 67: p1.print() 
	# reference to the object 
	# pushl p1 
	 pushl -8(%ebp) 
	 call Point_print 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 68: p2.print() 
	# reference to the object 
	# pushl p2 
	 pushl -12(%ebp) 
	 call Point_print 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 71: end start 
