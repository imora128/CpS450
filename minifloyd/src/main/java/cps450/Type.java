package cps450;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class Type {
    public static final Type 
    ERROR = new Type("<error>"),
    INT = new Type("int"),
    BOOLEAN = new Type("boolean"),
    STRING = new Type("string"),
    READER = new Type("reader"),
    VOID = new Type("void"),
    WRITER = new Type("writer");
    
    protected String name;
    private ClassDeclaration classDecl;
    private static HashMap<String, Type> types =  new HashMap<String,Type>();

	protected Type(String name) {
	    this.name = name;
	}
	
	public ClassDeclaration getClassDecl() {
		return classDecl;
	}

	public void setClassDecl(ClassDeclaration classDecl) {
		this.classDecl = classDecl;
	}

	public static Type createType(ClassDeclaration decl, String name) {
		//This method should create a new Type instance that stores a reference to decl in classDecl. 
		//Store the Type instance in the types map using the class name as the key.
		Type newType = new Type(name);
		newType.classDecl = decl;
		types.put(name, newType);
		return newType;
	}
	
	public static Type getTypeForName(String className) {
		//Return the Type instance from the types map, or null if no class with the given name has been defined.
		return types.get("className");
	}
	@Override
	public boolean equals(Object obj) {
		//System.out.println("obj: " + obj + " this is: " + this);
		if (obj == Type.ERROR) {
			return true;
		}
		return super.equals(obj);
	}

	@Override
	public String toString() {
		return name;
	}
	


	
	

	
	
	//reader
	//writer
}
