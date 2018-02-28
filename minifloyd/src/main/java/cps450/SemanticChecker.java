package cps450;
import java.util.HashMap;
import java.util.Scanner;

import org.antlr.v4.runtime.Token;

import cps450.FloydParser.Add_expContext;
import cps450.FloydParser.And_expContext;
import cps450.FloydParser.Assignment_stmtContext;
import cps450.FloydParser.Concat_expContext;
import cps450.FloydParser.ExprCont_FalseContext;
import cps450.FloydParser.ExprCont_IDContext;
import cps450.FloydParser.ExpressionContext;
import cps450.FloydParser.Method_expContext;
import cps450.FloydParser.Methodexpr_ContContext;
import cps450.FloydParser.Multi_expContext;
import cps450.FloydParser.Or_expContext;
import cps450.FloydParser.Relational_expContext;
import cps450.FloydParser.TypeBoolContext;
import cps450.FloydParser.TypeContext;
import cps450.FloydParser.TypeIDContext;
import cps450.FloydParser.Var_declContext;
import cps450.FloydParser.TypeIntContext;
import cps450.FloydParser.TypeStringContext;
import cps450.FloydParser.UnaryMethod_ExpContext;
import cps450.FloydParser.Unary_expContext;
import cps450.FloydParser.ExprCont_StrlitContext;
import cps450.FloydParser.ExprCont_TrueContext;
import cps450.FloydParser.ExprCont_IntlitContext;
import cps450.FloydParser.UnaryNot_ExpContext;


public class SemanticChecker extends FloydBaseListener {
	//todo send up tree types n stuff
	SymbolTable symTable = SymbolTable.getInstance();
	MyError print = new MyError(true);
	
	//TODO(:= Expr version of var_decl & Errors)
	@Override
	public void exitVar_decl(Var_declContext ctx) {
		symTable.push(ctx.IDENTIFIER().toString(),new VarDeclaration(ctx.type().myType));
		print.DEBUG("Variable declared: " + ctx.IDENTIFIER().toString() +
				" Type: " + ctx.type().myType);
		
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
	public void exitUnaryNot_Exp(UnaryNot_ExpContext ctx) {
		print.DEBUG("exitUnaryNot: " + ctx.unary_exp().myType);
		if (ctx.unary_exp().myType == Type.BOOLEAN) {
			print.DEBUG("It's a boolean, we're ok.");
		}
		else {
			print.DEBUG("Not a boolean, error.");
		}
		//super.enterUnaryNot_Exp(ctx);
	}
	
	

	@Override
	public void exitUnaryMethod_Exp(UnaryMethod_ExpContext ctx) {
		print.DEBUG("exitUnaryMethod. ctx.method_exp is: " + ctx.method_exp().myType);
		if (ctx.method_exp().myType != null) {
			ctx.myType = ctx.method_exp().myType;
		}
		else
		{
			throw new RuntimeException("exitUnaryMethod shows method_exp is null");
		}
		super.exitUnaryMethod_Exp(ctx);
	}

	@Override
	public void exitMethodexpr_Cont(Methodexpr_ContContext ctx) {
		print.DEBUG("in exitmethodexpr_cont. type: " + ctx.expr_cont().myType);
		ctx.myType = ctx.expr_cont().myType;
		
		super.exitMethodexpr_Cont(ctx);
	}
	

	//TODO(ExprCont_ID, exprCont_Null, ExprCont_ME,ExprCont_ParExp, ExprCont_Array, ExprCont_IDExpr)
	@Override
	public void exitExprCont_Strlit(ExprCont_StrlitContext ctx) {
		//print.DEBUG("ExprCont_Strlit passing the type");
		ctx.myType = Type.STRING;
		super.enterExprCont_Strlit(ctx);
	}
	
	
	@Override
	public void exitExprCont_Intlit(ExprCont_IntlitContext ctx) {
		//print.DEBUG("ExprCont_Intlit passing the type");
		ctx.myType = Type.INT;
		super.enterExprCont_Intlit(ctx);
	}
	
	
	
	@Override
	public void exitExprCont_True(ExprCont_TrueContext ctx) {
		print.DEBUG("ExprCont_True passing the type");
		ctx.myType = Type.BOOLEAN;
		super.exitExprCont_True(ctx);
	}

	@Override
	public void exitExprCont_False(ExprCont_FalseContext ctx) {
		print.DEBUG("ExprCont_False passing the type");
		ctx.myType = Type.BOOLEAN;
		super.exitExprCont_False(ctx);
	}
	
	
	//TODO(Fix this temporary error msg system. pass token & use it in error class)
	@Override
	public void exitExprCont_ID(ExprCont_IDContext ctx) {
		Symbol sym = symTable.lookup(ctx.IDENTIFIER().getText());
		if (sym != null) {
			print.DEBUG("FOUND THE SYMBOL");
			ctx.myType = sym.getDecl().type;
		}
		else {
			throw new RuntimeException("Use of undeclared variable" + ctx.IDENTIFIER().getText());
		}
		
		//ctx.IDENTIFIER().getText()
		super.exitExprCont_ID(ctx);
	}

	//TODO(typeID)
	@Override
	public void exitTypeInt(TypeIntContext ctx) {
		ctx.myType = Type.INT;
	}
	@Override
	public void exitTypeString(TypeStringContext ctx) {
		ctx.myType = Type.STRING;
		super.enterTypeString(ctx);
	}
	@Override
	public void exitTypeBool(TypeBoolContext ctx) {
		ctx.myType = Type.BOOLEAN;
		super.enterTypeBool(ctx);
	}

//	//TODO(Fix error msg)
//	@Override
//	public void exitTypeID(TypeIDContext ctx) {
//		Symbol sym = symTable.lookup(ctx.IDENTIFIER().getText());
//		if (sym != null) {
//			print.DEBUG("FOUND THE SYMBOL");
//			ctx.myType = sym.getDecl().type;
//		}
//		else {
//			throw new RuntimeException("Use of undeclared variable" + ctx.IDENTIFIER().getText());
//		}
//		super.exitTypeID(ctx);
//	}
//	
	
	
	
	
	

}
