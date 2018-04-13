package cps450;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;

import java.util.HashMap;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;


public class MyError {
	//for error colors https://stackoverflow.com/questions/5762491/how-to-print-color-in-console-using-system-out-println
	public static final String ANSI_RESET = "\u001B[0m";
	public static final String ANSI_BLACK = "\u001B[30m";
	public static final String ANSI_RED = "\u001B[31m";
	public static final String ANSI_GREEN = "\u001B[32m";
	boolean debugMode;
	Option opt;
	HashMap<String, String> errMsgs = new HashMap<String, String>();
	
	void DEBUG(String msg) {
		if (debugMode) {
		System.err.println(ANSI_GREEN + msg + ANSI_RESET);
		}
	}
	
	void err(String msg, ParserRuleContext ctx) {
		System.err.println( String.format(ANSI_RED + "%s:%d,%d:%s", opt.fileName.get(0),
				ctx.start.getLine(), ctx.start.getCharPositionInLine(), msg) + ANSI_RESET);
		opt.semanticErrors++;
	}
	

	MyError(Boolean bool) {
		debugMode = bool;
		errMsgs.put("Unsupported","Unsupported feature: %s");
		errMsgs.put("RedefineVar","Attempting to redefine variable %s in the same scope");
		errMsgs.put("BadVarType","Variable type does not exist or is not provided");
		errMsgs.put("RedefineVar","Attempting to redefine variable %s in the same scope");
		errMsgs.put("AssMismatch","Type mismatch in assignment statement. %s expected on RHS, got %s");
		errMsgs.put("UndefinedVar", "Trying to use undefined variable %s");
		errMsgs.put("TypeMismatch", "Type mismatch for %s: Expected %s but got %s");
		errMsgs.put("ParameterMismatch", "Parameter expected type: %s, got %s");
		errMsgs.put("UndefinedFunction", "Attempting to call undefined function %s");
		errMsgs.put("ParameterNumberMismatch", "Number of expected parameters: %s, got %s");
		
	}

}
