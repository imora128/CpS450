.file "phase4.floyd" 
.comm _x,4,4 
.global main 
main: 
# Line 12: x:=-1 
pushl $-1 
popl _x 

 
# Line 13: if stmt 
pushl $0 
pushl _x 
call greaterThan 
addl $8, %esp 
pushl %eax 
popl %eax 
movl $1, %edx 
cmpl %eax, %edx 
jne .L1 
# Line 14: out.writeint(1) 
pushl $1 
call writeint 
addl $4, %esp 

 
jmp .L2 
.L1: 
# Line 16: if stmt 
pushl $0 
pushl _x 
call eqTo 
addl $8, %esp 
pushl %eax 
popl %eax 
movl $1, %edx 
cmpl %eax, %edx 
jne .L3 
# Line 17: out.writeint(0) 
pushl $0 
call writeint 
addl $4, %esp 

 
jmp .L4 
.L3: 
# Line 19: out.writeint(-1) 
pushl $-1 
call writeint 
addl $4, %esp 

 
.L4: 
# Line 21: out.writeint(9) 
pushl $9 
call writeint 
addl $4, %esp 

 
.L2: 
# Line 23: out.writeint(9) 
pushl $9 
call writeint 
addl $4, %esp 

 
# Calling exit because the program is finished 
pushl $0 
call exit 
