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
            System.out.println("usage: minifloyd [-ds] [-dp] [-S] [-g] <filename>");
            System.exit(1);
        }
        //LIBRARY READING IN BROSITO
        CharStream library = CharStreams.fromFileName("stdlib.floyd");
        Option libraryArgs = new Option();
        libraryArgs.s = false;
        libraryArgs.dp = false;
        libraryArgs.ds = false;
        libraryArgs.g = false;
        libraryArgs.fileName.add("stdlib.floyd");
        MyFloydLexer libLexer = new MyFloydLexer(library, false, libraryArgs); 
        CommonTokenStream libTokens = new CommonTokenStream(libLexer);
        FloydParser libParser = new FloydParser(libTokens);
        libParser.removeErrorListener(ConsoleErrorListener.INSTANCE);
        libParser.addErrorListener(new MyFloydErrorListener(libraryArgs));
        ParseTree libTree = libParser.start();
        ParseTreeWalker.DEFAULT.walk(new SemanticChecker(libraryArgs), libTree);
        //Creating an Option argument. Defined in opition.java.
        Option parsedArgs = new Option();
        parsedArgs.semanticErrors = libraryArgs.semanticErrors;
        //Parses the cmdline arguments so I can use it down bellow
        parsedArgs.getCommandLineArguments(arguments);
        CharStream input = CharStreams.fromFileName(parsedArgs.fileName.get(0));
        MyFloydLexer lexer = new MyFloydLexer(input, parsedArgs.ds, parsedArgs);


        CommonTokenStream tokens = new CommonTokenStream(lexer);
        FloydParser parser = new FloydParser(tokens);
        parser.removeErrorListener(ConsoleErrorListener.INSTANCE);
        parser.addErrorListener(new MyFloydErrorListener(parsedArgs));
        
        ParseTree tree = parser.start();
        ParseTreeWalker.DEFAULT.walk(new SemanticChecker(parsedArgs), tree);
        if (parsedArgs.semanticErrors == 0) {
        //if (false) {
        	CodeGen boo = new CodeGen(libraryArgs, 0);
        	boo.visit(libTree);
        	System.out.println("libargs counter: + " + libraryArgs.labelCounter);
        	CodeGen foo = new CodeGen(parsedArgs, libraryArgs.labelCounter);
        	foo.visit(tree);
        	//appending the exit instructions to the end of the file
        	foo.instructions.addAll(boo.instructions);
        	foo.writeToFile(parsedArgs.s);
        	
        	
        } else {
        	System.out.println(String.format("ERROR: %s semantic error(s). Code generation will not execute" +
        			" until those are fixed.", parsedArgs.semanticErrors));
        }
        if (parsedArgs.dp) {
            Trees.inspect(tree, parser);
        }
        System.out.println((parser.getNumberOfSyntaxErrors() + lexer.lexerErrors) + " lexical/syntactic error(s) found.");
        System.out.println("Semantic errors: " + parsedArgs.semanticErrors);

    }

}

