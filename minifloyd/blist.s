.global main 
	 .file "blist.floyd" 
	# Making in & out globals 
	 .comm	 _in,4,4 
	 .comm	 _out,4,4 
	# Main method. Creates obj instance of the last class and calls its start method 
main: 
	# instantiating _in object 
	 pushl $8 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	 movl %eax, _in 
	# instantiating _out object 
	 pushl $8 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	 movl %eax, _out 
	# Creating last class object & calling its start method 
	 pushl $12 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 1 instance vars to 0 
	 movl $0, 8(%eax) 
	 pushl %eax 
	 call List_start 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
	 
 
	# ******** Class Definition: ListNode ********  
	 movl $0, 12(%ebp) 
	# Line 15: init() is 
ListNode_init: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 17: data:=initData 
	# pushl initData 
	 pushl 12(%ebp) 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 8(%ebx) 
	 
 
	# Line 18: next:=null 
	 pushl $0 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 12(%ebx) 
	 
 
	# Line 19: init:=me 
	 pushl 8(%ebp) 
	# popl init 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 21: end init 
	# Line 22: getData() is 
ListNode_getData: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 24: getData:=data 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl getData 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 26: end getData 
	# Line 27: setData() is 
ListNode_setData: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 29: data:=newData 
	# pushl newData 
	 pushl 12(%ebp) 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 8(%ebx) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 31: end setData 
	# Line 32: getNext() is 
ListNode_getNext: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 34: getNext:=next 
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
	# Line 36: end getNext 
	# Line 37: setNext() is 
ListNode_setNext: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# Line 39: next:=node 
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
	# Line 41: end setNext 
	 
 
	# ******** Class Definition: List ********  
	 movl $0, 8(%ebp) 
	# Line 54: add() is 
List_add: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# Line 58: node:=(newListNode).init(item) 
	# pushl item 
	 pushl 12(%ebp) 
	 pushl $16 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 2 instance vars to 0 
	 movl $0, 8(%eax) 
	 movl $0, 12(%eax) 
	 pushl %eax 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $58 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_init 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl node 
	 popl -12(%ebp) 
	 
 
	# Line 60: if head=null then 
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
	 jne .L47 
	# Line 61: head:=node 
	# pushl node 
	 pushl -12(%ebp) 
	# put param value into eax 
	 popl %eax 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# store new value in offset inside of me 
	 movl %eax, 8(%ebx) 
	 
 
	 jmp .L48 
	 .L47: 
	# Line 62: Else 
	# Line 63: curnode:=head 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl curnode 
	 popl -8(%ebp) 
	 
 
	 jmp .L49 
	 .L50: 
	# Line 65: curnode:=curnode.getNext() 
	# pushl curnode 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $65 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curnode 
	 popl -8(%ebp) 
	 
 
	 .L49: 
	 pushl $0 
	# pushl curnode 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $64 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_getNext 
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
	 jne .L50 
	# Line 66: end loop 
	# Line 67: curnode.setNext(node) 
	# pushl node 
	 pushl -12(%ebp) 
	# reference to the object 
	# pushl curnode 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $67 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_setNext 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	 .L48: 
	# Line 68: end if 
	# Line 69: add:=me 
	 pushl 8(%ebp) 
	# popl add 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 72: end add 
	# Line 73: get() is 
List_get: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 1 local 
	 pushl $0 
	# Line 76: curNode:=head 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl curNode 
	 popl -8(%ebp) 
	 
 
	 jmp .L51 
	 .L52: 
	# Line 78: index:=index-1 
	 pushl $1 
	# pushl index 
	 pushl 12(%ebp) 
	 call minus 
	 addl $8, %esp 
	 pushl %eax 
	# popl index 
	 popl 12(%ebp) 
	 
 
	# Line 79: curNode:=curNode.getNext() 
	# pushl curNode 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $79 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curNode 
	 popl -8(%ebp) 
	 
 
	 .L51: 
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
	 jne .L52 
	# Line 80: end loop 
	# Line 82: if not(curNode=null) then 
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
	 jne .L53 
	# Line 83: get:=curNode.getData() 
	# pushl curNode 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $83 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_getData 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl get 
	 popl -4(%ebp) 
	 
 
	 jmp .L54 
	 .L53: 
	# Line 84: Else 
	# Line 85: get:=-1 
	 pushl $-1 
	# popl get 
	 popl -4(%ebp) 
	 
 
	 .L54: 
	# Line 86: end if 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 89: end get 
	# Line 90: length() is 
