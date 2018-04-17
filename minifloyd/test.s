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
	 call Bstrbasics_start 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
	# CLASS BEGINNIGN HERE 
	# Line 6: s:String

 
	 movl $0, 8(%ebp) 
	# Line 8: print() is 
Bstrbasics_print: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 10: print:="q = ".cat(q).cat("\n") 
.data 
stringlit1: 
	 .string "\n" 
	 
 
.text 
	 pushl $stringlit1 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# pushl q 
	 pushl 12(%ebp) 
.data 
stringlit2: 
	 .string "q = " 
	 
 
.text 
	 pushl $stringlit2 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	 call String_cat 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 call String_cat 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl print 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 12: end print 
	# Line 13: start() is 
Bstrbasics_start: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# making space for 2 locals 
	 pushl $0 
	# Line 17: out.write("Enter a string of characters:") 
.data 
stringlit3: 
	 .string "Enter a string of characters:" 
	 
 
.text 
	 pushl $stringlit3 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 18: s:=in.readline() 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 0(%ebx) 
	 call Reader_readline 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 8(%ebx) 
	 
 
	# Line 19: len:=s.length() 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	 call String_length 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl len 
	 popl -8(%ebp) 
	 
 
	# Line 20: firstCh:=s.charAt(0) 
	 pushl $0 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	 call String_charAt 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl firstCh 
	 popl -12(%ebp) 
	 
 
	# Line 22: out.write("s has ".catInt(len).cat(" characters.\n")) 
.data 
stringlit4: 
	 .string " characters.\n" 
	 
 
.text 
	 pushl $stringlit4 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# pushl len 
	 pushl -8(%ebp) 
.data 
stringlit5: 
	 .string "s has " 
	 
 
.text 
	 pushl $stringlit5 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	 call String_catInt 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 call String_cat 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 23: out.write("charAt(0) = '".catChar(firstCh).cat("'\n")) 
.data 
stringlit6: 
	 .string "'\n" 
	 
 
.text 
	 pushl $stringlit6 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# pushl firstCh 
	 pushl -12(%ebp) 
.data 
stringlit7: 
	 .string "charAt(0) = '" 
	 
 
.text 
	 pushl $stringlit7 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	 call String_catChar 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 call String_cat 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 25: if s.gt(" ") then 
.data 
stringlit8: 
	 .string " " 
	 
 
.text 
	 pushl $stringlit8 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	 call String_gt 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L47 
	# Line 26: out.write("s > ' '\n") 
.data 
stringlit9: 
	 .string "s > ' '\n" 
	 
 
.text 
	 pushl $stringlit9 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	 jmp .L48 
	 .L47: 
	# Line 27: Else 
	# Line 28: out.write("! s > ' '\n") 
.data 
stringlit10: 
	 .string "! s > ' '\n" 
	 
 
.text 
	 pushl $stringlit10 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	 .L48: 
	# Line 29: end if 
	# Line 31: if s.gteq(" ") then 
.data 
stringlit11: 
	 .string " " 
	 
 
.text 
	 pushl $stringlit11 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	 call String_gteq 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L49 
	# Line 32: out.write("s >= ' '\n") 
.data 
stringlit12: 
	 .string "s >= ' '\n" 
	 
 
.text 
	 pushl $stringlit12 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	 jmp .L50 
	 .L49: 
	# Line 33: Else 
	# Line 34: out.write("! s >= ' '\n") 
.data 
stringlit13: 
	 .string "! s >= ' '\n" 
	 
 
.text 
	 pushl $stringlit13 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	 .L50: 
	# Line 35: end if 
	# Line 37: out.write(print("wowsers!")) 
.data 
stringlit14: 
	 .string "wowsers!" 
	 
 
