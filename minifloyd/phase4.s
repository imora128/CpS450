.file "phase4.floyd" 
.comm _x,4,4 
.comm _y,4,4 
.comm _z,4,4 
.global main 
main: 
# Line 11: out.writeint(5-1) 
pushl $1 
pushl $5 
call minus 
addl $8, %esp 
pushl %eax 
call writeint 
addl $4, %esp 

 
# Line 12: out.writeint(5-5) 
pushl $5 
pushl $5 
call minus 
addl $8, %esp 
pushl %eax 
call writeint 
addl $4, %esp 

 
# Line 13: out.writeint(5+1) 
pushl $5 
pushl $1 
popl %eax 
popl %ebx 
addl  %eax, %ebx 
pushl %ebx 
call writeint 
addl $4, %esp 

 
# Line 14: out.writeint(5*3) 
pushl $5 
pushl $3 
call times 
addl $8, %esp 
pushl %eax 
call writeint 
addl $4, %esp 

 
# Line 15: out.writeint(5/5) 
pushl $5 
pushl $5 
call division 
addl $8, %esp 
pushl %eax 
call writeint 
addl $4, %esp 

 
# Calling exit because the program is finished 
pushl $0 
call exit 
