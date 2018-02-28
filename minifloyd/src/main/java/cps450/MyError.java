package cps450;

public class MyError {
	boolean debugMode;
			
	void DEBUG(String msg) {
		if (debugMode) {
		System.out.print(msg);
		}
	}
	
	MyError(Boolean bool) {
		debugMode = bool;
	}

}
