.file "phase4.floyd" 
.comm _x,4,4 
.global main 
main: 
# Line 8: x:=-5 
pushl $-5 
popl _x 

 
# Line 9: if stmt 
pushl $1 
pushl $5 
call eqTo 
addl $8, %esp 
pushl %eax 
popl %eax 
movl $1, %edx 
cmpl %eax, %edx 
jne .L0 
# Line 10: out.writeint(0) 
pushl $0 
call writeint 
addl $4, %esp 

 
jmp .L1 
.L0: 
# Line 12: out.writeint(-1) 
pushl $-1 
call writeint 
addl $4, %esp 

 
.L1: 
# Calling exit because the program is finished 
pushl $0 
call exit 
