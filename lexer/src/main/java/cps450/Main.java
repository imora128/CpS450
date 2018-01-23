// Main.java

package cps450;
import java.io.IOException;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.Token;


public class Main
{
    public static void main(String[] arguments) throws IOException {
        System.out.println();
        //both lexical errors and display tokens
        if(arguments.length == 2 && arguments[0].equals("-ds") )
        {
            //display toxens + lexical errors
            CharStream input = CharStreams.fromFileName(arguments[1]);
            FloydLexer lexer = new FloydLexer(input);
            
            // Read tokens from lexer
            Token t = lexer.nextToken();
            while (t.getType() != FloydLexer.EOF) {
                if (t.getType() == FloydLexer.CR) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "cr");
                }
                else if (t.getType() == FloydLexer.COMMENT) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "COMMENT");
                }
                else if (t.getType() == FloydLexer.IDENTIFIER) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "identifier:" + t.getText());
                }
                else if (t.getType() == FloydLexer.INTEGER_LITERAL) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":integer_literal:" + t.getText());
                }
                else if (t.getType() == FloydLexer.STRING_LITERAL) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":string lit:" + t.getText());
                }
                else if (t.getType() == FloydLexer.PREDEFINED_OPERATOR) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":operator:'" + t.getText() + "'");
                }
                else if (t.getType() == FloydLexer.ASSIGNMENT_OPERATOR) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
                }
                else if (t.getType() == FloydLexer.L_PAR) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
                }
                else if (t.getType() == FloydLexer.R_PAR) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
                }
                else if (t.getType() == FloydLexer.R_BRACKET) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
                }
                else if (t.getType() == FloydLexer.L_BRACKET) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
                }
                else if (t.getType() == FloydLexer.SEMICOLON) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
                }
                else if (t.getType() == FloydLexer.COLON) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
                }
                else if (t.getType() == FloydLexer.PERIOD) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":'" + t.getText() + "'");
                }
                else if (t.getType() == FloydLexer.BOOLEAN) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:boolean");
                }
                else if (t.getType() == FloydLexer.BEGIN) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:begin");
                }
                else if (t.getType() == FloydLexer.CLASS) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:class");
                }
                else if (t.getType() == FloydLexer.ELSE) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:else");
                }
                else if (t.getType() == FloydLexer.END) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:end");
                }
                else if (t.getType() == FloydLexer.FALSE) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:false");
                }
                else if (t.getType() == FloydLexer.FROM) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:from");
                }
                else if (t.getType() == FloydLexer.IF) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:if");
                }
                else if (t.getType() == FloydLexer.INHERITS) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:inherits");
                }
                else if (t.getType() == FloydLexer.INT) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:int");
                }
                else if (t.getType() == FloydLexer.IS) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:is");
                }
                else if (t.getType() == FloydLexer.LOOP) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:loop");
                }
                else if (t.getType() == FloydLexer.ME) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:me");
                }
                else if (t.getType() == FloydLexer.NEW) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:new");
                }
                else if (t.getType() == FloydLexer.NULL) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:null");
                }
                else if (t.getType() == FloydLexer.STRING) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:string");
                }
                else if (t.getType() == FloydLexer.THEN) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:then");
                }
                else if (t.getType() == FloydLexer.TRUE) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:true");
                }
                else if (t.getType() == FloydLexer.WHILE) {
                    System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getCharPositionInLine()+ ":" + "keyword:while");
                }
                

            //System.out.println(arguments[1] + ":" + t.getLine() + ":" + t.getText());
            t = lexer.nextToken();
        //display only lexical errors
        } 
        }else if (arguments.length == 1) { 
            System.out.println("DO ONLY LEXICAL ERRORS");
        }
        else {
            System.out.println("usage:");
            System.out.println("  lexer <filename>");
            System.exit(1);
        }

    }

}

