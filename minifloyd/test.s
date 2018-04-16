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
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 28: out.writeint(y) 
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
	# reference to the object (this) 
	 pushl 8(%ebp) 
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
	# making space for 3 locals 
	 pushl $0 
	# making space for 3 locals 
	 pushl $0 
	# making space for 3 locals 
	 pushl $0 
	# Line 61: s:="test" 
.data 
stringlit1: 
	 .string "test" 
	 
 
.text 
	 pushl $stringlit1 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# popl s 
	 popl -16(%ebp) 
	 
 
	# Line 62: s:="foo" 
.data 
stringlit2: 
	 .string "foo" 
	 
 
.text 
	 pushl $stringlit2 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# popl s 
	 popl -16(%ebp) 
	 
 
	# Line 63: s:="boo" 
.data 
stringlit3: 
	 .string "boo" 
	 
 
.text 
	 pushl $stringlit3 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# popl s 
	 popl -16(%ebp) 
	 
 
	# Line 64: if s=null then 
	 pushl $0 
	# pushl s 
	 pushl -16(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L47 
	# Line 65: out.writeint(5) 
	 pushl $5 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	 jmp .L48 
	 .L47: 
	# Line 66: Else 
	# Line 67: out.writeint(10) 
	 pushl $10 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 68: out.writeln(s) 
	# pushl s 
	 pushl -16(%ebp) 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_writeln 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	 .L48: 
	# Line 69: end if 
	# Line 70: out.writeln("jajajaj") 
.data 
stringlit4: 
	 .string "jajajaj" 
	 
 
.text 
	 pushl $stringlit4 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_writeln 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 71: end start 
	# CLASS BEGINNIGN HERE 
	# Line 8: toString() is 
floyd_toString: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 10: toString:="none" 
.data 
stringlit0: 
	 .string "none" 
	 
 
.text 
	 pushl $stringlit0 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# popl toString 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 12: end toString 
	# CLASS BEGINNIGN HERE 
	# Line 20: char:int
 
	# Line 21: next:CharNode

 
	 movl $0, 12(%ebp) 
	# Line 23: init() is 
CharNode_init: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 25: char:=initChar 
	# pushl initChar 
	 pushl 12(%ebp) 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 8(%ebx) 
	 
 
	# Line 26: next:=null 
	 pushl $0 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 12(%ebx) 
	 
 
	# Line 27: init:=me 
	 pushl 8(%ebp) 
	# popl init 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 29: end init 
	# Line 30: getChar() is 
CharNode_getChar: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 32: getChar:=char 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl getChar 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 34: end getChar 
	# Line 35: getNext() is 
CharNode_getNext: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 37: getNext:=next 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 12(%ebx) 
	# popl getNext 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 39: end getNext 
	# Line 40: setNext() is 
CharNode_setNext: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 42: next:=node 
	# pushl node 
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
	# Line 44: end setNext 
	# CLASS BEGINNIGN HERE 
	# Line 54: charlist:CharNode





 
	 movl $0, 8(%ebp) 
	# Line 60: appendChar() is 
String_appendChar: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# Line 64: node:=(newCharNode).init(char) 
	# pushl char 
	 pushl 12(%ebp) 
	 pushl $16 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 2 instance vars to 0 
	 movl $0, 8(%eax) 
	 movl $0, 12(%eax) 
	 pushl %eax 
	 call CharNode_init 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl node 
	 popl -12(%ebp) 
	 
 
	# Line 66: if charlist=null then 
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
	# Line 67: charlist:=node 
	# pushl node 
	 pushl -12(%ebp) 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 8(%ebx) 
	 
 
	 jmp .L2 
	 .L1: 
	# Line 68: Else 
	# Line 69: curnode:=charlist 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl curnode 
	 popl -8(%ebp) 
	 
 
	 jmp .L3 
	 .L4: 
	# Line 71: curnode:=curnode.getNext() 
	# pushl curnode 
	 pushl -8(%ebp) 
	 call CharNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curnode 
	 popl -8(%ebp) 
	 
 
	 .L3: 
	# Line 70: not(curnode.getNext()=null) 
	 pushl $0 
	# pushl curnode 
	 pushl -8(%ebp) 
	 call CharNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 pop %eax 
	 cmpl $0, %eax 
	 jne .L4 
	# Line 72: end loop 
	# Line 73: curnode.setNext(node) 
	# pushl node 
	 pushl -12(%ebp) 
	# reference to the object 
	# pushl curnode 
	 pushl -8(%ebp) 
	 call CharNode_setNext 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	 .L2: 
	# Line 74: end if 
	# Line 75: appendChar:=me 
	 pushl 8(%ebp) 
	# popl appendChar 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 77: end appendChar 
	# Line 78: catIntHelper() is 
String_catIntHelper: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 1 locals 
	 pushl $0 
	# Line 81: digit:=num-(num/10)*10 
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
	 
 
	# Line 82: if num/10>0 then 
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
	 jne .L5 
	# Line 83: catIntHelper(num/10,str) 
	# pushl str 
	 pushl 16(%ebp) 
	 pushl $10 
	# pushl num 
	 pushl 12(%ebp) 
	 call division 
	 addl $8, %esp 
	 pushl %eax 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call String_catIntHelper 
	# Clean up parameters: 2 * 4 
	 addl $8, %esp 
	 
 
	 jmp .L6 
	 .L5: 
	 .L6: 
	# Line 84: end if 
	# Line 85: str.appendChar(digit+48) 
	# pushl digit 
	 pushl -8(%ebp) 
	 pushl $48 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	# reference to the object 
	# pushl str 
	 pushl 16(%ebp) 
	 call String_appendChar 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 87: end catIntHelper 
	# Line 88: getCharlist() is 
String_getCharlist: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 90: getCharlist:=charlist 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl getCharlist 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 97: end getCharlist 
	# Line 98: copy() is 
String_copy: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# Line 102: newstr:=newString 
	 pushl $12 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 1 instance vars to 0 
	 movl $0, 8(%eax) 
	 pushl %eax 
	# popl newstr 
	 popl -8(%ebp) 
	 
 
	# Line 104: curNode:=charlist 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl curNode 
	 popl -12(%ebp) 
	 
 
	 jmp .L7 
	 .L8: 
	# Line 106: newstr.appendChar(curNode.getChar()) 
	# pushl curNode 
	 pushl -12(%ebp) 
	 call CharNode_getChar 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# reference to the object 
	# pushl newstr 
	 pushl -8(%ebp) 
	 call String_appendChar 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 107: curNode:=curNode.getNext() 
	# pushl curNode 
	 pushl -12(%ebp) 
	 call CharNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curNode 
	 popl -12(%ebp) 
	 
 
	 .L7: 
	# Line 105: not(curNode=null) 
	 pushl $0 
	# pushl curNode 
	 pushl -12(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 pop %eax 
	 cmpl $0, %eax 
	 jne .L8 
	# Line 108: end loop 
	# Line 110: copy:=newstr 
	# pushl newstr 
	 pushl -8(%ebp) 
	# popl copy 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 113: end copy 
	# Line 114: cat() is 
String_cat: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# Line 119: newstr:=copy() 
	 call String_copy 
	 pushl %eax 
	 
 
	# popl newstr 
	 popl -8(%ebp) 
	 
 
	# Line 122: curNode:=str.getCharlist() 
	# pushl str 
	 pushl 12(%ebp) 
	 call String_getCharlist 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curNode 
	 popl -12(%ebp) 
	 
 
	 jmp .L9 
	 .L10: 
	# Line 124: newstr.appendChar(curNode.getChar()) 
	# pushl curNode 
	 pushl -12(%ebp) 
	 call CharNode_getChar 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# reference to the object 
	# pushl newstr 
	 pushl -8(%ebp) 
	 call String_appendChar 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 125: curNode:=curNode.getNext() 
	# pushl curNode 
	 pushl -12(%ebp) 
	 call CharNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curNode 
	 popl -12(%ebp) 
	 
 
	 .L9: 
	# Line 123: not(curNode=null) 
	 pushl $0 
	# pushl curNode 
	 pushl -12(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 pop %eax 
	 cmpl $0, %eax 
	 jne .L10 
	# Line 126: end loop 
	# Line 128: cat:=newstr 
	# pushl newstr 
	 pushl -8(%ebp) 
	# popl cat 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 132: end cat 
	# Line 133: catChar() is 
String_catChar: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 1 locals 
	 pushl $0 
	# Line 136: newstr:=copy() 
	 call String_copy 
	 pushl %eax 
	 
 
	# popl newstr 
	 popl -8(%ebp) 
	 
 
	# Line 138: newstr.appendChar(ch) 
	# pushl ch 
	 pushl 12(%ebp) 
	# reference to the object 
	# pushl newstr 
	 pushl -8(%ebp) 
	 call String_appendChar 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 140: catChar:=newstr 
	# pushl newstr 
	 pushl -8(%ebp) 
	# popl catChar 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 143: end catChar 
	# Line 144: catInt() is 
String_catInt: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# Line 149: if not(num=0) then 
	 pushl $0 
	# pushl num 
	 pushl 12(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L11 
	# Line 150: result:=newString 
	 pushl $12 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 1 instance vars to 0 
	 movl $0, 8(%eax) 
	 pushl %eax 
	# popl result 
	 popl -8(%ebp) 
	 
 
	# Line 152: if (0>num) then 
	# pushl num 
	 pushl 12(%ebp) 
	 pushl $0 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L13 
	# Line 153: result.catChar(45) 
	 pushl $45 
	# reference to the object 
	# pushl result 
	 pushl -8(%ebp) 
	 call String_catChar 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 154: num:=-num 
	# pushl num 
	 pushl 12(%ebp) 
	 call unaryMinus 
	 addl $4, %esp 
	 pushl %eax 
	# popl num 
	 popl 12(%ebp) 
	 
 
	 jmp .L14 
	 .L13: 
	 .L14: 
	# Line 155: end if 
	# Line 158: catIntHelper(num,result) 
	# pushl result 
	 pushl -8(%ebp) 
	# pushl num 
	 pushl 12(%ebp) 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call String_catIntHelper 
	# Clean up parameters: 2 * 4 
	 addl $8, %esp 
	 
 
	 jmp .L12 
	 .L11: 
	# Line 160: Else 
	# Line 161: result:=(newString).catChar(48) 
	 pushl $48 
	 pushl $12 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 1 instance vars to 0 
	 movl $0, 8(%eax) 
	 pushl %eax 
	 call String_catChar 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl result 
	 popl -8(%ebp) 
	 
 
	 .L12: 
	# Line 162: end if 
	# Line 164: catInt:=cat(result) 
	# pushl result 
	 pushl -8(%ebp) 
	 call String_cat 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	# popl catInt 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 168: end catInt 
	# Line 169: charAt() is 
String_charAt: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 1 locals 
	 pushl $0 
	# Line 172: curNode:=charlist 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl curNode 
	 popl -8(%ebp) 
	 
 
	 jmp .L15 
	 .L16: 
	# Line 174: index:=index-1 
	 pushl $1 
	# pushl index 
	 pushl 12(%ebp) 
	 call minus 
	 addl $8, %esp 
	 pushl %eax 
	# popl index 
	 popl 12(%ebp) 
	 
 
	# Line 175: curNode:=curNode.getNext() 
	# pushl curNode 
	 pushl -8(%ebp) 
	 call CharNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curNode 
	 popl -8(%ebp) 
	 
 
	 .L15: 
	# Line 173: (index>0)andnot(curNode=null) 
	 pushl $0 
	# pushl curNode 
	 pushl -8(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 pushl $0 
	# pushl index 
	 pushl 12(%ebp) 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	 call andOp 
	 addl $8, %esp 
	 pushl %eax 
	 pop %eax 
	 cmpl $0, %eax 
	 jne .L16 
	# Line 176: end loop 
	# Line 178: if not(curNode=null) then 
	 pushl $0 
	# pushl curNode 
	 pushl -8(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L17 
	# Line 179: charAt:=curNode.getChar() 
	# pushl curNode 
	 pushl -8(%ebp) 
	 call CharNode_getChar 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl charAt 
	 popl -4(%ebp) 
	 
 
	 jmp .L18 
	 .L17: 
	# Line 180: Else 
	# Line 181: charAt:=-1 
	 pushl $-1 
	# popl charAt 
	 popl -4(%ebp) 
	 
 
	 .L18: 
	# Line 182: end if 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 185: end charAt 
	# Line 186: length() is 
String_length: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# Line 190: curNode:=charlist 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl curNode 
	 popl -12(%ebp) 
	 
 
	# Line 191: i:=0 
	 pushl $0 
	# popl i 
	 popl -8(%ebp) 
	 
 
	 jmp .L19 
	 .L20: 
	# Line 193: i:=i+1 
	# pushl i 
	 pushl -8(%ebp) 
	 pushl $1 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	# popl i 
	 popl -8(%ebp) 
	 
 
	# Line 194: curNode:=curNode.getNext() 
	# pushl curNode 
	 pushl -12(%ebp) 
	 call CharNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curNode 
	 popl -12(%ebp) 
	 
 
	 .L19: 
	# Line 192: not(curNode=null) 
	 pushl $0 
	# pushl curNode 
	 pushl -12(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 pop %eax 
	 cmpl $0, %eax 
	 jne .L20 
	# Line 195: end loop 
	# Line 196: length:=i 
	# pushl i 
	 pushl -8(%ebp) 
	# popl length 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 199: end length 
	# Line 200: eq() is 
String_eq: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# Line 204: len:=length() 
	 call String_length 
	 pushl %eax 
	 
 
	# popl len 
	 popl -12(%ebp) 
	 
 
	# Line 205: if not(len=str.length()) then 
	# pushl str 
	 pushl 12(%ebp) 
	 call String_length 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# pushl len 
	 pushl -12(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L21 
	# Line 206: eq:=false 
	 pushl $0 
	# popl eq 
	 popl -4(%ebp) 
	 
 
	 jmp .L22 
	 .L21: 
	# Line 207: Else 
	# Line 208: i:=0 
	 pushl $0 
	# popl i 
	 popl -8(%ebp) 
	 
 
	 jmp .L23 
	 .L24: 
	# Line 210: i:=i+1 
	# pushl i 
	 pushl -8(%ebp) 
	 pushl $1 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	# popl i 
	 popl -8(%ebp) 
	 
 
	 .L23: 
	# Line 209: not(i>=len)and(charAt(i)=str.charAt(i)) 
	# pushl i 
	 pushl -8(%ebp) 
	# pushl str 
	 pushl 12(%ebp) 
	 call String_charAt 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# pushl i 
	 pushl -8(%ebp) 
	 call String_charAt 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	# pushl len 
	 pushl -12(%ebp) 
	# pushl i 
	 pushl -8(%ebp) 
	 call greaterEqual 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 call andOp 
	 addl $8, %esp 
	 pushl %eax 
	 pop %eax 
	 cmpl $0, %eax 
	 jne .L24 
	# Line 211: end loop 
	# Line 212: eq:=(i=len) 
	# pushl len 
	 pushl -12(%ebp) 
	# pushl i 
	 pushl -8(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	# popl eq 
	 popl -4(%ebp) 
	 
 
	 .L22: 
	# Line 213: end if 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 215: end eq 
	# Line 216: gt() is 
String_gt: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# Line 220: len:=length() 
	 call String_length 
	 pushl %eax 
	 
 
	# popl len 
	 popl -12(%ebp) 
	 
 
	# Line 221: i:=0 
	 pushl $0 
	# popl i 
	 popl -8(%ebp) 
	 
 
	 jmp .L25 
	 .L26: 
	# Line 223: i:=i+1 
	# pushl i 
	 pushl -8(%ebp) 
	 pushl $1 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	# popl i 
	 popl -8(%ebp) 
	 
 
	 .L25: 
	# Line 222: not(i>=len)andnot(i>=str.length())and(charAt(i)=str.charAt(i)) 
	# pushl i 
	 pushl -8(%ebp) 
	# pushl str 
	 pushl 12(%ebp) 
	 call String_charAt 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# pushl i 
	 pushl -8(%ebp) 
	 call String_charAt 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	# pushl str 
	 pushl 12(%ebp) 
	 call String_length 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# pushl i 
	 pushl -8(%ebp) 
	 call greaterEqual 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	# pushl len 
	 pushl -12(%ebp) 
	# pushl i 
	 pushl -8(%ebp) 
	 call greaterEqual 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 call andOp 
	 addl $8, %esp 
	 pushl %eax 
	 call andOp 
	 addl $8, %esp 
	 pushl %eax 
	 pop %eax 
	 cmpl $0, %eax 
	 jne .L26 
	# Line 224: end loop 
	# Line 225: if (i>=len)or(i>=str.length()) then 
	# pushl str 
	 pushl 12(%ebp) 
	 call String_length 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# pushl i 
	 pushl -8(%ebp) 
	 call greaterEqual 
	 addl $8, %esp 
	 pushl %eax 
	# pushl len 
	 pushl -12(%ebp) 
	# pushl i 
	 pushl -8(%ebp) 
	 call greaterEqual 
	 addl $8, %esp 
	 pushl %eax 
	 call orOp 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L27 
	# Line 226: gt:=len>str.length() 
	# pushl str 
	 pushl 12(%ebp) 
	 call String_length 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# pushl len 
	 pushl -12(%ebp) 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	# popl gt 
	 popl -4(%ebp) 
	 
 
	 jmp .L28 
	 .L27: 
	# Line 227: Else 
	# Line 228: gt:=(charAt(i)>str.charAt(i)) 
	# pushl i 
	 pushl -8(%ebp) 
	# pushl str 
	 pushl 12(%ebp) 
	 call String_charAt 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# pushl i 
	 pushl -8(%ebp) 
	 call String_charAt 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	# popl gt 
	 popl -4(%ebp) 
	 
 
	 .L28: 
	# Line 229: end if 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 232: end gt 
	# Line 233: gteq() is 
String_gteq: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 235: gteq:=gt(str)oreq(str) 
	# pushl str 
	 pushl 12(%ebp) 
	 call String_eq 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	# pushl str 
	 pushl 12(%ebp) 
	 call String_gt 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	 call orOp 
	 addl $8, %esp 
	 pushl %eax 
	# popl gteq 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 238: end gteq 
	# Line 239: toString() is 
String_toString: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 241: toString:=me 
	 pushl 8(%ebp) 
	# popl toString 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 244: end toString 
	# CLASS BEGINNIGN HERE 
	# Line 259: readline() is 
Reader_readline: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# Line 263: s:=newString 
	 pushl $12 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 1 instance vars to 0 
	 movl $0, 8(%eax) 
	 pushl %eax 
	# popl s 
	 popl -12(%ebp) 
	 
 
	# Line 265: char:=io_read() 
	 call Reader_io_read 
	 pushl %eax 
	 
 
	# popl char 
	 popl -8(%ebp) 
	 
 
	 jmp .L29 
	 .L30: 
	# Line 267: if not(char=13) then 
	 pushl $13 
	# pushl char 
	 pushl -8(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L31 
	# Line 268: s.appendChar(char) 
	# pushl char 
	 pushl -8(%ebp) 
	# reference to the object 
	# pushl s 
	 pushl -12(%ebp) 
	 call String_appendChar 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	 jmp .L32 
	 .L31: 
	 .L32: 
	# Line 269: end if 
	# Line 270: char:=io_read() 
	 call Reader_io_read 
	 pushl %eax 
	 
 
	# popl char 
	 popl -8(%ebp) 
	 
 
	 .L29: 
	# Line 266: not(char=10) 
	 pushl $10 
	# pushl char 
	 pushl -8(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 pop %eax 
	 cmpl $0, %eax 
	 jne .L30 
	# Line 271: end loop 
	# Line 273: readline:=s 
	# pushl s 
	 pushl -12(%ebp) 
	# popl readline 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 279: end readline 
	# Line 280: readint() is 
Reader_readint: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 5 locals 
	 pushl $0 
	# making space for 5 locals 
	 pushl $0 
	# making space for 5 locals 
	 pushl $0 
	# making space for 5 locals 
	 pushl $0 
	# making space for 5 locals 
	 pushl $0 
	# Line 287: s:=readline() 
	 call Reader_readline 
	 pushl %eax 
	 
 
	# popl s 
	 popl -8(%ebp) 
	 
 
	# Line 288: if s.length()>0 then 
	 pushl $0 
	# pushl s 
	 pushl -8(%ebp) 
	 call String_length 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L33 
	# Line 289: if s.charAt(0)=45 then 
	 pushl $45 
	 pushl $0 
	# pushl s 
	 pushl -8(%ebp) 
	 call String_charAt 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L35 
	# Line 290: mult:=-1 
	 pushl $-1 
	# popl mult 
	 popl -24(%ebp) 
	 
 
	# Line 291: i:=1 
	 pushl $1 
	# popl i 
	 popl -12(%ebp) 
	 
 
	 jmp .L36 
	 .L35: 
	# Line 292: Else 
	# Line 293: mult:=1 
	 pushl $1 
	# popl mult 
	 popl -24(%ebp) 
	 
 
	# Line 294: i:=0 
	 pushl $0 
	# popl i 
	 popl -12(%ebp) 
	 
 
	 .L36: 
	# Line 295: end if 
	# Line 297: num:=0 
	 pushl $0 
	# popl num 
	 popl -16(%ebp) 
	 
 
	# Line 298: len:=s.length() 
	# pushl s 
	 pushl -8(%ebp) 
	 call String_length 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl len 
	 popl -20(%ebp) 
	 
 
	 jmp .L37 
	 .L38: 
	# Line 300: num:=num*10+(s.charAt(i)-48) 
	# pushl num 
	 pushl -16(%ebp) 
	 pushl $10 
	 call times 
	 addl $8, %esp 
	 pushl %eax 
	 pushl $48 
	# pushl i 
	 pushl -12(%ebp) 
	# pushl s 
	 pushl -8(%ebp) 
	 call String_charAt 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 call minus 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	# popl num 
	 popl -16(%ebp) 
	 
 
	# Line 301: i:=i+1 
	# pushl i 
	 pushl -12(%ebp) 
	 pushl $1 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	# popl i 
	 popl -12(%ebp) 
	 
 
	 .L37: 
	# Line 299: not(i>=len) 
	# pushl len 
	 pushl -20(%ebp) 
	# pushl i 
	 pushl -12(%ebp) 
	 call greaterEqual 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 pop %eax 
	 cmpl $0, %eax 
	 jne .L38 
	# Line 302: end loop 
	# Line 304: readint:=num*mult 
	# pushl num 
	 pushl -16(%ebp) 
	# pushl mult 
	 pushl -24(%ebp) 
	 call times 
	 addl $8, %esp 
	 pushl %eax 
	# popl readint 
	 popl -4(%ebp) 
	 
 
	 jmp .L34 
	 .L33: 
	# Line 305: Else 
	# Line 306: readint:=-1 
	 pushl $-1 
	# popl readint 
	 popl -4(%ebp) 
	 
 
	 .L34: 
	# Line 307: end if 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 309: end readint 
	# CLASS BEGINNIGN HERE 
	# Line 324: writechar() is 
Writer_writechar: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 326: io_write(char) 
	# pushl char 
	 pushl 12(%ebp) 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 327: writechar:=me 
	 pushl 8(%ebp) 
	# popl writechar 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 331: end writechar 
	# Line 332: writeintHelper() is 
Writer_writeintHelper: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 1 locals 
	 pushl $0 
	# Line 335: digit:=num-(num/10)*10 
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
	 
 
	# Line 336: if num/10>0 then 
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
	 jne .L39 
	# Line 337: writeintHelper(num/10) 
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
	 
 
	 jmp .L40 
	 .L39: 
	 .L40: 
	# Line 338: end if 
	# Line 339: io_write(digit+48) 
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
	# Line 342: end writeintHelper 
	# Line 343: writeint() is 
Writer_writeint: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 345: if (num=0) then 
	 pushl $0 
	# pushl num 
	 pushl 12(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L41 
	# Line 346: io_write(48) 
	 pushl $48 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	 jmp .L42 
	 .L41: 
	# Line 347: Else 
	# Line 348: if not(num>=0) then 
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
	 jne .L43 
	# Line 349: io_write(45) 
	 pushl $45 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 350: num:=-num 
	# pushl num 
	 pushl 12(%ebp) 
	 call unaryMinus 
	 addl $4, %esp 
	 pushl %eax 
	# popl num 
	 popl 12(%ebp) 
	 
 
	 jmp .L44 
	 .L43: 
	 .L44: 
	# Line 351: end if 
	# Line 352: writeintHelper(num) 
	# pushl num 
	 pushl 12(%ebp) 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_writeintHelper 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	 .L42: 
	# Line 353: end if 
	# Line 355: io_write(13) 
	 pushl $13 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 356: io_write(10) 
	 pushl $10 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 358: writeint:=me 
	 pushl 8(%ebp) 
	# popl writeint 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 361: end writeint 
	# Line 362: write() is 
Writer_write: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# Line 366: len:=str.length() 
	# pushl str 
	 pushl 12(%ebp) 
	 call String_length 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl len 
	 popl -12(%ebp) 
	 
 
	# Line 367: i:=0 
	 pushl $0 
	# popl i 
	 popl -8(%ebp) 
	 
 
	 jmp .L45 
	 .L46: 
	# Line 369: io_write(str.charAt(i)) 
	# pushl i 
	 pushl -8(%ebp) 
	# pushl str 
	 pushl 12(%ebp) 
	 call String_charAt 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 370: i:=i+1 
	# pushl i 
	 pushl -8(%ebp) 
	 pushl $1 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	# popl i 
	 popl -8(%ebp) 
	 
 
	 .L45: 
	# Line 368: not(i>=len) 
	# pushl len 
	 pushl -12(%ebp) 
	# pushl i 
	 pushl -8(%ebp) 
	 call greaterEqual 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 pop %eax 
	 cmpl $0, %eax 
	 jne .L46 
	# Line 371: end loop 
	# Line 373: write:=me 
	 pushl 8(%ebp) 
	# popl write 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 376: end write 
	# Line 377: writeln() is 
Writer_writeln: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 379: write(str) 
	# pushl str 
	 pushl 12(%ebp) 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 380: io_write(13) 
	 pushl $13 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 381: io_write(10) 
	 pushl $10 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 382: writeln:=me 
	 pushl 8(%ebp) 
	# popl writeln 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 384: end writeln 