.text 
	 pushl $stringlit14 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	 pushl 8(%ebp) 
	 call Bstrbasics_print 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	# reference to the object 
	# pushl out 
	 pushl 0(%ebp) 
	 call Writer_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 40: end start 
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
	# Line 120: newstr:=copy() 
	 pushl 8(%ebp) 
	 call String_copy 
	 pushl %eax 
	 
 
	# popl newstr 
	 popl -8(%ebp) 
	 
 
	# Line 123: curNode:=str.getCharlist() 
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
	# Line 125: newstr.appendChar(curNode.getChar()) 
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
	 
 
	# Line 126: curNode:=curNode.getNext() 
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
	# Line 124: not(curNode=null) 
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
	# Line 127: end loop 
	# Line 129: cat:=newstr 
	# pushl newstr 
	 pushl -8(%ebp) 
	# popl cat 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 133: end cat 
	# Line 134: catChar() is 
String_catChar: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 1 locals 
	 pushl $0 
	# Line 137: newstr:=copy() 
	 pushl 8(%ebp) 
	 call String_copy 
	 pushl %eax 
	 
 
	# popl newstr 
	 popl -8(%ebp) 
	 
 
	# Line 139: newstr.appendChar(ch) 
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
	 
 
	# Line 141: catChar:=newstr 
	# pushl newstr 
	 pushl -8(%ebp) 
	# popl catChar 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 144: end catChar 
	# Line 145: catInt() is 
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
	# Line 150: if not(num=0) then 
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
	# Line 151: result:=newString 
	 pushl $12 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 1 instance vars to 0 
	 movl $0, 8(%eax) 
	 pushl %eax 
	# popl result 
	 popl -8(%ebp) 
	 
 
	# Line 153: if (0>num) then 
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
	# Line 154: result.catChar(45) 
	 pushl $45 
	# reference to the object 
	# pushl result 
	 pushl -8(%ebp) 
	 call String_catChar 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 155: num:=-num 
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
	# Line 156: end if 
	# Line 159: catIntHelper(num,result) 
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
	# Line 161: Else 
	# Line 162: result:=(newString).catChar(48) 
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
	# Line 163: end if 
	# Line 165: catInt:=cat(result) 
	# pushl result 
	 pushl -8(%ebp) 
	 pushl 8(%ebp) 
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
	# Line 169: end catInt 
	# Line 170: charAt() is 
