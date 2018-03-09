.file "phase4.floyd" 
.comm _x,4,4 
.comm _y,4,4 
.comm _z,4,4 
.global main 
main: 
# Line 11: z:=-5/1 
pushl $1 
pushl $-5 
call division 
addl $8, %esp 
pushl %eax 
popl _z 

 
# Line 12: out.writeint(z) 
pushl _z 
call writeint 
addl $4, %esp 

 
# Line 13: z:=-20/3 
pushl $3 
pushl $-20 
call division 
addl $8, %esp 
pushl %eax 
popl _z 

 
# Line 14: out.writeint(z) 
pushl _z 
call writeint 
addl $4, %esp 

 
# Calling exit because the program is finished 
pushl $0 
call exit 
