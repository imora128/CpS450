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
	int localOffset;
    private static SymbolTable instance = null;
    int scope = 0;
    List<Symbol> symbolTable = new ArrayList<Symbol>();
    int stringLabelCounter = 0;

    private SymbolTable () {;}
    public static SymbolTable getInstance() {
        if (instance == null) {
            instance = new SymbolTable();
            
        }
        return instance;
    }
	/*
	Function Name: getLocalOffset
	Description: Returns the local variable offset.
	*/
    public int getLocalOffset() {
		return localOffset;
	}
	/*
	Function Name: setLocalOffset
	Description: Sets the local variable offset.
	*/
	public void setLocalOffset(int localOffset) {
		this.localOffset = localOffset;
	}
	/*
	 * Function Name: push
    Desc: Pushes a new symbol entry onto the stack with the given name and decl information, 
    and the current scope level. It should return the new symbol entry
    */
    Symbol push(String name,Declaration decl) {
        SymbolTable symTable = getInstance();
        Symbol sym = new Symbol(name, getScope() , decl);
        symTable.symbolTable.add(sym);
        return sym;
    }

    
    /* Name: lookup
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
    /*Name: beginScope()
     * Desc: Increments the current scope level. 
     */
    void beginScope() {
    	scope++;
    }
    
    /*Name: endScope
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
    
    /*Name: getScope
     * Desc: Returns the current scope
     */
    int getScope() {
    	return scope;
    }
    
    /*Name: printSymTable
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