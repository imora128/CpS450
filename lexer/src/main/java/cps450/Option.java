/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: Option.java
Description: Defines the Option class. It is responsible for parsing the cmd line arguments and storing them
as instance variables.
*/
package cps450;

/*
Class Name: Option
Instance vars: 
        ds: (BOOL) True if the user provides the option. False by default.
        fileName: (STRING) Filename provided by the user.
*/
public class Option {
     boolean ds;
     String fileName;

    Option() {
        ds = false;
        fileName = "";
    }
    /*
    Function Name: getCommandLineArguments
    Parameters: cmdline arguments array <args>
    Description: Loops through <args> looking for strings that match optins the users can select. 
    The last index of <args> will always be the filename.
    */
    void getCommandLineArguments(String[] args) {
        //System.out.println(args.length);
        //Will loop through the array looking for which options the users gave us and set the specific bool to true when found
        for (int i = 0; i < args.length; i++) {
            if ( args[i].equals("-ds")) {
                ds = true;
            } 
        }
        //After it's looped through the args, the last argument will be set as the file name.
        fileName = args[(args.length - 1)];
    }
}