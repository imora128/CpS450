/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: Symbol.java
Description: A class defining symbols
*/
package cps450;

public class Symbol {
    private String name;
    private int scope;
    private Declaration decl; //attributes

    Symbol (String _name, int _scope, Declaration _decl) {
        setScope(_scope);
        setName(_name);
        setDecl(_decl);
    }

	/*
	Function Name: getScope
	Description: Returns the scope
	*/
	public int getScope() {
		return scope;
	}

	/*
	Function Name: setScope
	Description: Sets the scope
	*/
	public void setScope(int scope) {
		this.scope = scope;
	}

	/*
	Function Name: getDecl
	Description: Gets the declaration type.
	*/
	public Declaration getDecl() {
		return decl;
	}

	/*
	Function Name: setDecl
	Description: Sets the declaration type.
	*/
	public void setDecl(Declaration decl) {
		this.decl = decl;
	}

	/*
	Function Name: getName
	Description: Gets symbol name
	*/
	public String getName() {
		return name;
	}

	/*
	Function Name: setName
	Description: Sets the name
	*/
	public void setName(String name) {
		this.name = name;
	}
	

}