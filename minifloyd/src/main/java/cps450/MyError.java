package cps450;

public class MyError {
	boolean debugMode;
	Option opt;
	void DEBUG(String msg) {
		if (debugMode) {
		System.out.println(msg);
		}
	}
	void error(String msg) {
		System.out.println(msg);
		opt.semanticErrors++;
	}
	MyError(Boolean bool) {
		debugMode = bool;
	}

}
