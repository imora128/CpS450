.file "phase4.floyd" 
.comm _x,4,4 
.comm _y,4,4 
.comm _z,4,4 
.global main 
main: 
# Line 11: x:=5 
pushl $5 
popl _x 

 
# Line 12: y:=2 
pushl $2 
popl _y 

 
# Line 13: z:=x*y 
pushl _x 
pushl _y 
call times 
addl $8, %esp 
pushl %eax 
popl _z 

 
# Line 14: out.writeint(z) 
pushl _z 
call writeint 
addl $4, %esp 

 
# Line 15: z:=x*10 
pushl _x 
pushl $10 
call times 
addl $8, %esp 
pushl %eax 
popl _z 

 
# Line 16: out.writeint(z) 
pushl _z 
call writeint 
addl $4, %esp 

 
# Calling exit because the program is finished 
pushl $0 
call exit 
