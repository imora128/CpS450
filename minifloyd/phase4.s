.file "phase4.floyd" 
.comm _x,4,4 
.comm _y,4,4 
.comm _z,4,4 
.global main 
main: 
# Line 11: out.writeint(-(9-5)) 
pushl $5 
pushl $9 
call minus 
addl $8, %esp 
pushl %eax 
call unaryMinus 
addl $8, %esp 
pushl %eax 
call writeint 
addl $4, %esp 

 
# Calling exit because the program is finished 
pushl $0 
call exit 
