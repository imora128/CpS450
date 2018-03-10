.file "phase4.floyd" 
.comm _i1,4,4 
.comm _i2,4,4 
.comm _q,4,4 
.global main 
main: 
# Line 10: q:=trueandfalse 
pushl 0 
pushl 1 
call andOp 
addl $8, %esp 
pushl %eax 
popl _q 

 
# Calling exit because the program is finished 
pushl $0 
call exit 
