package cps450;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ClassDeclaration extends Declaration {
	HashMap<String, MethodDeclaration> methods = new HashMap<String, MethodDeclaration>();
	List<VarDeclaration> vars = new ArrayList<VarDeclaration>();
	
	public ClassDeclaration(Type varType) {
		super();
		type = varType;
	}
	void appendMethod(String name, MethodDeclaration meth) {
		methods.put(name, meth);
	}
	void appendVar(VarDeclaration var) {
		vars.add(var);
	}
	
}
