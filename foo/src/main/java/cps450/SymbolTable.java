/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: SymbolTable.java
Description: A class to manage the symbol table
*/
package cps450;
import java.util.List;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
public class SymbolTable {
    private static SymbolTable instance = null;
    int scope = 0;
    List<Symbol> symbolTable = new ArrayList<Symbol>();
    HashMap<String, Type> types = new HashMap<String,Type>();

    private SymbolTable () {;}
    public static SymbolTable getInstance() {
        if (instance == null) {
            instance = new SymbolTable();
        }
        return instance;
    }
    //FIXME(if method is already defined, don't push it into the table.)
    /*
    Desc: Pushes a new symbol entry onto the stack with the given name and decl information, 
    and the current scope level. It should return the new symbol entry
    */
    Symbol push(String name,Declaration decl) {
        SymbolTable symTable = getInstance();
        Symbol sym = new Symbol(name, getScope() , decl);
        symTable.symbolTable.add(sym);
        return sym;
    }

    void populatePredefinedTypes() {
    	types.put("<error>", Type.ERROR);
    	types.put("int", Type.INT);
    	types.put("boolean", Type.BOOLEAN);
    	types.put("string", Type.STRING);
    	types.put("reader", Type.READER);
    	types.put("void", Type.VOID);
    	types.put("writer", Type.WRITER);
    }
    
    void createType(String name) {
    	types.put(name, new Type(name));
    }
    
    /*
     * Desc:Searches for a symbol entry with name, starting at the top of the stack and working to the bottom. 
     * Returns the first Symbol entry found, or null if none.
     */
    Symbol lookup(String name) {
    	 SymbolTable symTable = getInstance();
    	 for (int i = symTable.symbolTable.size() - 1; i != -1; i-- ) {
    		 if (symTable.symbolTable.get(i).getName().equals(name)) {
    			 return symTable.symbolTable.get(i);
    		 }
    	 }
    	return null;
    }
    /*
     * Desc: Increments the current scope level. 
     */
    void beginScope() {
    	scope++;
    }
    
    /*
     * Desc: Returns the current scope level.
     */
    void endScope() {
    	SymbolTable symTable = getInstance();
    	if (scope > 0) {
       	 for (int i = symTable.symbolTable.size() - 1; i != -1; i-- ) {
    		 if (symTable.symbolTable.get(i).getScope() == scope) {
    			 symTable.symbolTable.remove(i);
    		 }
    	 }
    	scope--;
    	}
    	else {
    		throw new IllegalArgumentException("Scope level would dropw bellow 0");
    	}
    }
    
    /*
     * Desc: Returns the current scope
     */
    int getScope() {
    	return scope;
    }
    
    /*
     * Desc: For testing purposes
     */
    void printSymTable() {
    	 SymbolTable symTable = getInstance();
    	 System.out.print("size: " + symTable.symbolTable.size() + ": ");
      	 for (int i = symTable.symbolTable.size() - 1; i != -1; i-- ) {
   		 System.out.println("index: " + i + " name :" + symTable.symbolTable.get(i).getName() + 
   				 " scope: " + symTable.symbolTable.get(i).getScope() + "Type: " 
   				 + symTable.symbolTable.get(i).getDecl().type);
   	 }
    }
}