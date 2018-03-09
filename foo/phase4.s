.file "phase4.floyd" 
.comm _x,4,4 
.global main 
main: 
# Line 10: x:=5-4 
pushl $4 
pushl $5 
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
