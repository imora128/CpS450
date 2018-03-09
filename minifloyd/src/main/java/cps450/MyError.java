package cps450;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;

import java.util.HashMap;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
public class MyError {
	boolean debugMode;
	Option opt;
	HashMap<String, String> errMsgs = new HashMap<String, String>();
	
	void DEBUG(String msg) {
		if (debugMode) {
		System.out.println(msg);
		}
	}
//	void error(String msg) {
//		System.out.println(msg);
//		opt.semanticErrors++;
//	}
	
	void err(String msg, ParserRuleContext ctx) {
		System.err.println(String.format("%s:%d,%d:%s", opt.fileName.get(0),
				ctx.start.getLine(), ctx.start.getCharPositionInLine(), msg));
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
