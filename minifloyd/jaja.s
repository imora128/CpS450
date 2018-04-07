.file "jaja.floyd" 
# Line 6: d:int
 
.comm d,4,4 
# Line 7: meth1() is 
meth1: 
# Function preamble 
pushl %ebp 
movl %esp, %ebp 
# Line 10: c:=99 
pushl $99 
# popl c 
popl %edx 
movl %edx, -8(%ebp) 

 
# Line 11: out.writeint(c) 
# pushl c 
pushl -8(%ebp) 
call writeint 
addl $4, %esp 

 
# Line 12: meth1:=50 
pushl $50 
# popl meth1 
popl %edx 
movl %edx, -4(%ebp) 

 
# Moving the value inside the return value section of the stack into eax 
movl -4(%ebp), %eax 
# cleaning up the stack and returnig 
leave 
ret 
# Line 14: end meth1 
# Line 15: start() is 
.global main 
main: 
# Function preamble 
pushl %ebp 
movl %esp, %ebp 
# Line 19: out.writeint(11) 
pushl $11 
call writeint 
addl $4, %esp 

 
# Line 20: d:=meth1(1,2) 
pushl $2 
pushl $1 
call meth1 
addl $8, %esp 
pushl %eax 

 
popl d 

 
# Line 21: out.writeint(d) 
pushl d 
call writeint 
addl $4, %esp 

 
# Line 22: num:=d 
pushl d 
# popl num 
popl %edx 
movl %edx, -8(%ebp) 

 
# Line 23: out.writeint(num) 
# pushl num 
pushl -8(%ebp) 
call writeint 
addl $4, %esp 

 
# Line 24: end start 
# Calling exit because the program is finished 
pushl $0 
call exit 
