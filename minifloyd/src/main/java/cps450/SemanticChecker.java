package cps450;
import java.util.HashMap;
import java.util.Scanner;

import org.antlr.v4.runtime.Token;

import cps450.FloydParser.Assignment_stmtContext;
import cps450.FloydParser.ExpressionContext;
import cps450.FloydParser.TypeBoolContext;
import cps450.FloydParser.TypeContext;
import cps450.FloydParser.Var_declContext;
import cps450.FloydParser.TypeIntContext;
import cps450.FloydParser.TypeStringContext;


public class SemanticChecker extends FloydBaseListener {
	//todo send up tree types n stuff
	SymbolTable symTable = SymbolTable.getInstance();
	MyError print = new MyError();
	
	//TODO(:= Expr version of var_decl & Errors)
	@Override
	public void exitVar_decl(Var_declContext ctx) {
		print.DEBUG("Variable declared: " + ctx.IDENTIFIER().toString() + " Type: " + ctx.type().myType + "\n");
		
		super.exitVar_decl(ctx);
	}
	
	//TODO(Assignment statement, which requires expression & errors)
	@Override
	public void exitAssignment_stmt(Assignment_stmtContext ctx) {
		super.exitAssignment_stmt(ctx);
	}
	//TODO(Return type from expression. & Errors)
	@Override
	public void exitExpression(ExpressionContext ctx) {
		
		super.exitExpression(ctx);
	}
	
	
	
	@Override
	public void exitTypeInt(TypeIntContext ctx) {
		ctx.myType = Type.INT;
	}
	@Override
	public void enterTypeString(TypeStringContext ctx) {
		ctx.myType = Type.STRING;
		super.enterTypeString(ctx);
	}
	@Override
	public void enterTypeBool(TypeBoolContext ctx) {
		ctx.myType = Type.BOOLEAN;
		super.enterTypeBool(ctx);
	}
	
	
	
	

}
