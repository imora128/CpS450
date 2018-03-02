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

	public void setParameters(List<VarDeclaration> parameters) {
		this.parameters = parameters;
	}

	public void appendList(Type t, String n) {
		
		parameters.add(new VarDeclaration(t, n));
		//System.out.println("Iasdfasdfasdfasdfsadfasdfasdfasfasdfsdanside of this function" + "Size: " + parameters.size() + " myty" + this.type );
	}
	public List<VarDeclaration> getVariables() {
		return variables;
	}

	public void setVariables(List<VarDeclaration> variables) {
		this.variables = variables;
	}
	
	
	
	
}
