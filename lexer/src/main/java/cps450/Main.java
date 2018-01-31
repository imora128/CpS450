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
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "cr");
            }
            else if (t.getType() == FloydLexer.COMMENT && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "THIS SHOULD NEVER APPEAR");
            }
            else if (t.getType() == FloydLexer.LINE_EXTENSION && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "THIS SHOULD ALSO NEVER APPEAR.");
            }
            else if (t.getType() == FloydLexer.IDENTIFIER && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "identifier:" + t.getText());
            }
            else if (t.getType() == FloydLexer.INTEGER_LITERAL && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":integer_literal:" + t.getText());
            }
            else if (t.getType() == FloydLexer.STRING_LITERAL && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":string lit:" + t.getText());
            }
            else if (t.getType() == FloydLexer.UNTERMINATED_STRING_ERROR) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":Unterminated string:\"An unterminated string...");
            }
            else if (t.getType() == FloydLexer.ILLEGAL_STRING_ERROR) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":Illegal string:" + t.getText());
            }
            else if (t.getType() == FloydLexer.UNKNOWN_CHAR) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":Unrecognized char: " + t.getText());
            }
            else if (t.getType() == FloydLexer.AMPERSAND && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":operator:'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.PLUS && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":operator:'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.MINUS && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":operator:'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.TIMES && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":operator:'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.DIV && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":operator:'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.GT && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":operator:'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.GE && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.EQ && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":operator:'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.L_PAR && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.R_PAR && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.R_BRACKET && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.L_BRACKET && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.SEMICOLON && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.COLON && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.PERIOD && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.BOOLEAN && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:boolean");
            }
            else if (t.getType() == FloydLexer.BEGIN && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:begin");
            }
            else if (t.getType() == FloydLexer.CLASS && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:class");
            }
            else if (t.getType() == FloydLexer.ELSE && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:else");
            }
            else if (t.getType() == FloydLexer.END && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:end");
            }
            else if (t.getType() == FloydLexer.FALSE && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:false");
            }
            else if (t.getType() == FloydLexer.FROM && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:from");
            }
            else if (t.getType() == FloydLexer.IF && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:if");
            }
            else if (t.getType() == FloydLexer.INHERITS && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:inherits");
            }
            else if (t.getType() == FloydLexer.INT && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:int");
            }
            else if (t.getType() == FloydLexer.IS && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:is");
            }
            else if (t.getType() == FloydLexer.LOOP && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:loop");
            }
            else if (t.getType() == FloydLexer.ME && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:me");
            }
            else if (t.getType() == FloydLexer.NEW && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:new");
            }
            else if (t.getType() == FloydLexer.NULL && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:null");
            }
            else if (t.getType() == FloydLexer.STRING && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:string");
            }
            else if (t.getType() == FloydLexer.THEN && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:then");
            }
            else if (t.getType() == FloydLexer.TRUE && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:true");
            }
            else if (t.getType() == FloydLexer.WHILE && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:while");
            }
            else if (t.getType() == FloydLexer.AND && parsedArgs.ds == true) {
                System.out.println(parsedArgs.fileName + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:and");
            }
            

        t = lexer.nextToken();
    }  

    }

}

