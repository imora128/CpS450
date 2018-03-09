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
//FIXME(Parsing logic. check the extension of all things that aren't -s, -ds, -dp, and if it isn't .floyd, give usage msg)

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
        //System.out.println(args.length);
        //Will loop through the array looking for which options the users gave us and 
        //set the specific bool to true when found
        for (int i = 0; i < args.length; i++) {
            if ((i == 0 || i == 1 || i == 2) && args[i].equals("-ds")) {
                ds = true;
            } else if ((i == 0 || i == 1 || i == 2) && args[i].equals("-dp")) {
                dp = true;
            } else if ((i == 0 || i == 1 || i == 2) && args[i].equals("-s")) {
            	s = true;
            }
            else {
                fileName.add(args[i]);
            }
        }
    }
}