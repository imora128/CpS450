/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: Type.java
Description: Type class to be used both in semantic checking and code generation
*/
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
	
	/*
	Function Name: getClassDecl
	Description: Accessor method for classDEcl
	*/
	public ClassDeclaration getClassDecl() {
		return classDecl;
	}
	/*
	Function Name: setClassDecl
	Description: Mutator method for classDEcl
	*/
	public void setClassDecl(ClassDeclaration classDecl) {
		this.classDecl = classDecl;
	}
	
	/*
	Function Name: CreateType
	Description: Creates a user defined type for the corresponding class
	*/
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
	
	/*
	Function Name: ClassDeclaration
	Description: Return the Type instance from the types map, or null if no class with the given name has been defined.
	*/
	public static Type getTypeForName(String className) {
		if (className.equals("String")) {
			return Type.STRING;
		} else if (className.equals("string")) {
			return Type.STRING;
		}
		return types.get(className);
	}

	@Override
	public String toString() {
		return name;
	}
	

}
