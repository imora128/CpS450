package cps450;

import static org.junit.Assert.*;


import org.junit.Test;

public class SymbolTableTest {
	SymbolTable symTable = SymbolTable.getInstance();
	
	@Test
	public void testGetBeginScope() {
		assertTrue(symTable.getScope() == 0);
		symTable.beginScope();
		assertTrue(symTable.getScope() == 1);
		symTable.endScope();
		assertTrue(symTable.getScope() == 0);

	}

	
	@Test
	public void testPush() {
		Symbol s = symTable.push("x", new VarDeclaration(Type.INT, "x"));
	    assertTrue(s.getName().equals("x"));
	    assertTrue(s.getScope() == 0);

	    System.out.println("incrementing scope");
	    System.out.println();
	    symTable.beginScope();
	    s = symTable.push("y", new VarDeclaration(Type.STRING, "y"));
	    assertTrue(s.getScope() == 1);
	    assertTrue(s.getName().equals("y"));
	    symTable.printSymTable();
	
	    System.out.println("decremeting scope");
	    System.out.println();
		symTable.endScope();
		symTable.printSymTable();
		symTable.push("z", new VarDeclaration(Type.INT, "z"));
		
		assertTrue(symTable.getScope() == 0);
	}
	
	@Test
	public void testLookup() {
		assertTrue(symTable.lookup("x").getName().equals("x"));
		assertTrue(symTable.lookup("x").getScope() == 0);
		assertTrue(null == symTable.lookup("aoisd"));
		
	}
	
	
	//should throw an exception if I try to endscope right now
	//because current scope is 0, so it would go into -1.
	@Test(expected = IllegalArgumentException.class)
	public void endScopeFails() {
		symTable.endScope();
	}




}
