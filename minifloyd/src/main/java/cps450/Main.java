/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: Main.java
Description: Contains the main body of the program
*/
package cps450;
import java.io.IOException;

import org.antlr.v4.gui.Trees;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.ConsoleErrorListener;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;

public class Main
{
    public static void main(String[] arguments) throws IOException {
        // if the user doesn't pass in any arguments, print usage and exit
        if (arguments.length < 1) {
            System.out.println("minifloyd [-ds] [-dp] <filename>");
            System.exit(1);
        }
        
        //Creating an Option argument. Defined in opition.java.
        Option parsedArgs = new Option();
        //Parses the cmdline arguments so I can use it down bellow
        parsedArgs.getCommandLineArguments(arguments);
        //System.out.println("DS: " + parsedArgs.ds + " DP: " + parsedArgs.dp + " filenames: 1: " + parsedArgs.fileName.get(0) + " 2:"+  parsedArgs.fileName.get(1));
        //will worry about exception handling later
        CharStream input = CharStreams.fromFileName(parsedArgs.fileName.get(0));
        MyFloydLexer lexer = new MyFloydLexer(input, parsedArgs.ds, parsedArgs);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        FloydParser parser = new FloydParser(tokens);
        parser.removeErrorListener(ConsoleErrorListener.INSTANCE);
        parser.addErrorListener(new MyFloydErrorListener(parsedArgs));
        
        ParseTree tree = parser.start();
        SymbolTable symTable = SymbolTable.getInstance();
        if (true) {
        	ParseTreeWalker.DEFAULT.walk(new SemanticChecker(parsedArgs), tree);
        	symTable.printSymTable();
        }
        //builds tree if the user gave dp as an rgument
        if (parsedArgs.dp) {
            Trees.inspect(tree, parser);
        }
        System.out.println((parser.getNumberOfSyntaxErrors() + lexer.lexerErrors) + " lexical/syntactic error(s) found.");

    }

}