String_charAt: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 1 locals 
	 pushl $0 
	# Line 173: curNode:=charlist 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl curNode 
	 popl -8(%ebp) 
	 
 
	 jmp .L15 
	 .L16: 
	# Line 175: index:=index-1 
	 pushl $1 
	# pushl index 
	 pushl 12(%ebp) 
	 call minus 
	 addl $8, %esp 
	 pushl %eax 
	# popl index 
	 popl 12(%ebp) 
	 
 
	# Line 176: curNode:=curNode.getNext() 
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
	# Line 174: (index>0)andnot(curNode=null) 
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
	# Line 177: end loop 
	# Line 179: if not(curNode=null) then 
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
	# Line 180: charAt:=curNode.getChar() 
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
	# Line 181: Else 
	# Line 182: charAt:=-1 
	 pushl $-1 
	# popl charAt 
	 popl -4(%ebp) 
	 
 
	 .L18: 
	# Line 183: end if 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 186: end charAt 
	# Line 187: length() is 
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
	# Line 191: curNode:=charlist 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl curNode 
	 popl -12(%ebp) 
	 
 
	# Line 192: i:=0 
	 pushl $0 
	# popl i 
	 popl -8(%ebp) 
	 
 
	 jmp .L19 
	 .L20: 
	# Line 194: i:=i+1 
	# pushl i 
	 pushl -8(%ebp) 
	 pushl $1 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	# popl i 
	 popl -8(%ebp) 
	 
 
	# Line 195: curNode:=curNode.getNext() 
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
	# Line 193: not(curNode=null) 
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
	# Line 196: end loop 
	# Line 197: length:=i 
	# pushl i 
	 pushl -8(%ebp) 
	# popl length 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 200: end length 
	# Line 201: eq() is 
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
	# Line 205: len:=length() 
	 pushl 8(%ebp) 
	 call String_length 
	 pushl %eax 
	 
 
	# popl len 
	 popl -12(%ebp) 
	 
 
	# Line 206: if not(len=str.length()) then 
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
	# Line 207: eq:=false 
	 pushl $0 
	# popl eq 
	 popl -4(%ebp) 
	 
 
	 jmp .L22 
	 .L21: 
	# Line 208: Else 
	# Line 209: i:=0 
	 pushl $0 
	# popl i 
	 popl -8(%ebp) 
	 
 
	 jmp .L23 
	 .L24: 
	# Line 211: i:=i+1 
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
	# Line 210: not(i>=len)and(charAt(i)=str.charAt(i)) 
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
	 pushl 8(%ebp) 
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
	# Line 212: end loop 
	# Line 213: eq:=(i=len) 
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
	# Line 214: end if 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 216: end eq 
	# Line 217: gt() is 
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
	# Line 221: len:=length() 
	 pushl 8(%ebp) 
	 call String_length 
	 pushl %eax 
	 
 
	# popl len 
	 popl -12(%ebp) 
	 
 
	# Line 222: i:=0 
	 pushl $0 
	# popl i 
	 popl -8(%ebp) 
	 
 
	 jmp .L25 
	 .L26: 
	# Line 224: i:=i+1 
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
	# Line 223: not(i>=len)andnot(i>=str.length())and(charAt(i)=str.charAt(i)) 
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
	 pushl 8(%ebp) 
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
	# Line 225: end loop 
	# Line 226: if (i>=len)or(i>=str.length()) then 
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
	# Line 227: gt:=len>str.length() 
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
	# Line 228: Else 
	# Line 229: gt:=(charAt(i)>str.charAt(i)) 
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
	 pushl 8(%ebp) 
	 call String_charAt 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	# popl gt 
	 popl -4(%ebp) 
	 
 
	 .L28: 
	# Line 230: end if 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 233: end gt 
	# Line 234: gteq() is 
String_gteq: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 236: gteq:=gt(str)oreq(str) 
	# pushl str 
	 pushl 12(%ebp) 
	 pushl 8(%ebp) 
	 call String_eq 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	# pushl str 
	 pushl 12(%ebp) 
	 pushl 8(%ebp) 
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
	# Line 239: end gteq 
	# Line 240: toString() is 
String_toString: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 242: toString:=me 
	 pushl 8(%ebp) 
	# popl toString 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 245: end toString 
	# CLASS BEGINNIGN HERE 
	# Line 260: readline() is 
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
	# Line 264: s:=newString 
	 pushl $12 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 1 instance vars to 0 
	 movl $0, 8(%eax) 
	 pushl %eax 
	# popl s 
	 popl -12(%ebp) 
	 
 
	# Line 266: char:=io_read() 
	 pushl 8(%ebp) 
	 call Reader_io_read 
	 pushl %eax 
	 
 
	# popl char 
	 popl -8(%ebp) 
	 
 
	 jmp .L29 
	 .L30: 
	# Line 268: if not(char=13) then 
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
	# Line 269: s.appendChar(char) 
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
	# Line 270: end if 
	# Line 271: char:=io_read() 
	 pushl 8(%ebp) 
	 call Reader_io_read 
	 pushl %eax 
	 
 
	# popl char 
	 popl -8(%ebp) 
	 
 
	 .L29: 
	# Line 267: not(char=10) 
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
	# Line 272: end loop 
	# Line 274: readline:=s 
	# pushl s 
	 pushl -12(%ebp) 
	# popl readline 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 280: end readline 
	# Line 281: readint() is 
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
	# Line 288: s:=readline() 
	 pushl 8(%ebp) 
	 call Reader_readline 
	 pushl %eax 
	 
 
	# popl s 
	 popl -8(%ebp) 
	 
 
	# Line 289: if s.length()>0 then 
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
	# Line 290: if s.charAt(0)=45 then 
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
	# Line 291: mult:=-1 
	 pushl $-1 
	# popl mult 
	 popl -24(%ebp) 
	 
 
	# Line 292: i:=1 
	 pushl $1 
	# popl i 
	 popl -12(%ebp) 
	 
 
	 jmp .L36 
	 .L35: 
	# Line 293: Else 
	# Line 294: mult:=1 
	 pushl $1 
	# popl mult 
	 popl -24(%ebp) 
	 
 
	# Line 295: i:=0 
	 pushl $0 
	# popl i 
	 popl -12(%ebp) 
	 
 
	 .L36: 
	# Line 296: end if 
	# Line 298: num:=0 
	 pushl $0 
	# popl num 
	 popl -16(%ebp) 
	 
 
	# Line 299: len:=s.length() 
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
	# Line 301: num:=num*10+(s.charAt(i)-48) 
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
	 
 
	# Line 302: i:=i+1 
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
	# Line 300: not(i>=len) 
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
	# Line 303: end loop 
	# Line 305: readint:=num*mult 
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
	# Line 306: Else 
	# Line 307: readint:=-1 
	 pushl $-1 
	# popl readint 
	 popl -4(%ebp) 
	 
 
	 .L34: 
	# Line 308: end if 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 310: end readint 
	# CLASS BEGINNIGN HERE 
	# Line 325: writechar() is 
