	 .file "cgcd.floyd" 
	# Line 6: x:int
 
	 .comm x,4,4 
	# Line 7: y:int
 
	 .comm y,4,4 
	# Line 8: ans:int

 
	 .comm ans,4,4 
	# Line 10: gcd() is 
gcd: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	# Line 12: if b=0 then 
	 pushl $0 
	# pushl b 
	 pushl 12(%ebp) 
	 call eqTo 
	 addl $8, %esp 
	 pushl %eax 
	 popl %eax 
	 movl $1, %edx 
	 cmpl %eax, %edx 
	 jne .L1 
	# Line 13: gcd:=a 
	# pushl a 
	 pushl 8(%ebp) 
	# popl gcd 
	 popl -4(%ebp) 
	 
 
	 jmp .L2 
	 .L1: 
	# Line 14: Else 
	# Line 15: a:=gcd(b,a-(a/b)*b) 
	# pushl b 
	 pushl 12(%ebp) 
	# pushl a 
	 pushl 8(%ebp) 
	 call division 
	 addl $8, %esp 
	 pushl %eax 
	# pushl b 
	 pushl 12(%ebp) 
	 call times 
	 addl $8, %esp 
	 pushl %eax 
	# pushl a 
	 pushl 8(%ebp) 
	 call minus 
	 addl $8, %esp 
	 pushl %eax 
	# pushl b 
	 pushl 12(%ebp) 
	 call gcd 
	 addl $8, %esp 
	 pushl %eax 
	 
 
	# popl a 
	 popl 8(%ebp) 
	 
 
	# Line 16: gcd:=a 
	# pushl a 
	 pushl 8(%ebp) 
	# popl gcd 
	 popl -4(%ebp) 
	 
 
	 .L2: 
	# Line 17: end if 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 19: end gcd 
	# Line 20: displayres() is 
displayres: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	# Line 22: out.writeint(ans) 
	# pushl ans 
	 pushl 8(%ebp) 
	 call writeint 
	 addl $4, %esp 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 24: end displayres 
	# Line 25: start() is 
.global main 
main: 
	# Function preamble 
	 pushl %ebp 
	 movl %esp, %ebp 
	 push $0 
	# Line 27: x:=in.readint() 
	 call readint 
	 pushl %eax 
	 
 
	 popl x 
	 
 
	# Line 28: y:=in.readint() 
	 call readint 
	 pushl %eax 
	 
 
	 popl y 
	 
 
	# Line 29: ans:=gcd(x,y) 
	 pushl y 
	 pushl x 
	 call gcd 
	 addl $8, %esp 
	 pushl %eax 
	 
 
	 popl ans 
	 
 
	# Line 30: displayres(ans) 
	 pushl ans 
	 call displayres 
	 addl $4, %esp 
	 
 
	# Moving the value inside the return value section of the stack into eax 
	 movl -4(%ebp), %eax 
	# cleaning up the stack and returnig 
	 leave 
	 ret 
	# Line 31: end start 
	# Calling exit because the program is finished 
	 pushl $0 
	 call exit 
