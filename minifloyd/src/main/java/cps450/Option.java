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


public class Option {
     boolean ds;
     boolean dp;
     boolean s;
     boolean g;
     int labelCounter = 0;
     int semanticErrors = 0;
     List<Symbol> symbolTable = new ArrayList<Symbol>();
     List<String> fileName = new ArrayList<String>();

    Option() {
        ds = false;
        dp = false;
        s = false;
        g = false;
    }
    /*
    Function Name: getCommandLineArguments
    Parameters: cmdline arguments array <args>
    Description: Loops through <args> looking for strings that match optins the users can select. 
    The last index of <args> will always be the filename.
    */
    void getCommandLineArguments(String[] args) {
        for (int i = 0; i < args.length; i++) {
            if ((i == 0 || i == 1 || i == 2 || i == 3) && args[i].equals("-ds")) {
                ds = true;
            } else if ((i == 0 || i == 1 || i == 2 || i == 3) && args[i].equals("-dp")) {
                dp = true;
            } else if ((i == 0 || i == 1 || i == 2 || i == 3) && args[i].equals("-S")) {
            	s = true;
            }else if ((i == 0 || i == 1 || i == 2 || i == 3) && args[i].equals("-g")) {
            	g = true;
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