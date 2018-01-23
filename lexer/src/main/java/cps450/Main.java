/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: Main.java
Description: Contains the main body of the program
*/
package cps450;
import java.io.IOException;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.Token;

public class Main
{
    public static void main(String[] arguments) throws IOException {
        System.out.println();
        // if the user doesn't pass in any arguments, print usage and exit
        if (arguments.length < 1) {
            System.out.println("lexer [-ds] <filename>");
            System.exit(1);
        }
        //Creating an Option argument. Defined in opition.java.
        Option parsedArgs = new Option();
        //Parses the cmdline arguments so I can use it down bellow
        parsedArgs.getCommandLineArguments(arguments);
        //will worry about exception handling later
        CharStream input = CharStreams.fromFileName(parsedArgs.fileName);
        FloydLexer lexer = new FloydLexer(input);
        
        // Reads tokens from the lexer.
        //if "-ds" is given in the cmdline arguments, it will print out the tokens, their line numbers, and their position. Errors are printed
        //if "-ds" is not given, just the errors will be reported
        Token t = lexer.nextToken();
        //to(DO): Figure out if you can make a factory design pattern for this section. Might require some changes.
        while (t.getType() != FloydLexer.EOF) {
            //Matches the type to the index of the rules define in Floyd.g4
            if (t.getType() == FloydLexer.CR && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "cr");
            }
            else if (t.getType() == FloydLexer.COMMENT && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "THIS SHOULD NEVER APPEAR");
            }
            else if (t.getType() == FloydLexer.LINE_EXTENSION && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "THIS SHOULD ALSO NEVER APPEAR.");
            }
            else if (t.getType() == FloydLexer.IDENTIFIER && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "identifier:" + t.getText());
            }
            else if (t.getType() == FloydLexer.INTEGER_LITERAL && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":integer_literal:" + t.getText());
            }
            else if (t.getType() == FloydLexer.STRING_LITERAL && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":string lit:" + t.getText());
            }
            else if (t.getType() == FloydLexer.UNTERMINATED_STRING_ERROR) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":Unterminated string:\"Unterminated");
            }
            else if (t.getType() == FloydLexer.ILLEGAL_STRING_ERROR) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":Illegal string:" + t.getText());
            }
            else if (t.getType() == FloydLexer.UNKNOWN_CHAR) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":Unrecognized char: " + t.getText());
            }
            else if (t.getType() == FloydLexer.PREDEFINED_OPERATOR && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":operator:'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.ASSIGNMENT_OPERATOR && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.L_PAR && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.R_PAR && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.R_BRACKET && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.L_BRACKET && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.SEMICOLON && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.COLON && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.PERIOD && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.BOOLEAN && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:boolean");
            }
            else if (t.getType() == FloydLexer.BEGIN && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:begin");
            }
            else if (t.getType() == FloydLexer.CLASS && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:class");
            }
            else if (t.getType() == FloydLexer.ELSE && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:else");
            }
            else if (t.getType() == FloydLexer.END && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:end");
            }
            else if (t.getType() == FloydLexer.FALSE && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:false");
            }
            else if (t.getType() == FloydLexer.FROM && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:from");
            }
            else if (t.getType() == FloydLexer.IF && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:if");
            }
            else if (t.getType() == FloydLexer.INHERITS && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:inherits");
            }
            else if (t.getType() == FloydLexer.INT && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:int");
            }
            else if (t.getType() == FloydLexer.IS && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:is");
            }
            else if (t.getType() == FloydLexer.LOOP && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:loop");
            }
            else if (t.getType() == FloydLexer.ME && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:me");
            }
            else if (t.getType() == FloydLexer.NEW && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:new");
            }
            else if (t.getType() == FloydLexer.NULL && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:null");
            }
            else if (t.getType() == FloydLexer.STRING && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:string");
            }
            else if (t.getType() == FloydLexer.THEN && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:then");
            }
            else if (t.getType() == FloydLexer.TRUE && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:true");
            }
            else if (t.getType() == FloydLexer.WHILE && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + t.getCharPositionInLine()+ ":" + "keyword:while");
            }
            

        t = lexer.nextToken();
    }  

    }

}

