/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: ClassDeclaratin.java
Description: ClassDeclaration class to be used with the symbol table.
*/
package cps450;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ClassDeclaration extends Declaration {
	HashMap<String, MethodDeclaration> methods = new HashMap<String, MethodDeclaration>();
	List<VarDeclaration> vars = new ArrayList<VarDeclaration>();
	String name = "";
	/*
	Function Name: ClassDeclaration
	Description: Simple constructor
	*/
	public ClassDeclaration(String _name) {
		super();
		name = _name;
	}
	/*
	Function Name: appendMethod
	Description: Adds a method to the class declarations
	*/
	void appendMethod(String name, MethodDeclaration meth) {
		methods.put(name, meth);
	}
	/*
	Function Name: appendVar
	Description: Adds a variable to the class declaration
	*/
	void appendVar(VarDeclaration var) {
		vars.add(var);
	}
	
}
