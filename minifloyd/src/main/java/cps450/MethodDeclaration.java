package cps450;

import java.util.ArrayList;
import java.util.List;

public class MethodDeclaration extends Declaration {
	List<VarDeclaration> parameters = new ArrayList<VarDeclaration>();
	List<VarDeclaration> variables = new ArrayList<VarDeclaration>();
	int offset;

	public MethodDeclaration(Type varType) {
		super();
		type = varType;
		offset = -4;
	}

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public List<VarDeclaration> getParameters() {
		return parameters;
	}
	
	public void clearParameters() {
		parameters.clear();
	}

	public void changeType(int i, Type t) {
		VarDeclaration moo = parameters.get(i);
		moo.type = t;
		parameters.set(i, moo);
	}
	public void appendParameter(Type t, String n) {
		VarDeclaration foo = new VarDeclaration(t, n);
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
