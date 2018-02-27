package cps450;

import java.util.List;

public class ClassDeclaration extends Declaration {
	List<MethodDeclaration> methods;
	List<VarDeclaration> vars;
	
	public ClassDeclaration(List<MethodDeclaration> methods, List<VarDeclaration> vars) {
		super();
		this.methods = methods;
		this.vars = vars;
	}
	
}
