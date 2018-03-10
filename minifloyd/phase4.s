.file "phase4.floyd" 
.comm _i1,4,4 
.comm _i2,4,4 
.comm _q,4,4 
.global main 
main: 
# Line 10: q:=nottrue 
pushl $1 
call unaryNot 
addl $4, %esp 
pushl %eax 
popl _q 

 
# Line 11: out.writeint(+5) 
pushl $5 
call unaryPlus 
addl $4, %esp 
pushl %eax 
call writeint 
addl $4, %esp 

 
# Line 12: i1:=-5 
pushl $-5 
popl _i1 

 
# Line 13: out.writeint(+i1) 
pushl _i1 
call unaryPlus 
addl $4, %esp 
pushl %eax 
call writeint 
addl $4, %esp 

 
# Calling exit because the program is finished 
pushl $0 
call exit 
