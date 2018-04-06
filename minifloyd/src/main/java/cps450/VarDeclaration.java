package cps450;

public class VarDeclaration extends Declaration {
	String name = "";
	private int offset;
	public VarDeclaration(Type varType, String _name) {
		super();
		type = varType;
		name = _name;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	

}
