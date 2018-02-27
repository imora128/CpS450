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

	public int getScope() {
		return scope;
	}

	public void setScope(int scope) {
		this.scope = scope;
	}

	public Declaration getDecl() {
		return decl;
	}

	public void setDecl(Declaration decl) {
		this.decl = decl;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	

}