.file "jaja.floyd" 
# Line 6: d:int
 
.comm d,4,4 
# Line 7: meth1() is 
meth1: 
# Line 11: c:=5 
pushl $5 
popl c 

 
# Line 12: meth1:=c 
pushl c 
popl meth1 

 
# Line 14: end meth1 
# Line 15: start() is 
start: 
# Line 18: num:=meth1 
pushl meth1 
popl num 

 
# Line 19: out.writeint(meth1) 
pushl meth1 
call writeint 
addl $4, %esp 

 
# Line 20: end start 
# Calling exit because the program is finished 
pushl $0 
call exit 
