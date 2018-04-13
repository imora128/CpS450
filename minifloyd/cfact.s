	 .file "cfact.floyd" 
	# Line 6: num:int
 
	 .comm num,4,4 
	# Line 7: num2:int

 
	 .comm num2,4,4 
	# Line 9: Fact() is 
Fact: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	 push $0 
	# Line 12: if num=0 then 
	 pushl $0 
	# pushl num 
	 pushl 8(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L1 
	# Line 13: answer:=1 
	 pushl $1 
	# popl answer 
	 popl -8(%ebp) 
	 
 
	 jmp .L2 
	 .L1: 
	# Line 14: Else 
	# Line 15: answer:=num*Fact(num-1) 
	# pushl num 
	 pushl 8(%ebp) 
	 pushl $1 
	# pushl num 
	 pushl 8(%ebp) 
	 call minus 
	 addl $8, %esp 
	 pushl %eax 
	 call Fact 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	 call times 
	 addl $8, %esp 
	 pushl %eax 
	# popl answer 
	 popl -8(%ebp) 
	 
 
	 .L2: 
	# Line 16: end if 
	# Line 17: Fact:=answer 
	# pushl answer 
	 pushl -8(%ebp) 
	# popl Fact 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 20: end Fact 
	# Line 21: Go() is 
Go: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	 push $0 
	# Line 24: isOk:=false 
	 pushl $0 
	# popl isOk 
	 popl -8(%ebp) 
	 
 
	 jmp .L3 
	 .L4: 
	# Line 26: num:=in.readint() 
	 call readint 
	 pushl %eax 
	 
 
	 popl num 
	 
 
	# Line 27: isOk:=(num>=1) 
	 pushl $1 
	 pushl num 
	 call greaterEqual 
	 addl $8, %esp 
	 pushl %eax 
	# popl isOk 
	 popl -8(%ebp) 
	 
 
	 .L3: 
	# Line 25: notisOk 
	# pushl isOk 
	 pushl -8(%ebp) 
	 call unaryNot 
	 addl $4, %esp 
	 pushl %eax 
	 pop %eax 
	 cmpl $0, %eax 
	 jne .L4 
	# Line 28: end loop 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 30: end Go 
	# Line 31: start() is 
.global main 
main: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	# Line 33: Go() 
	 call Go 
	 
 
	# Line 34: num2:=Fact(num) 
	 pushl num 
	 call Fact 
	 addl $4, %esp 
	 pushl %eax 
	 
 
	 popl num2 
	 
 
	# Line 35: out.writeint(num) 
	 pushl num 
	 call writeint 
	 addl $4, %esp 
	 
 
	# Line 36: out.writeint(num2) 
	 pushl num2 
	 call writeint 
	 addl $4, %esp 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 37: end start 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
