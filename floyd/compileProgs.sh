#!/bin/bash
stdlib=./stdlib.floyd



#We'll only process one cmd line argument. If it's clean, we clean, otherwise we just build
if [ "$1" = "clean" ] && [ $# -eq 1 ];
then
	#Cleaning up object and assembly files
	rm *.o
	rm *.s
	#cleaning up our gradle generated junk
	./gradlew clean
	#looping through floyd files in cwd
	for filename in ./*.floyd
	do
		#we delete all the executables here
		 if [ $stdlib != $filename ] 
		 then
		 #removing extension and the ./
		 filename1=$(basename -- "$filename")
		 filename1="${filename1%.*}"
		 rm $filename1
		 fi
	done
#Compilation case
else
	#Compiling the stdlib.c object file here
	make
	#building floyd project
	./gradlew clean install
	#looping through all floyd files in cwd
	for filename in ./*.floyd

	do
		#If it's not the standard library file, we give it as a parameter to the program
		 if [ $stdlib != $filename ] 
		 then
		 	#removing the path stuff
			filename1=$(basename -- "$filename")
		 	build/install/floyd/bin/floyd $filename1
		 	#echoing the command we run so that the user can see progress
		 	echo "build/install/floyd/bin/floyd $filename1"
		 fi
	done
fi
