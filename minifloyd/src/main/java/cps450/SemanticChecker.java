package cps450;
import java.util.HashMap;
import java.util.Scanner;

import org.antlr.v4.runtime.Token;

import cps450.FloydParser.Assignment_stmtContext;
import cps450.FloydParser.ExpressionContext;
import cps450.FloydParser.TypeContext;
import cps450.FloydParser.Var_declContext;

public class SemanticChecker extends FloydBaseListener {
	//todo send up tree types n stuff
	SymbolTable symTable = SymbolTable.getInstance();
	@Override
	public void exitVar_decl(Var_declContext ctx) {
		
		//System.out.println(ctx.IDENTIFIER());
		symTable.push(ctx.IDENTIFIER().toString(), new VarDeclaration(Type.INT));
		super.exitVar_decl(ctx);
	}
	@Override
	public void exitAssignment_stmt(Assignment_stmtContext ctx) {
		super.exitAssignment_stmt(ctx);
	}
	@Override
	public void exitExpression(ExpressionContext ctx) {
		// TODO Auto-generated method stub
		super.exitExpression(ctx);
	}
	@Override
	public void exitType(TypeContext ctx) {
		super.exitType(ctx);
	}
	
	
	
	

}
