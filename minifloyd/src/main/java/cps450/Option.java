/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: Option.java
Description: Defines the Option class. It is responsible for parsing the cmd line arguments and storing them
as instance variables.
*/
package cps450;
import java.util.ArrayList;
import java.util.List;


/*
Class Name: Option
Instance vars: 
        ds: (BOOL) True if the user provides the option. False by default.
        fileName: (STRING) Filename provided by the user.
*/
public class Option {
     boolean ds;
     boolean dp;
     boolean s;
     int semanticErrors = 0;
     List<String> fileName = new ArrayList<String>();

    Option() {
        ds = false;
        dp = false;
        s = false;
    }
    /*
    Function Name: getCommandLineArguments
    Parameters: cmdline arguments array <args>
    Description: Loops through <args> looking for strings that match optins the users can select. 
    The last index of <args> will always be the filename.
    */
    void getCommandLineArguments(String[] args) {
        for (int i = 0; i < args.length; i++) {
            if ((i == 0 || i == 1 || i == 2) && args[i].equals("-ds")) {
                ds = true;
            } else if ((i == 0 || i == 1 || i == 2) && args[i].equals("-dp")) {
                dp = true;
            } else if ((i == 0 || i == 1 || i == 2) && args[i].equals("-S")) {
            	s = true;
            }
            else {
            	String ext = args[i].substring(args[i].lastIndexOf(".") + 1, args[i].length());
            	if (ext.equals("floyd")) {
                fileName.add(args[i]);
                return;
            	}
            	System.out.println("usage: minifloyd [-ds] [-dp] [-S] <floyd_source_filename>");
            	System.exit(0);
            }
            
        }
    }
}