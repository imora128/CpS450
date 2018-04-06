.stabs "breakit.floyd",100,0,0,.Ltext0 
.text 
.Ltext0: 
.stabs  "int:t(0,1)=r(0,1);-2147483648;2147483647;",128,0,0,0 
.file "breakit.floyd" 
# Line 2: mov:int
 
.comm mov,4,4 
.stabs  "mov:G(0,1)",32,0,0,0 
# Line 3: x:int
 
.comm x,4,4 
.stabs  "x:G(0,1)",32,0,0,0 
# Line 4: y:int

 
.comm y,4,4 
.stabs  "y:G(0,1)",32,0,0,0 
# Line 6: start() is 
.global main 
.stabs  "main:F",36,0,0,main 
main: 
# Line 9: mov:=12*in.readint() 
.stabn 68,0,9,.line9-main 
.line9: 
pushl $12 
call readint 
pushl %eax 

 
call times 
addl $8, %esp 
pushl %eax 
popl mov 

 
# Line 10: out.writeint(mov) 
.stabn 68,0,10,.line10-main 
.line10: 
pushl mov 
call writeint 
addl $4, %esp 

 
# Line 12: mov:=mov/-1 
.stabn 68,0,12,.line12-main 
.line12: 
pushl $-1 
pushl mov 
call division 
addl $8, %esp 
pushl %eax 
popl mov 

 
# Line 13: out.writeint(mov) 
.stabn 68,0,13,.line13-main 
.line13: 
pushl mov 
call writeint 
addl $4, %esp 

 
# Line 15: mov:=mov*-1 
.stabn 68,0,15,.line15-main 
.line15: 
pushl mov 
pushl $-1 
call times 
addl $8, %esp 
pushl %eax 
popl mov 

 
# Line 16: out.writeint(mov) 
.stabn 68,0,16,.line16-main 
.line16: 
pushl mov 
call writeint 
addl $4, %esp 

 
# Line 18: if (true) then 
.stabn 68,0,18,.line18-main 
.line18: 
pushl $1 
popl %eax 
movl $1, %edx 
cmpl %eax, %edx 
jne .L1 
# Line 19: x:=1 
.stabn 68,0,19,.line19-main 
.line19: 
pushl $1 
popl x 

 
jmp .L3 
.L4: 
# Line 21: y:=2 
.stabn 68,0,21,.line21-main 
.line21: 
pushl $2 
popl y 

 
jmp .L5 
.L6: 
# Line 23: y:=y-1 
.stabn 68,0,23,.line23-main 
.line23: 
pushl $1 
pushl y 
call minus 
addl $8, %esp 
pushl %eax 
popl y 

 
# Line 24: if not(y>=0) then 
.stabn 68,0,24,.line24-main 
.line24: 
pushl $0 
pushl y 
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
.stabn 68,0,25,.line25-main 
.line25: 
pushl y 
call writeint 
addl $4, %esp 

 
jmp .L8 
.L7: 
.L8: 
# Line 26: end if 
.L5: 
# Line 22: y>-2 
.stabn 68,0,22,.line22-main 
.line22: 
pushl $-2 
pushl y 
call greaterThan 
addl $8, %esp 
pushl %eax 
pop %eax 
cmpl $0, %eax 
jne .L6 
# Line 27: end loop 
# Line 28: out.writeint(x) 
.stabn 68,0,28,.line28-main 
.line28: 
pushl x 
call writeint 
addl $4, %esp 

 
# Line 29: x:=x+1 
.stabn 68,0,29,.line29-main 
.line29: 
pushl x 
pushl $1 
popl %eax 
popl %ebx 
addl  %eax, %ebx 
pushl %ebx 
popl x 

 
.L3: 
# Line 20: not(x>3) 
.stabn 68,0,20,.line20-main 
.line20: 
pushl $3 
pushl x 
call greaterThan 
addl $8, %esp 
pushl %eax 
call unaryNot 
addl $4, %esp 
pushl %eax 
pop %eax 
cmpl $0, %eax 
jne .L4 
# Line 30: end loop 
jmp .L2 
.L1: 
.L2: 
# Line 31: end if 
# Line 33: end start 
.stabn 68,0,34,.line34-main 
.line34: 
# Calling exit because the program is finished 
pushl $0 
call exit 
