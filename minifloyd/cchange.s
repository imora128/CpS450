	 .file "cchange.floyd" 
	# Line 6: Amt:int
 
	 .comm Amt,4,4 
	# Line 7: Quarters:int
 
	 .comm Quarters,4,4 
	# Line 8: Dimes:int
 
	 .comm Dimes,4,4 
	# Line 9: Nickels:int

 
	 .comm Nickels,4,4 
	# Line 11: ComputeChange() is 
ComputeChange: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	# Line 13: ComputeChange:=amt/denom 
	# pushl denom 
	 pushl 12(%ebp) 
	# pushl amt 
	 pushl 8(%ebp) 
	 call division 
	 addl $8, %esp 
	 pushl %eax 
	# popl ComputeChange 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 15: end ComputeChange 
	# Line 16: ComputeRemain() is 
ComputeRemain: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	# Line 18: ComputeRemain:=amt-denom*qtydenom 
	# pushl denom 
	 pushl 12(%ebp) 
	# pushl qtydenom 
	 pushl 16(%ebp) 
	 call times 
	 addl $8, %esp 
	 pushl %eax 
	# pushl amt 
	 pushl 8(%ebp) 
	 call minus 
	 addl $8, %esp 
	 pushl %eax 
	# popl ComputeRemain 
	 popl -4(%ebp) 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 20: end ComputeRemain 
	# Line 21: start() is 
.global main 
main: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	# Line 23: Amt:=in.readint() 
	 call readint 
	 pushl %eax 
	 
 
	 popl Amt 
	 
 
	# Line 27: Quarters:=ComputeChange(Amt,25) 
	 pushl $25 
	 pushl Amt 
	 call ComputeChange 
	 addl $8, %esp 
	 pushl %eax 
	 
 
	 popl Quarters 
	 
 
	# Line 28: if (Quarters>0) then 
	 pushl $0 
	 pushl Quarters 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L1 
	# Line 29: out.writeint(Quarters) 
	 pushl Quarters 
	 call writeint 
	 addl $4, %esp 
	 
 
	 jmp .L2 
	 .L1: 
	# Line 30: Else 
	# Line 31: out.writeint(0) 
	 pushl $0 
	 call writeint 
	 addl $4, %esp 
	 
 
	 .L2: 
	# Line 32: end if 
	# Line 33: Amt:=ComputeRemain(Amt,25,Quarters) 
	 pushl Quarters 
	 pushl $25 
	 pushl Amt 
	 call ComputeRemain 
	 addl $12, %esp 
	 pushl %eax 
	 
 
	 popl Amt 
	 
 
	# Line 36: Dimes:=ComputeChange(Amt,10) 
	 pushl $10 
	 pushl Amt 
	 call ComputeChange 
	 addl $8, %esp 
	 pushl %eax 
	 
 
	 popl Dimes 
	 
 
	# Line 37: if (Dimes>0) then 
	 pushl $0 
	 pushl Dimes 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L3 
	# Line 38: out.writeint(Dimes) 
	 pushl Dimes 
	 call writeint 
	 addl $4, %esp 
	 
 
	 jmp .L4 
	 .L3: 
	# Line 39: Else 
	# Line 40: out.writeint(0) 
	 pushl $0 
	 call writeint 
	 addl $4, %esp 
	 
 
	 .L4: 
	# Line 41: end if 
	# Line 42: Amt:=ComputeRemain(Amt,10,Dimes) 
	 pushl Dimes 
	 pushl $10 
	 pushl Amt 
	 call ComputeRemain 
	 addl $12, %esp 
	 pushl %eax 
	 
 
	 popl Amt 
	 
 
	# Line 44: Nickels:=ComputeChange(Amt,5) 
	 pushl $5 
	 pushl Amt 
	 call ComputeChange 
	 addl $8, %esp 
	 pushl %eax 
	 
 
	 popl Nickels 
	 
 
	# Line 45: if (Nickels>0) then 
	 pushl $0 
	 pushl Nickels 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L5 
	# Line 46: out.writeint(Nickels) 
	 pushl Nickels 
	 call writeint 
	 addl $4, %esp 
	 
 
	 jmp .L6 
	 .L5: 
	# Line 47: Else 
	# Line 48: out.writeint(0) 
	 pushl $0 
	 call writeint 
	 addl $4, %esp 
	 
 
	 .L6: 
	# Line 49: end if 
	# Line 51: Amt:=ComputeRemain(Amt,5,Nickels) 
	 pushl Nickels 
	 pushl $5 
	 pushl Amt 
	 call ComputeRemain 
	 addl $12, %esp 
	 pushl %eax 
	 
 
	 popl Amt 
	 
 
	# Line 53: if (Amt>0) then 
	 pushl $0 
	 pushl Amt 
	 call greaterThan 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L7 
	# Line 54: out.writeint(Amt) 
	 pushl Amt 
	 call writeint 
	 addl $4, %esp 
	 
 
	 jmp .L8 
	 .L7: 
	 .L8: 
	# Line 55: end if 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 57: end start 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