List_length: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# Line 94: curNode:=head 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl curNode 
	 popl -12(%ebp) 
	 
 
	# Line 95: i:=0 
	 pushl $0 
	# popl i 
	 popl -8(%ebp) 
	 
 
	 jmp .L55 
	 .L56: 
	# Line 97: i:=i+1 
	# pushl i 
	 pushl -8(%ebp) 
	 pushl $1 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	# popl i 
	 popl -8(%ebp) 
	 
 
	# Line 98: curNode:=curNode.getNext() 
	# pushl curNode 
	 pushl -12(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $98 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curNode 
	 popl -12(%ebp) 
	 
 
	 .L55: 
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
	 jne .L56 
	# Line 99: end loop 
	# Line 100: length:=i 
	# pushl i 
	 pushl -8(%ebp) 
	# popl length 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 104: end length 
	# Line 105: remove() is 
List_remove: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# Line 109: prevNode:=null 
	 pushl $0 
	# popl prevNode 
	 popl -12(%ebp) 
	 
 
	# Line 110: curNode:=head 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl curNode 
	 popl -8(%ebp) 
	 
 
	 jmp .L57 
	 .L58: 
	# Line 112: index:=index-1 
	 pushl $1 
	# pushl index 
	 pushl 12(%ebp) 
	 call minus 
	 addl $8, %esp 
	 pushl %eax 
	# popl index 
	 popl 12(%ebp) 
	 
 
	# Line 113: prevNode:=curNode 
	# pushl curNode 
	 pushl -8(%ebp) 
	# popl prevNode 
	 popl -12(%ebp) 
	 
 
	# Line 114: curNode:=curNode.getNext() 
	# pushl curNode 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $114 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curNode 
	 popl -8(%ebp) 
	 
 
	 .L57: 
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
	 jne .L58 
	# Line 115: end loop 
	# Line 117: if not(curNode=null) then 
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
	 jne .L59 
	# Line 119: if prevNode=null then 
	 pushl $0 
	# pushl prevNode 
	 pushl -12(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L61 
	# Line 120: head:=curNode.getNext() 
	# pushl curNode 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $120 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_getNext 
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
	 
 
	 jmp .L62 
	 .L61: 
	# Line 121: Else 
	# Line 122: prevNode.setNext(curNode.getNext()) 
	# pushl curNode 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $122 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# reference to the object 
	# pushl prevNode 
	 pushl -12(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $122 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_setNext 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	 .L62: 
	# Line 123: end if 
	 jmp .L60 
	 .L59: 
	 .L60: 
	# Line 124: end if 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 128: end remove 
	# Line 129: set() is 
List_set: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 1 local 
	 pushl $0 
	# Line 132: curNode:=head 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl curNode 
	 popl -8(%ebp) 
	 
 
	 jmp .L63 
	 .L64: 
	# Line 134: index:=index-1 
	 pushl $1 
	# pushl index 
	 pushl 12(%ebp) 
	 call minus 
	 addl $8, %esp 
	 pushl %eax 
	# popl index 
	 popl 12(%ebp) 
	 
 
	# Line 135: curNode:=curNode.getNext() 
	# pushl curNode 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $135 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curNode 
	 popl -8(%ebp) 
	 
 
	 .L63: 
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
	 jne .L64 
	# Line 136: end loop 
	# Line 138: if not(curNode=null) then 
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
	 jne .L65 
	# Line 139: curNode.setData(item) 
	# pushl item 
	 pushl 16(%ebp) 
	# reference to the object 
	# pushl curNode 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $139 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_setData 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	 jmp .L66 
	 .L65: 
	 .L66: 
	# Line 140: end if 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 143: end set 
	# Line 144: toString() is 
List_toString: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# Line 148: curNode:=head 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl curNode 
	 popl -12(%ebp) 
	 
 
	# Line 149: str:="[" 
.data 
stringlit1: 
	 .string "[" 
	 
 
.text 
	 pushl $stringlit1 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# popl str 
	 popl -8(%ebp) 
	 
 
	 jmp .L67 
	 .L68: 
	# Line 151: str:=str.catInt(curNode.getData()) 
	# pushl curNode 
	 pushl -12(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $151 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_getData 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# pushl str 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $151 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_catInt 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl str 
	 popl -8(%ebp) 
	 
 
	# Line 152: curNode:=curNode.getNext() 
	# pushl curNode 
	 pushl -12(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $152 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curNode 
	 popl -12(%ebp) 
	 
 
	# Line 153: if not(curNode=null) then 
	 pushl $0 
	# pushl curNode 
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
	 jne .L69 
	# Line 154: str:=str.catChar(44) 
	 pushl $44 
	# pushl str 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $154 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_catChar 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl str 
	 popl -8(%ebp) 
	 
 
	 jmp .L70 
	 .L69: 
	 .L70: 
	# Line 155: end if 
	 .L67: 
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
	 jne .L68 
	# Line 156: end loop 
	# Line 157: toString:=str.cat("]") 
.data 
stringlit2: 
	 .string "]" 
	 
 
.text 
	 pushl $stringlit2 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# pushl str 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $157 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_cat 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl toString 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 160: end toString 
	# Line 161: print() is 
List_print: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 1 local 
	 pushl $0 
	# Line 164: curNode:=head 
	# get reference to me 
	 movl 8(%ebp), %ebx 
	# push value inside of the reference 
	 pushl 8(%ebx) 
	# popl curNode 
	 popl -8(%ebp) 
	 
 
	 jmp .L71 
	 .L72: 
	# Line 167: out.writeint(curNode.getData()) 
	# pushl curNode 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $167 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_getData 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 pushl _out 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $167 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call Writer_writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 168: curNode:=curNode.getNext() 
	# pushl curNode 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $168 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call ListNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curNode 
	 popl -8(%ebp) 
	 
 
	 .L71: 
	 pushl $0 
	# pushl curNode 
	 pushl -8(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 pop %eax 
	 cmpl $0, %eax 
	 jne .L72 
	# Line 169: end loop 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 172: end print 
	# Line 173: assert() is 
List_assert: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 1 local 
	 pushl $0 
	# Line 176: if notcond then 
	# pushl cond 
	 pushl 12(%ebp) 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L73 
	# Line 177: out.writeint(linenum) 
	# pushl linenum 
	 pushl 16(%ebp) 
	 pushl _out 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $177 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call Writer_writeint 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 178: s.length() 
	# reference to the object 
	# pushl s 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $178 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_length 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	 jmp .L74 
	 .L73: 
	 .L74: 
	# Line 179: end if 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 182: end assert 
	# Line 183: start() is 
List_start: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# Line 187: startLine:=187 
	 pushl $187 
	# popl startLine 
	 popl -12(%ebp) 
	 
 
	# Line 188: list:=(newList).add(10).add(20).add(30) 
	 pushl $30 
	 pushl $20 
	 pushl $10 
	 pushl $12 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 1 instance vars to 0 
	 movl $0, 8(%eax) 
	 pushl %eax 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $188 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_add 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $188 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_add 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $188 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_add 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl list 
	 popl -8(%ebp) 
	 
 
	# Line 190: assert(list.get(0)=10,startLine+3) 
	# pushl startLine 
	 pushl -12(%ebp) 
	 pushl $3 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	 pushl $10 
	 pushl $0 
	# pushl list 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $190 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_get 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $190 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_assert 
	# Clean up parameters: 2 * 4 
	 addl $8, %esp 
	 
 
	# Line 191: assert(list.get(2)=30,startLine+4) 
	# pushl startLine 
	 pushl -12(%ebp) 
	 pushl $4 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	 pushl $30 
	 pushl $2 
	# pushl list 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $191 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_get 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $191 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_assert 
	# Clean up parameters: 2 * 4 
	 addl $8, %esp 
	 
 
	# Line 192: assert(list.get(3)=-1,startLine+5) 
	# pushl startLine 
	 pushl -12(%ebp) 
	 pushl $5 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	 pushl $-1 
	 pushl $3 
	# pushl list 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $192 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_get 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $192 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_assert 
	# Clean up parameters: 2 * 4 
	 addl $8, %esp 
	 
 
	# Line 194: list.add(40) 
	 pushl $40 
	# reference to the object 
	# pushl list 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $194 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_add 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 195: list.add(50) 
	 pushl $50 
	# reference to the object 
	# pushl list 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $195 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_add 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 196: assert(list.get(4)=50,startLine+9) 
	# pushl startLine 
	 pushl -12(%ebp) 
	 pushl $9 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	 pushl $50 
	 pushl $4 
	# pushl list 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $196 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_get 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $196 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_assert 
	# Clean up parameters: 2 * 4 
	 addl $8, %esp 
	 
 
	# Line 198: list.remove(2) 
	 pushl $2 
	# reference to the object 
	# pushl list 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $198 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_remove 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 199: list.set(2,5) 
	 pushl $5 
	 pushl $2 
	# reference to the object 
	# pushl list 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $199 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_set 
	# Clean up parameters: 2 * 4 
	 addl $8, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 200: assert(list.get(2)=5,startLine+13) 
	# pushl startLine 
	 pushl -12(%ebp) 
	 pushl $13 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	 pushl $5 
	 pushl $2 
	# pushl list 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $200 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_get 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $200 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_assert 
	# Clean up parameters: 2 * 4 
	 addl $8, %esp 
	 
 
	# Line 201: assert(list.get(3)=50,startLine+14) 
	# pushl startLine 
	 pushl -12(%ebp) 
	 pushl $14 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
	 pushl $50 
	 pushl $3 
	# pushl list 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $201 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_get 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $201 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_assert 
	# Clean up parameters: 2 * 4 
	 addl $8, %esp 
	 
 
	# Line 203: list.print() 
	# reference to the object 
	# pushl list 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $203 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_print 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 207: assert((newList).toString().eq("[]"),startLine+20) 
	# pushl startLine 
	 pushl -12(%ebp) 
	 pushl $20 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
.data 
stringlit3: 
	 .string "[]" 
	 
 
.text 
	 pushl $stringlit3 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	 pushl $12 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 1 instance vars to 0 
	 movl $0, 8(%eax) 
	 pushl %eax 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $207 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_toString 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $207 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_eq 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $207 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_assert 
	# Clean up parameters: 2 * 4 
	 addl $8, %esp 
	 
 
	# Line 208: assert(list.toString().eq("[10,20,5,50]"),startLine+21) 
	# pushl startLine 
	 pushl -12(%ebp) 
	 pushl $21 
	 popl %eax 
	 popl %ebx 
	 addl  %eax, %ebx 
	 pushl %ebx 
.data 
stringlit4: 
	 .string "[10,20,5,50]" 
	 
 
.text 
	 pushl $stringlit4 
	 call string_fromlit 
	 addl $4, %esp 
	 pushl %eax 
	# pushl list 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $208 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_toString 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $208 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_eq 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $208 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_assert 
	# Clean up parameters: 2 * 4 
	 addl $8, %esp 
	 
 
	# Line 209: out.writeln(list.toString()) 
	# pushl list 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $209 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_toString 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 pushl _out 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $209 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call Writer_writeln 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 210: out.writeln((newList).toString()) 
	 pushl $12 
	 pushl $1 
	 call calloc 
	 addl $8, %esp 
	# Initializing 1 instance vars to 0 
	 movl $0, 8(%eax) 
	 pushl %eax 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $210 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call List_toString 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	 pushl _out 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $210 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call Writer_writeln 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 213: end start 
	 
 
	# ******** Class Definition: floyd ********  
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
	 
 
	# ******** Class Definition: CharNode ********  
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
	 
 
	# ******** Class Definition: String ********  
	 movl $0, 8(%ebp) 
	# Line 60: appendChar() is 
String_appendChar: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# making space for 2 local 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $64 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $71 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call CharNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curnode 
	 popl -8(%ebp) 
	 
 
	 .L3: 
	 pushl $0 
	# pushl curnode 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $70 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $73 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# making space for 1 local 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $83 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $85 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# making space for 2 local 
	 pushl $0 
	# making space for 2 local 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $106 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call CharNode_getChar 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# reference to the object 
	# pushl newstr 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $106 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_appendChar 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 107: curNode:=curNode.getNext() 
	# pushl curNode 
	 pushl -12(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $107 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call CharNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curNode 
	 popl -12(%ebp) 
	 
 
	 .L7: 
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
	# making space for 2 local 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# Line 120: newstr:=copy() 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $120 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_copy 
	# cleaning up the obj ref 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	# popl newstr 
	 popl -8(%ebp) 
	 
 
	# Line 123: curNode:=str.getCharlist() 
	# pushl str 
	 pushl 12(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $123 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $125 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call CharNode_getChar 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# reference to the object 
	# pushl newstr 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $125 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_appendChar 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	# Clean up this reference pushed on last: 4 
	 addl $4, %esp 
	 
 
	# Line 126: curNode:=curNode.getNext() 
	# pushl curNode 
	 pushl -12(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $126 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call CharNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curNode 
	 popl -12(%ebp) 
	 
 
	 .L9: 
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
	# making space for 1 local 
	 pushl $0 
	# Line 137: newstr:=copy() 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $137 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_copy 
	# cleaning up the obj ref 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	# popl newstr 
	 popl -8(%ebp) 
	 
 
	# Line 139: newstr.appendChar(ch) 
	# pushl ch 
	 pushl 12(%ebp) 
	# reference to the object 
	# pushl newstr 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $139 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# making space for 2 local 
	 pushl $0 
	# making space for 2 local 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $154 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $159 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $162 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $165 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_cat 
	 addl $4, %esp 
	# cleaning up the obj ref 
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
	# making space for 1 local 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $176 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call CharNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curNode 
	 popl -8(%ebp) 
	 
 
	 .L15: 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $180 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# making space for 2 local 
	 pushl $0 
	# making space for 2 local 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $195 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call CharNode_getNext 
	# Clean up THIS obj reference param 
	 addl $4, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# popl curNode 
	 popl -12(%ebp) 
	 
 
	 .L19: 
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
	# making space for 2 local 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# Line 205: len:=length() 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $205 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_length 
	# cleaning up the obj ref 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	# popl len 
	 popl -12(%ebp) 
	 
 
	# Line 206: if not(len=str.length()) then 
	# pushl str 
	 pushl 12(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $206 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# pushl i 
	 pushl -8(%ebp) 
	# pushl str 
	 pushl 12(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $210 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_charAt 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# pushl i 
	 pushl -8(%ebp) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $210 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_charAt 
	 addl $4, %esp 
	# cleaning up the obj ref 
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
	# making space for 2 local 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# Line 221: len:=length() 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $221 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_length 
	# cleaning up the obj ref 
	 addl $4, %esp 
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
	# pushl i 
	 pushl -8(%ebp) 
	# pushl str 
	 pushl 12(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $223 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_charAt 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# pushl i 
	 pushl -8(%ebp) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $223 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_charAt 
	 addl $4, %esp 
	# cleaning up the obj ref 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	# pushl str 
	 pushl 12(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $223 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $226 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $227 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $229 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_charAt 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# pushl i 
	 pushl -8(%ebp) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $229 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_charAt 
	 addl $4, %esp 
	# cleaning up the obj ref 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $236 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_eq 
	 addl $4, %esp 
	# cleaning up the obj ref 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	# pushl str 
	 pushl 12(%ebp) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $236 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_gt 
	 addl $4, %esp 
	# cleaning up the obj ref 
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
	 
 
	# ******** Class Definition: Reader ********  
	# Line 260: readline() is 
Reader_readline: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	# Making space for return value 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# making space for 2 local 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $266 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call Reader_io_read 
	# cleaning up the obj ref 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $269 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $271 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call Reader_io_read 
	# cleaning up the obj ref 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	# popl char 
	 popl -8(%ebp) 
	 
 
	 .L29: 
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
	# making space for 5 local 
	 pushl $0 
	# making space for 5 local 
	 pushl $0 
	# making space for 5 local 
	 pushl $0 
	# making space for 5 local 
	 pushl $0 
	# making space for 5 local 
	 pushl $0 
	# Line 288: s:=readline() 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $288 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call Reader_readline 
	# cleaning up the obj ref 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	# popl s 
	 popl -8(%ebp) 
	 
 
	# Line 289: if s.length()>0 then 
	 pushl $0 
	# pushl s 
	 pushl -8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $289 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $290 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $299 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $301 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	 
 
	# ******** Class Definition: Writer ********  
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $327 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# making space for 1 local 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $338 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $340 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $347 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $350 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $353 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call Writer_writeintHelper 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	 .L42: 
	# Line 354: end if 
	# Line 356: io_write(13) 
	 pushl $13 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $356 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 357: io_write(10) 
	 pushl $10 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $357 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# making space for 2 local 
	 pushl $0 
	# making space for 2 local 
	 pushl $0 
	# Line 367: len:=str.length() 
	# pushl str 
	 pushl 12(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $367 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $370 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call String_charAt 
	# Clean up parameters: (1 * 4) + 4 (this ptr) 
	 addl $8, %esp 
	# Pushing the result from the called function 
	 pushl %eax 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $370 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
	# Checking if the object above is null 
	# pushing line number 
	 pushl $380 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call Writer_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 381: io_write(13) 
	 pushl $13 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $381 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
	 call Writer_io_write 
	# Clean up parameters: 1 * 4 
	 addl $4, %esp 
	 
 
	# Line 382: io_write(10) 
	 pushl $10 
	# reference to the object (this) 
	 pushl 8(%ebp) 
	# Checking if the object above is null 
	# pushing line number 
	 pushl $382 
	 call nullpointertest 
	# Removing the line number from the top of the stack, leaving the obj reference there 
	 addl $4, %esp 
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
