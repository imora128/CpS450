package cps450;

import java.util.ArrayList;
import java.util.List;

public class MethodDeclaration extends Declaration {
	List<VarDeclaration> parameters = new ArrayList<VarDeclaration>();
	List<VarDeclaration> variables = new ArrayList<VarDeclaration>();

	public MethodDeclaration(Type varType) {
		super();
		type = varType;
	}

	public List<VarDeclaration> getParameters() {
		return parameters;
	}


	public void appendParameter(Type t, String n, int o) {
		VarDeclaration foo = new VarDeclaration(t, n);
		foo.setOffset(o);
		parameters.add(foo);
		
	}
	public List<VarDeclaration> getVariables() {
		return variables;
	}

	public void appendVariable(Type t, String n, int o) {
		VarDeclaration foo = new VarDeclaration(t, n);
		foo.setOffset(o);
		variables.add(foo);
	}
	
	
	
	
}
