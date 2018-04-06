.file "jaja.floyd" 
# Line 6: d:int
 
.comm d,4,4 
# Line 7: meth1() is 
meth1: 
# Line 11: c:=5 
pushl $5 
popl c 

 
# Line 12: d:=2 
pushl $2 
popl d 

 
# Line 13: meth1:=c 
# pushl c 
pushl -8(%ebp) 
popl meth1 

 
# Line 14: meth1:=d 
# pushl d 
pushl -12(%ebp) 
popl meth1 

 
# Line 16: end meth1 
# Line 17: start() is 
.global main 
# Line 20: num:=meth1(1,2) 
call meth1 
addl $8, %esp 
pushl %eax 

 
popl num 

 
# Line 21: out.writeint(num) 
# pushl num 
pushl -8(%ebp) 
call writeint 
addl $4, %esp 

 
# Line 22: end start 
# Calling exit because the program is finished 
pushl $0 
call exit 
