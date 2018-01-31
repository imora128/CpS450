package cps450;

import static org.junit.Assert.assertTrue;

import java.io.IOException;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.Token;
import org.junit.Test;

public class LexerTest {
	FloydLexer lex;

	@Test
	public void testSuccessfulScan() throws IOException {
		CharStream input = CharStreams.fromStream(
				getClass().getResourceAsStream("lexertest.txt"));
		lex = new FloydLexer(input);
		//mini program testing
		assertNextToken(FloydLexer.CLASS, "class");
		assertNextToken(FloydLexer.IDENTIFIER, "Main");
		assertNextToken(FloydLexer.IS, "is");
		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.IDENTIFIER, "pi");
		assertNextToken(FloydLexer.COLON, ":");
		assertNextToken(FloydLexer.INT, "int");
		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.STRING_LITERAL, "\"This is a string\"");
		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.END, "end");
		assertNextToken(FloydLexer.CR);
		//Keyword testing
		assertNextToken(FloydLexer.BOOLEAN, "boolean");
		assertNextToken(FloydLexer.BEGIN, "begin");
		assertNextToken(FloydLexer.ELSE, "else");
		assertNextToken(FloydLexer.END, "end");
		assertNextToken(FloydLexer.FALSE, "false");
		assertNextToken(FloydLexer.FROM, "from");
		assertNextToken(FloydLexer.IF, "if");
		assertNextToken(FloydLexer.INHERITS, "inherits");
		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.INT, "int");
		assertNextToken(FloydLexer.IS, "is");
		assertNextToken(FloydLexer.LOOP, "loop");
		assertNextToken(FloydLexer.ME, "me");
		assertNextToken(FloydLexer.NEW, "new");
		assertNextToken(FloydLexer.NULL, "null");
		assertNextToken(FloydLexer.STRING, "string");
		assertNextToken(FloydLexer.THEN, "then");
		assertNextToken(FloydLexer.TRUE, "true");
		assertNextToken(FloydLexer.WHILE, "while");
		assertNextToken(FloydLexer.CR);
		//keyword in capital letters should count as an identifier. Let's test.
		assertNextToken(FloydLexer.IDENTIFIER, "BEGIN");
		assertNextToken(FloydLexer.CR);
		//integer literal test. doing 35a to make sure it doesn't incude the a in the integer literal
		assertNextToken(FloydLexer.INTEGER_LITERAL, "35");
		assertNextToken(FloydLexer.IDENTIFIER, "a");
		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.AMPERSAND, "&");
		assertNextToken(FloydLexer.COLON, ":");
		assertNextToken(FloydLexer.PLUS, "+");
		assertNextToken(FloydLexer.TIMES, "*");
		assertNextToken(FloydLexer.DIV, "/");
		assertNextToken(FloydLexer.GT, ">");
		assertNextToken(FloydLexer.GE, ">=");
		assertNextToken(FloydLexer.EQ, "=");
		assertNextToken(FloydLexer.CR);

		//MISC tokens
		assertNextToken(FloydLexer.ASSIGNMENT_OPERATOR, ":=");
		assertNextToken(FloydLexer.R_PAR, "(");
		assertNextToken(FloydLexer.L_PAR, ")");
		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.R_BRACKET, "[");
		assertNextToken(FloydLexer.L_BRACKET, "]");
		assertNextToken(FloydLexer.COMMA, ",");
		assertNextToken(FloydLexer.SEMICOLON, ";");
		assertNextToken(FloydLexer.PERIOD, ".");

		//FIXED ambiguity with minus and integer literal
		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.INTEGER_LITERAL, "-94");
		assertNextToken(FloydLexer.MINUS);

		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.STRING_LITERAL);

		//ERRORS
		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.UNKNOWN_CHAR, "%");
		assertNextToken(FloydLexer.UNKNOWN_CHAR, "}");
		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.ILLEGAL_STRING_ERROR);
		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.UNTERMINATED_STRING_ERROR);
		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.STRING_LITERAL);
		assertNextToken(FloydLexer.STRING_LITERAL);
		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.AND);
		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.STRING_LITERAL);



	}

	private void assertNextToken(int type, String value) throws IOException {
		Token tok = lex.nextToken();
		System.err.println(tok.getLine() + ":" + tok.getCharPositionInLine() + ":" + tok.getText() + ":" + tok.getType());
		assertTrue(tok.getType() == type);
		assertTrue(tok.getText().equals(value));

	}

	private void assertNextToken(int type) throws IOException {
		Token tok = lex.nextToken();
		System.err.println(tok.getLine() + ":" + tok.getCharPositionInLine() + ":" + tok.getText());
		assertTrue(tok.getType() == type);
	}
}
