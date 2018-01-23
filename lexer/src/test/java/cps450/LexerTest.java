package cps450;

import static org.junit.Assert.assertTrue;

import java.io.IOException;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.Token;
import org.junit.Test;

public class LexerTest {
	//ArithmeticLexer lex;

	// @Test
	// public void testSuccessfulScan() throws IOException {
	// 	CharStream input = CharStreams.fromStream(
	// 			getClass().getResourceAsStream("lexertest.txt"));
	// 	lex = new ArithmeticLexer(input);

	// 	assertNextToken(ArithmeticLexer.SCIENTIFIC_NUMBER, "2.5");
	// 	assertNextToken(ArithmeticLexer.DIV);
	// 	assertNextToken(ArithmeticLexer.SCIENTIFIC_NUMBER, "3.6e12");
	// 	assertNextToken(ArithmeticLexer.EOF);

	FloydLexer lex;

	@Test
	public void testSuccessfulScan() throws IOException {
		CharStream input = CharStreams.fromStream(
				getClass().getResourceAsStream("lexertest.txt"));
		lex = new FloydLexer(input);

		assertNextToken(FloydLexer.CLASS, "class");
		assertNextToken(FloydLexer.IDENTIFIER, "Main");
		assertNextToken(FloydLexer.IS, "is");
		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.IDENTIFIER, "pi");
		assertNextToken(FloydLexer.COLON, ":");
		assertNextToken(FloydLexer.INT, "int");
		assertNextToken(FloydLexer.CR);
		assertNextToken(FloydLexer.STRING_LITERAL, "\"This is a string\"");


	}

	private void assertNextToken(int type, String value) throws IOException {
		Token tok = lex.nextToken();
		System.err.println(tok.getLine() + ":" + tok.getCharPositionInLine() + ":" + tok.getText());
		assertTrue(tok.getType() == type);
		assertTrue(tok.getText().equals(value));

	}

	private void assertNextToken(int type) throws IOException {
		Token tok = lex.nextToken();
		System.err.println(tok.getLine() + ":" + tok.getCharPositionInLine() + ":" + tok.getText());
		assertTrue(tok.getType() == type);
	}
}
