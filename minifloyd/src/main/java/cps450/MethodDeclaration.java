package cps450;

import java.util.List;

public class MethodDeclaration extends Declaration {
	List<VarDeclaration> parameters;
	List<VarDeclaration> variables;

	public MethodDeclaration(Type varType) {
		super();
		type = varType;
	}
	
	
}
