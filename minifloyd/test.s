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
	# Line 12: writechar() is 
Writer_writechar: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 14: io_write(char) 
	# pushl char 
	 pushl 12(%ebp) 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 15: writechar:=me 
	 pushl 8(%ebp) 
	# popl writechar 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 19: end writechar 
	# Line 20: writeintHelper() is 
Writer_writeintHelper: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 1 locals 
	 pushl $0 
	# Line 23: digit:=num-(num/10)*10 
	 pushl $10 
	# pushl num 
	 pushl 12(%ebp) 
	 call division 
	 addl $8, %esp 
	 pushl %eax 
	 pushl $10 
	 call times 
	 addl $8, %esp 
	 pushl %eax 
	# pushl num 
	 pushl 12(%ebp) 
	 call minus 
	 addl $8, %esp 
	 pushl %eax 
	# popl digit 
	 popl -8(%ebp) 
	 
 
	# Line 24: if num/10>0 then 
	 pushl $0 
	 pushl $10 
	# pushl num 
	 pushl 12(%ebp) 
	 call division 
	 addl $8, %esp 
	 pushl %eax 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L1 
	# Line 25: writeintHelper(num/10) 
	 pushl $10 
	# pushl num 
	 pushl 12(%ebp) 
	 call division 
	 addl $8, %esp 
	 pushl %eax 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_writeintHelper 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	 jmp .L2 
	 .L1: 
	 .L2: 
	# Line 26: end if 
	# Line 27: io_write(digit+48) 
	# pushl digit 
	 pushl -8(%ebp) 
	 pushl $48 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 30: end writeintHelper 
	# Line 31: writeint() is 
Writer_writeint: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 33: if (num=0) then 
	 pushl $0 
	# pushl num 
	 pushl 12(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L3 
	# Line 34: io_write(48) 
	 pushl $48 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	 jmp .L4 
	 .L3: 
	# Line 35: Else 
	# Line 36: if not(num>=0) then 
	 pushl $0 
	# pushl num 
	 pushl 12(%ebp) 
	 call greaterEqual 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L5 
	# Line 37: io_write(45) 
	 pushl $45 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 38: num:=-num 
	# pushl num 
	 pushl 12(%ebp) 
	 call unaryMinus 
	 addl $4, %esp 
	 pushl %eax 
	# popl num 
	 popl 12(%ebp) 
	 
 
	 jmp .L6 
	 .L5: 
	 .L6: 
	# Line 39: end if 
	# Line 40: writeintHelper(num) 
	# pushl num 
	 pushl 12(%ebp) 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_writeintHelper 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	 .L4: 
	# Line 41: end if 
	# Line 43: io_write(13) 
	 pushl $13 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 44: io_write(10) 
	 pushl $10 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 46: writeint:=me 
	 pushl 8(%ebp) 
	# popl writeint 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 72: end writeint 
	# CLASS BEGINNIGN HERE 
	# Line 80: x:int
 
	# Line 81: y:int

 
	# Line 83: init() is 
Point_init: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 85: x:=initX 
	# pushl initX 
	 pushl 12(%ebp) 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 8(%ebx) 
	 
 
	# Line 86: y:=initY 
	# pushl initY 
	 pushl 16(%ebp) 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 12(%ebx) 
	 
 
	# Line 87: init:=me 
	 pushl 8(%ebp) 
	# popl init 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 89: end init 
	# Line 90: getX() is 
Point_getX: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 92: getX:=x 
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
	# Line 94: end getX 
	# Line 95: getY() is 
Point_getY: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 97: getY:=y 
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
	# Line 99: end getY 
	# Line 100: print() is 
Point_print: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 102: out.writeint(x) 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 103: out.writeint(y) 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 12(%ebx) 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 105: end print 
	# Line 106: setXY() is 
Point_setXY: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 108: out.writeint(newX) 
	# pushl newX 
	 pushl 12(%ebp) 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 109: out.writeint(newY) 
	# pushl newY 
	 pushl 16(%ebp) 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 110: x:=newX 
	# pushl newX 
	 pushl 12(%ebp) 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 8(%ebx) 
	 
 
	# Line 111: y:=newY 
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
	# Line 113: end setXY 
	# Line 114: setX() is 
Point_setX: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 116: setXY(newX,y) 
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
	# Line 118: end setX 
	# Line 119: setY() is 
Point_setY: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 121: y:=newY 
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
	# Line 123: end setY 
	# CLASS BEGINNIGN HERE 
	# Line 129: start() is 
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
	# Line 133: out.writeint(5) 
	 pushl $5 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 136: end start 
