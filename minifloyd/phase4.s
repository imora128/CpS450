.file "phase4.floyd" 
.comm _x,4,4 
.global main 
main: 
# Line 10: x:=10-9 
pushl $9 
pushl $10 
call minus 
addl $8, %esp 
pushl %eax 
popl _x 

 
# Line 11: out.writeint(x) 
pushl _x 
call writeint 
addl $4, %esp 

 
# Calling exit because the program is finished 
pushl $0 
call exit 
