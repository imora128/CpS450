/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: MyFloydLexer
Description: Overrides nextToken to print out debug output if -ds is true. Also keeps track of # 
of lexer errors.
*/
package cps450;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;

public class MyFloydLexer extends FloydLexer {
	
	boolean dumpTokens;
    Option parsedArgs;
    int lexerErrors;
	public MyFloydLexer(CharStream input, boolean dumpTokens, Option parsedArgs) {
		super(input);
		this.dumpTokens = dumpTokens;
        this.parsedArgs = parsedArgs;
        this.lexerErrors = 0;
	}

	@Override
	public Token nextToken() {
		Token t = super.nextToken();
        //will return nextToken() if it ever hits any errors, b/c
        //i'm not supposed to give the parser bad tokens.
		if (dumpTokens) {
			if (t.getType() == FloydLexer.CR ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "cr");
            }
            else if (t.getType() == FloydLexer.COMMENT ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "THIS SHOULD NEVER APPEAR");
            }
            else if (t.getType() == FloydLexer.LINE_EXTENSION ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "THIS SHOULD ALSO NEVER APPEAR.");
            }
            else if (t.getType() == FloydLexer.IDENTIFIER ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "identifier:" + t.getText());
            }
            else if (t.getType() == FloydLexer.INTEGER_LITERAL ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":int lit:" + t.getText());
            }
            else if (t.getType() == FloydLexer.STRING_LITERAL ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":string lit:" + t.getText());
            }
            else if (t.getType() == FloydLexer.UNTERMINATED_STRING_ERROR) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":Unterminated string:\"An unterminated string...");
                //do not return illegal tokens. skip to the next
                lexerErrors++;
                return nextToken();
            }
            else if (t.getType() == FloydLexer.ILLEGAL_STRING_ERROR) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":Illegal string:" + t.getText());
                //do not return illegal tokens. skip to the next
                lexerErrors++;
                return nextToken();
            }
            else if (t.getType() == FloydLexer.UNKNOWN_CHAR) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":Unrecognized char: " + t.getText());
                //do not return illegal tokens. skip to the next
                lexerErrors++;
                return nextToken();
            }
            else if (t.getType() == FloydLexer.AMPERSAND ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":operator:'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.PLUS ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":operator:'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.MINUS ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":operator:'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.TIMES ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":operator:'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.DIV ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":operator:'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.GT ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":operator:'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.GE ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.EQ ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":operator:'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.L_PAR ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.R_PAR ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.R_BRACKET ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.L_BRACKET ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.SEMICOLON ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.COLON ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.PERIOD ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":'" + t.getText() + "'");
            }
            else if (t.getType() == FloydLexer.BOOLEAN ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:boolean");
            }
            else if (t.getType() == FloydLexer.BEGIN ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:begin");
            }
            else if (t.getType() == FloydLexer.CLASS ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:class");
            }
            else if (t.getType() == FloydLexer.ELSE ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:else");
            }
            else if (t.getType() == FloydLexer.END ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:end");
            }
            else if (t.getType() == FloydLexer.FALSE ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:false");
            }
            else if (t.getType() == FloydLexer.FROM ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:from");
            }
            else if (t.getType() == FloydLexer.IF ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:if");
            }
            else if (t.getType() == FloydLexer.INHERITS ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:inherits");
            }
            else if (t.getType() == FloydLexer.INT ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:int");
            }
            else if (t.getType() == FloydLexer.IS ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:is");
            }
            else if (t.getType() == FloydLexer.LOOP ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:loop");
            }
            else if (t.getType() == FloydLexer.ME ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:me");
            }
            else if (t.getType() == FloydLexer.NEW ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:new");
            }
            else if (t.getType() == FloydLexer.NULL ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:null");
            }
            else if (t.getType() == FloydLexer.STRING ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:string");
            }
            else if (t.getType() == FloydLexer.THEN ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:then");
            }
            else if (t.getType() == FloydLexer.TRUE ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:true");
            }
            else if (t.getType() == FloydLexer.WHILE ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:while");
            }
            else if (t.getType() == FloydLexer.AND ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:and");
            }
            else if (t.getType() == FloydLexer.NOT ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:not");
            }
            else if (t.getType() == FloydLexer.OR ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "keyword:or");
            }
            else if (t.getType() == FloydLexer.ASSIGNMENT_OPERATOR ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "':='");
            }
            else if (t.getType() == FloydLexer.COMMA ) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":" + "','");
            }
		} else {
            if (t.getType() == FloydLexer.UNTERMINATED_STRING_ERROR) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":Unterminated string:\"An unterminated string...");
                //do not return illegal tokens. skip to the next
                lexerErrors++;
                return nextToken();
            }
            else if (t.getType() == FloydLexer.ILLEGAL_STRING_ERROR) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":Illegal string:" + t.getText());
                //do not return illegal tokens. skip to the next
                lexerErrors++;
                return nextToken();
            }
            else if (t.getType() == FloydLexer.UNKNOWN_CHAR) {
                System.out.println(parsedArgs.fileName.get(0) + ":" + t.getLine() + "," + (t.getCharPositionInLine() + 1)+ ":Unrecognized char: " + t.getText());
                //do not return illegal tokens. skip to the next
                lexerErrors++;
                return nextToken();
            }
        }
		return t;
	}

}