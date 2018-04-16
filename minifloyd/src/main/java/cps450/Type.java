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
    STRING = new Type("String"),
    VOID = new Type("void");
    
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

	public static Type createType(ClassDeclaration decl) {
		//This method should create a new Type instance that stores a reference to decl in classDecl. 
		//Store the Type instance in the types map using the class name as the key.
		if (decl.name.equals("String")) {
			Type.STRING.setClassDecl(decl);
			types.put(decl.name, Type.STRING);
			return Type.STRING;
		}
		Type newType = new Type(decl.name);
		newType.classDecl = decl;
		types.put(decl.name, newType);

		return newType;
	}
	
	public static Type getTypeForName(String className) {
		//Return the Type instance from the types map, or null if no class with the given name has been defined.
		if (className.equals("String")) {
			return Type.STRING;
		} else if (className.equals("string")) {
			return Type.STRING;
		}
		return types.get(className);
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