Writer_writechar: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 327: io_write(char) 
	# pushl char 
	 pushl 12(%ebp) 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 328: writechar:=me 
	 pushl 8(%ebp) 
	# popl writechar 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 332: end writechar 
	# Line 333: writeintHelper() is 
Writer_writeintHelper: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 1 locals 
	 pushl $0 
	# Line 336: digit:=num-(num/10)*10 
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
	 
 
	# Line 337: if num/10>0 then 
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
	# Line 338: writeintHelper(num/10) 
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
	# Line 339: end if 
	# Line 340: io_write(digit+48) 
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
	# Line 343: end writeintHelper 
	# Line 344: writeint() is 
Writer_writeint: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 346: if (num=0) then 
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
	# Line 347: io_write(48) 
	 pushl $48 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	 jmp .L42 
	 .L41: 
	# Line 348: Else 
	# Line 349: if not(num>=0) then 
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
	# Line 350: io_write(45) 
	 pushl $45 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 351: num:=-num 
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
	# Line 352: end if 
	# Line 353: writeintHelper(num) 
	# pushl num 
	 pushl 12(%ebp) 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_writeintHelper 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	 .L42: 
	# Line 354: end if 
	# Line 356: io_write(13) 
	 pushl $13 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 357: io_write(10) 
	 pushl $10 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 359: writeint:=me 
	 pushl 8(%ebp) 
	# popl writeint 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 362: end writeint 
	# Line 363: write() is 
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
	# Line 367: len:=str.length() 
	# pushl str 
	 pushl 12(%ebp) 
	 call String_length 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl len 
	 popl -12(%ebp) 
	 
 
	# Line 368: i:=0 
	 pushl $0 
	# popl i 
	 popl -8(%ebp) 
	 
 
	 jmp .L45 
	 .L46: 
	# Line 370: io_write(str.charAt(i)) 
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
	 
 
	# Line 371: i:=i+1 
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
	# Line 369: not(i>=len) 
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
	# Line 372: end loop 
	# Line 374: write:=me 
	 pushl 8(%ebp) 
	# popl write 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 377: end write 
	# Line 378: writeln() is 
Writer_writeln: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 380: write(str) 
	# pushl str 
	 pushl 12(%ebp) 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 381: io_write(13) 
	 pushl $13 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 382: io_write(10) 
	 pushl $10 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 383: writeln:=me 
	 pushl 8(%ebp) 
	# popl writeln 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 385: end writeln 
