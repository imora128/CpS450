/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: MyFloydLexerErrorListener.java
Description: Prints out errors from the parser's side
*/
package cps450;

import org.antlr.v4.runtime.ConsoleErrorListener;
import org.antlr.v4.runtime.RecognitionException;
import org.antlr.v4.runtime.Recognizer;

public class MyFloydErrorListener extends ConsoleErrorListener {
	Option parsedArgs;
	public MyFloydErrorListener(Option _parsedArgs) {
		parsedArgs = _parsedArgs;
	}
	@Override
	public void syntaxError(Recognizer<?, ?> recognizer,
							Object offendingSymbol,
							int line,
							int charPositionInLine,
							String msg,
							RecognitionException e)
	{
		System.err.println(parsedArgs.fileName.get(0) + ":" +  line + "," + charPositionInLine + ":" + msg);
		//stack trace if dp is given as an arg
		if (e != null && parsedArgs.dp == true)
			e.printStackTrace();
	}
}
