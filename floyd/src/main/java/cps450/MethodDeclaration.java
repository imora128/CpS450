/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: MethodDeclaration.java
Description: MethodDeclaration class to be used with the symbol table.
*/
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
	/*
	Function Name: GetOffset
	Description: Returns a method's offset (which is the return value section of the 
	stack
	*/
	public int getOffset() {
		return offset;
	}
	/*
	Function Name: setOffset
	Description: Sets the function offset from BP
	*/
	public void setOffset(int offset) {
		this.offset = offset;
	}

	/*
	Function Name: getParameters
	Description: Returns the parameter list of the method
	*/
	public List<VarDeclaration> getParameters() {
		return parameters;
	}
	
	/*
	Function Name: clearParameters
	Description: Clears the method parameter list
	*/
	public void clearParameters() {
		parameters.clear();
	}

	/*
	Function Name: appendParameter
	Description: Used to facilitate adding a parameter to the parameters list
	*/
	public void appendParameter(Type t, String n) {
		VarDeclaration foo = new VarDeclaration(t, n);
		parameters.add(foo);
		
	}
	
	/*
	Function Name: getVariables
	Description: Grabs the variable list
	*/
	public List<VarDeclaration> getVariables() {
		return variables;
	}

	/*
	Function Name: getVariables
	Description: Used to facilitate adding a variable to the variable list
	*/
	public void appendVariable(Type t, String n, int o) {
		VarDeclaration foo = new VarDeclaration(t, n);
		foo.setOffset(o);
		variables.add(foo);
	}
	
	
	
	
}
