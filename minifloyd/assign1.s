.file "assign1.floyd" 
.comm _x,4,4 
.comm _y,4,4 
.comm _z,4,4 
.comm _b1,4,4 
.comm _b2,4,4 
.global main 
main: 
# Line 14: x:=5 
pushl $5 
popl _x 

 
# Line 15: y:=x*(8-x) 
pushl _x 
pushl _x 
pushl $8 
call minus 
addl $8, %esp 
pushl %eax 
call times 
addl $8, %esp 
pushl %eax 
popl _y 

 
# Line 17: b1:=true 
pushl $1 
popl _b1 

 
# Line 18: b2:=notfalse 
pushl $0 
call unaryNot 
addl $4, %esp 
pushl %eax 
popl _b2 

 
# Line 19: b2:=not(notb2orb1) 
pushl _b1 
pushl _b2 
call unaryNot 
addl $4, %esp 
pushl %eax 
call orOp 
addl $8, %esp 
pushl %eax 
call unaryNot 
addl $4, %esp 
pushl %eax 
popl _b2 

 
# Line 21: out.writeint(y) 
pushl _y 
call writeint 
addl $4, %esp 

 
# Line 22: out.writeint(x/2) 
pushl $2 
pushl _x 
call division 
addl $8, %esp 
pushl %eax 
call writeint 
addl $4, %esp 

 
# Line 24: y:=y-x 
pushl _x 
pushl _y 
call minus 
addl $8, %esp 
pushl %eax 
popl _y 

 
# Line 25: out.writeint(y+4) 
pushl _y 
pushl $4 
popl %eax 
popl %ebx 
addl  %eax, %ebx 
pushl %ebx 
call writeint 
addl $4, %esp 

 
# Line 26: out.writeint(-(9-5)) 
pushl $5 
pushl $9 
call minus 
addl $8, %esp 
pushl %eax 
call unaryMinus 
addl $4, %esp 
pushl %eax 
call writeint 
addl $4, %esp 

 
# Line 27: out.writeint(5-2*3+1) 
pushl $2 
pushl $3 
call times 
addl $8, %esp 
pushl %eax 
pushl $5 
call minus 
addl $8, %esp 
pushl %eax 
pushl $1 
popl %eax 
popl %ebx 
addl  %eax, %ebx 
pushl %ebx 
call writeint 
addl $4, %esp 

 
# Calling exit because the program is finished 
pushl $0 
call exit 
