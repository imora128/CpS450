package cps450;

public class MyError {
	boolean debugMode;
			
	void DEBUG(String msg) {
		if (debugMode) {
		System.out.println(msg);
		}
	}
	
	void error(String msg) {
		System.out.println("###########" + msg);
	}
	MyError(Boolean bool) {
		debugMode = bool;
	}

}
