.file "phase4.floyd" 
.comm _mov,4,4 
.comm _x,4,4 
.comm _y,4,4 
.global main 
main: 
# Line 9: mov:=12*10 
pushl $12 
pushl $10 
call times 
addl $8, %esp 
pushl %eax 
popl _mov 

 
# Line 10: out.writeint(mov) 
pushl _mov 
call writeint 
addl $4, %esp 

 
# Line 12: mov:=mov/-1 
pushl $-1 
pushl _mov 
call division 
addl $8, %esp 
pushl %eax 
popl _mov 

 
# Line 13: out.writeint(mov) 
pushl _mov 
call writeint 
addl $4, %esp 

 
# Line 15: mov:=mov*-1 
pushl _mov 
pushl $-1 
call times 
addl $8, %esp 
pushl %eax 
popl _mov 

 
# Line 16: out.writeint(mov) 
pushl _mov 
call writeint 
addl $4, %esp 

 
# Line 18: if stmt 
pushl $1 
popl %eax 
movl $1, %edx 
cmpl %eax, %edx 
jne .L1 
# Line 19: x:=1 
pushl $1 
popl _x 

 
# Line 20: while stmt 
jmp .L3 
.L4: 
# Line 21: y:=2 
pushl $2 
popl _y 

 
# Line 22: while stmt 
jmp .L5 
.L6: 
# Line 23: y:=y-1 
pushl $1 
pushl _y 
call minus 
addl $8, %esp 
pushl %eax 
popl _y 

 
# Line 24: if stmt 
pushl $0 
pushl _y 
call greaterEqual 
addl $8, %esp 
pushl %eax 
call unaryNot 
addl $4, %esp 
pushl %eax 
popl %eax 
movl $1, %edx 
cmpl %eax, %edx 
jne .L7 
# Line 25: out.writeint(y) 
pushl _y 
call writeint 
addl $4, %esp 

 
jmp .L8 
.L7: 
.L8: 
.L5: 
pushl $-2 
pushl _y 
call greaterThan 
addl $8, %esp 
pushl %eax 
pop %eax 
cmpl $0, %eax 
jne .L6 
# Line 28: out.writeint(x) 
pushl _x 
call writeint 
addl $4, %esp 

 
# Line 29: x:=x+1 
pushl _x 
pushl $1 
popl %eax 
popl %ebx 
addl  %eax, %ebx 
pushl %ebx 
popl _x 

 
.L3: 
pushl $3 
pushl _x 
call greaterThan 
addl $8, %esp 
pushl %eax 
call unaryNot 
addl $4, %esp 
pushl %eax 
pop %eax 
cmpl $0, %eax 
jne .L4 
jmp .L2 
.L1: 
.L2: 
# Calling exit because the program is finished 
pushl $0 
call exit 
