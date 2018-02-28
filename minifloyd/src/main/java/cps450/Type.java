package cps450;

public class Type {
    public static final Type 
    ERROR = new Type("<error>"),
    INT = new Type("int"),
    BOOLEAN = new Type("boolean"),
    STRING = new Type("string"),
    READER = new Type("reader"),
    WRITER = new Type("writer");
    
    protected String name;
    ClassDeclaration decl;
    //need to make a way for uder defined types to be made

	protected Type(String name) {
	    this.name = name;
	}
	//reader
	//writer
}
