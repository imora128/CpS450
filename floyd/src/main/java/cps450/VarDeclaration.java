/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: VarDeclaration.java
Description: VarDeclaration class to be used with the symbol table.
*/
package cps450;

public class VarDeclaration extends Declaration {
	String name = "";
	private int offset;
	public VarDeclaration(Type varType, String _name) {
		super();
		type = varType;
		name = _name;
	}
	/*
	Function Name: getOffset
	Description: Accessor method for variable offsets
	*/
	public int getOffset() {
		return offset;
	}
	/*
	Function Name: getOffset
	Description: Mutator method for variable offsets
	*/
	public void setOffset(int offset) {
		this.offset = offset;
	}
	

}
