package cps450;

import java.util.ArrayList;
import java.util.Arrays;
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
    ClassDeclaration decl;

	protected Type(String name) {
	    this.name = name;
	}
	@Override
	public String toString() {
		return name;
	}

	
	
	//reader
	//writer
}
