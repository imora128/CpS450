.global main 
	 .file "test.floyd" 
	# Main method. Creates obj instance of the last class and calls its start method 
main: 
	 pushl $12 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 1 instance vars to 0 
	 movl $0, 8(%eax) 
	 pushl %eax 
	 call Test_start 
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
	# Line 33: x:=newX 
	# pushl newX 
	 pushl 12(%ebp) 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 8(%ebx) 
	 
 
	# Line 34: y:=newY 
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
	# Line 36: end setXY 
	# Line 37: setX() is 
Point_setX: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 39: setXY(newX,y) 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 12(%ebx) 
	# pushl newX 
	 pushl 12(%ebp) 
	 call Point_setXY 
	# Clean up parameters: 2 * 4 
	 addl $8, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 41: end setX 
	# Line 42: setY() is 
Point_setY: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 44: y:=newY 
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
	# Line 46: end setY 
	# Line 47: start() is 
Point_start: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 49: out.writeint(5) 
	 pushl $5 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 51: end start 
	# CLASS BEGINNIGN HERE 
	# Line 55: kkkk:Point
 
	 movl $0, 8(%ebp) 
	# Line 56: start() is 
Test_start: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# Line 60: z:=5 
	 pushl $5 
	# popl z 
	 popl -12(%ebp) 
	 
 
	# Line 61: p:=newPoint 
	 pushl $16 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 2 instance vars to 0 
	 movl $0, 8(%eax) 
	 movl $0, 12(%eax) 
	 pushl %eax 
	# popl p 
	 popl -8(%ebp) 
	 
 
	# Line 62: p.setXY(5,4) 
	 pushl $4 
	 pushl $5 
	# reference to the object 
	# pushl p 
	 pushl -8(%ebp) 
	 call Point_setXY 
	# Clean up parameters: 2 * 4 
	 addl $8, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 63: p.print() 
	# reference to the object 
	# pushl p 
	 pushl -8(%ebp) 
	 call Point_print 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 64: kkkk:=newPoint 
	 pushl $16 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 2 instance vars to 0 
	 movl $0, 8(%eax) 
	 movl $0, 12(%eax) 
	 pushl %eax 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 8(%ebx) 
	 
 
	# Line 65: if kkkk=null then 
	 pushl $0 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L1 
	# Line 67: out.writeint(1000) 
	 pushl $1000 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	 jmp .L2 
	 .L1: 
	# Line 68: Else 
	# Line 69: out.writeint(2000) 
	 pushl $2000 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	 .L2: 
	# Line 70: end if 
	# Line 72: out.writeint(9999) 
	 pushl $9999 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 73: out.writeint(z) 
	# pushl z 
	 pushl -12(%ebp) 
	# reference to the object 
	 call writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 74: end start 
