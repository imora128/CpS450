/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: Main.java
Description: Contains the main body of the program.
*/
package cps450;
import java.io.File;
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
            System.out.println("usage: floyd [-ds] [-dp] [-S] <floyd_source_filename>");
            System.exit(1);
        }
        //A standard library file is required and should be provided.
        if (!new File("stdlib.floyd").isFile()) {
        	System.out.println("ERROR: Floyd standard library is not in the cwd.");
        	return;
        }
        //--------------------------------------------------------------------------------------------------------------
        //Performing semantic checks on the library file
        //--------------------------------------------------------------------------------------------------------------
        //This needs to be done first. The symbol table needs to have all the info from the library inside of it
        //before it tries to process the user's floyd file
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
        
        //--------------------------------------------------------------------------------------------------------------
        //Performing semantic checks on the file given by the user
        //--------------------------------------------------------------------------------------------------------------
        //Creating an Option argument. Defined in opition.java.
        Option parsedArgs = new Option();
        parsedArgs.semanticErrors = libraryArgs.semanticErrors;
        //Parses the cmdline arguments so I can use it down bellow
        parsedArgs.getCommandLineArguments(arguments);
        if (!new File(parsedArgs.fileName.get(0)).isFile()) {
        	System.out.println(String.format("ERROR: %s is not in the cwd.", parsedArgs.fileName.get(0)));
        	return;
        }
        CharStream input = CharStreams.fromFileName(parsedArgs.fileName.get(0));
        MyFloydLexer lexer = new MyFloydLexer(input, parsedArgs.ds, parsedArgs);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        FloydParser parser = new FloydParser(tokens);
        parser.removeErrorListener(ConsoleErrorListener.INSTANCE);
        parser.addErrorListener(new MyFloydErrorListener(parsedArgs));
        ParseTree tree = parser.start();
        ParseTreeWalker.DEFAULT.walk(new SemanticChecker(parsedArgs), tree);
        
        //Only proceed with code generation if there are no semantic errors.
        if (parsedArgs.semanticErrors == 0 && parser.getNumberOfSyntaxErrors() == 0 && libParser.getNumberOfSyntaxErrors() == 0) {
        	//generating code for the library first
        	CodeGen libraryCode = new CodeGen(libraryArgs, 0);
        	libraryCode.visit(libTree);
        	
        	//generating code for the main floyd file.
        	CodeGen mainCode = new CodeGen(parsedArgs, libraryArgs.labelCounter);
        	mainCode.visit(tree);
        	//appending library code to the main floyd code
        	mainCode.instructions.addAll(libraryCode.instructions);
        	//writing it out to a file. Also compiles it with the stdlib.c object file if the S bool is false;
        	mainCode.writeToFile(parsedArgs.s);
        	
        	
        } else {
        	System.out.println("Error: You must fix your errors or the code will not be generated.");
        }
        
        //if the dp switch is set, then show the user the tree.
        if (parsedArgs.dp) {
            Trees.inspect(tree, parser);
        }

    }

}

